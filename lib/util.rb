require 'rest-client'
require 'json'

module Util
  BASE_URL = 'https://api.routific.com/v1/'

  ##
  # method: "GET", "POST"
  # endpoint: "vrp", "vrp-long", "job"
  # token: if nil, raise ArgumentError; if missing "bearer", prefix
  # data: only for POST requests
  #
  def self.send_request(method, endpoint, token = nil, data = nil)
    begin
      execute_request(method, endpoint, token, data)
    rescue => e
      error_response(e)
    end
  end

  private

  def self.execute_request(method, endpoint, token = nil, data = nil)
    response = RestClient::Request.execute(request_params(method, endpoint, token, data))
    JSON.parse(response)
  end

  def self.request_params(method, endpoint, token, data)
    {}.tap do |params|
      params[:method]  = method.downcase.to_sym
      params[:url]     = url(endpoint)
      params[:payload] = data.to_json unless data == nil
      params[:headers] = headers(token)
    end
  end

  def self.headers(token)
    {}.tap do |header|
      header[:content_type]   = :json
      header[:accept]         = :json
      header['Authorization'] = token if token
    end
  end

  def self.url(endpoint)
    BASE_URL + endpoint
  end

  def self.error_response(e)
    puts e
    errorResponse = JSON.parse e.response.body
    puts "Received HTTP #{ e.message }: #{ errorResponse["error"] }"
    nil
  end

  def self.prefix_token(token)
    (/bearer /.match(token).nil?) ? "bearer #{token}" : token
  end
end
