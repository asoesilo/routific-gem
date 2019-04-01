require 'rest-client'
require 'json'

module Util
  BASE_URL    = 'https://api.routific.com/v1/'
  PRODUCT_URL = 'https://product-api.routific.com/v1.0/'

  ##
  # method: "GET", "POST"
  # endpoint: "vrp", "vrp-long", "job"
  # token: if nil, raise ArgumentError; if missing "bearer", prefix
  # data: only for POST requests
  #
  def self.send_request(method, endpoint, token = nil, data = nil, product = false)
    begin
      params = request_params(method, url(endpoint, product), token, data)
      execute_request(params)
    rescue => e
      error_response(e)
    end
  end

  private

  def self.execute_request(params)
    response = RestClient::Request.execute(params)
    JSON.parse(response)
  end

  def self.request_params(method, url, token, data)
    {}.tap do |params|
      params[:method]  = method.downcase.to_sym
      params[:url]     = url
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

  def self.url(endpoint, product)
    return PRODUCT_URL + endpoint if product
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
