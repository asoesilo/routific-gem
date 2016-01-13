require 'rest-client'
require 'json'
require 'logger'

require_relative './routific/location'
require_relative './routific/visit'
require_relative './routific/vehicle'
require_relative './routific/route'
require_relative './routific/way_point'
require_relative './routific/job'

# Main class of this gem
class Routific
  Error           = Class.new(StandardError)
  RequestError    = Class.new(Error)
  InvalidEndpoint = Class.new(Error)

  ENDPOINTS = [:vrp, :'vrp-long', :pdp, :'pdp-long']

  @token    = nil
  @endpoint = ENDPOINTS.first
  @timeout  = 20

  attr_reader :token, :visits, :fleet, :endpoint

  # Constructor
  # token: Access token for Routific API
  def initialize(token = self.class.token)
    @token = token
    @visits = {}
    @fleet = {}
    @endpoint = self.class.endpoint
  end

  def endpoint=(value)
    self.class.check_endpoint! value
    @endpoint = value
  end

  # Sets a visit for the specified location using the specified parameters
  # id: ID of location to visit
  # params: parameters for this visit
  def setVisit(id, params={})
    visits[id] = RoutificApi::Visit.new(id, params)
  end

  # Sets a vehicle with the specified ID and parameters
  # id: vehicle ID
  # params: parameters for this vehicle
  def setVehicle(id, params)
    fleet[id] = RoutificApi::Vehicle.new(id, params)
  end

  # Returns the route using the previously provided visits and fleet information
  def getRoute
    data = {
      visits: visits,
      fleet: fleet
    }

    Routific.getRoute(data, token, endpoint)
  end

  class << self
    attr_reader :token, :endpoint, :log_requests, :raise_on_exception

    # Sets the default access token to use
    def setToken(token)
      @token = token
    end

    def setLogger(logger)
      @logger = logger
    end

    def setLogRequests(value)
      @log_requests = value
    end

    # should be the default, applications can decide to rescue exceptions
    def setRaiseOnException(flag)
      @raise_on_exception = flag
    end

    def logger
      @logger ||= Logger.new($stdout)
    end

    def endpoint=(value)
      check_endpoint! value
      @endpoint = value
    end

    def getRoute(data, token = @token, endpoint = @endpoint)
      data = format_timestamps(data)

      json = request path:   "v1/#{endpoint}",
                     method: :post,
                     data:   data.to_json,
                     token:  token
      if json
        if endpoint =~ /-long\z/
          RoutificApi::Job.new(id: json['job_id'])
        else
          RoutificApi::Route.parse(json)
        end
      end
    end

    def job(job_id, token = @token)
      json = request path:   "jobs/#{job_id}",
                     method: :get,
                     token:  token
      if json
        RoutificApi::Job.parse(json)
      end
    end

    def check_endpoint!(endpoint)
      raise InvalidEndpoint unless ENDPOINTS.include?(endpoint.to_sym)
    end

    private

    def request(options)
      args = build_request_arguments(options)
      do_request(args)
    end

    def build_request_arguments(options)
      path   = options.fetch :path
      method = options.fetch :method
      token  = options.fetch :token
      data   = options.fetch :data, nil

      if token.nil?
        raise ArgumentError, 'Access token must be set.'
      end

      # Prefix the token with "bearer " if missing
      unless token =~ /\Abearer /
        token = "bearer #{token}"
      end

      unless [:get, :post].include?(method.to_sym)
        raise ArgumentError, 'Only GET and POST methods are supported.'
      end

      args = {
        method:  method,
        url:     "https://api.routific.com/#{path}",
        timeout: @timeout,
        headers: {
          authorization: token,
          content_type:  :json,
          accept:        :json
        }
      }

      if method.to_sym == :post && data
        args[:payload] = data
      end
      args
    end

    def do_request(args)
      begin
        response = RestClient::Request.execute args

        logger.info(response) if log_requests
        JSON.parse(response)
      rescue => error
        if raise_on_exception
          raise RequestError.new(error)
        else
          logger.error(error)
          errorResponse = JSON.parse error.response.body
          logger.error("Received HTTP #{error.message}: #{errorResponse["error"]}")
          nil
        end
      end
    end

    def format_timestamps(data)
      data.each_with_object({}) do |(key, value), hash|
        hash[key] = if value.is_a?(Hash)
                    format_timestamps(value)
                  elsif value.respond_to?(:strftime)
                    value.strftime('%H:%M').sub(/\A0/, '')
                  else
                    value
                  end
      end
    end
  end
end
