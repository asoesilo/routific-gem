require 'rest-client'
require 'json'

require_relative './routific/location'
require_relative './routific/visit'
require_relative './routific/vehicle'
require_relative './routific/route'
require_relative './routific/way_point'

# Main class of this gem
class Routific
  Error           = Class.new(StandardError)
  InvalidEndpoint = Class.new(Error)

  ENDPOINTS = %i(vrp vrp-long pdp pdp-long)

  @@endpoint = ENDPOINTS.first

  attr_reader :token, :visits, :fleet, :endpoint

  # Constructor
  # token: Access token for Routific API
  def initialize(token)
    @token = token
    @visits = {}
    @fleet = {}
    @endpoint = @@endpoint
  end

  def endpoint=(value)
    raise InvalidEndpoint unless ENDPOINTS.include?(value.to_sym)
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
    # Sets the default access token to use
    def setToken(token)
      @@token = token
    end

    def token
      @@token
    end

    def endpoint
      @@endpoint
    end

    def endpoint=(value)
      raise InvalidEndpoint unless ENDPOINTS.include?(value.to_sym)
      @@endpoint = value
    end

    # Returns the route using the specified access token, visits and fleet information
    # If no access token is provided, the default access token previously set is used
    # If the default access token either is nil or has not been set, an ArgumentError is raised
    def getRoute(data, token = @@token, endpoint = @@endpoint)
      if token.nil?
        raise ArgumentError, "access token must be set"
      end

      # Prefix the token with "bearer " if missing during assignment
      prefixed_token = (/bearer /.match(token).nil?) ? "bearer #{token}" : token

      begin
        # Sends HTTP request to Routific API server
        response = RestClient.post("https://api.routific.com/v1/#{endpoint}",
          data.to_json,
          'Authorization' => prefixed_token,
          content_type: :json,
          accept: :json
          )

        # Parse the HTTP request response to JSON
        jsonResponse = JSON.parse(response)

        # Parse the JSON representation into a RoutificApi::Route object
        RoutificApi::Route.parse(jsonResponse)
      rescue => e
        puts e
        errorResponse = JSON.parse e.response.body
        puts "Received HTTP #{e.message}: #{errorResponse["error"]}"
        nil
      end
    end
  end
end
