require 'rest-client'
require 'json'

module RoutificApi
  module Util
    BASE_URL = 'https://api.routific.com/v1/'

    ##
    # method: "GET", "POST"
    # endpoint: "vrp", "vrp-long", "job"
    # token: if nil, raise ArgumentError; if missing "bearer", prefix
    # data: only for POST requests
    #
    def self.send_request(method, endpoint, token = nil, data = nil)
      url = BASE_URL + endpoint
      headers = {
        content_type: :json,
        accept: :json
      }
      headers['Authorization'] = token if token
      begin
        # Sends HTTP request to Routific API server
        response = nil
        if method == 'GET'
          response = RestClient.get(url, headers)
        elsif method == 'POST'
          response = RestClient.post(url, data.to_json, headers)
        end

        return JSON.parse(response)
      rescue => e
        puts e
        errorResponse = JSON.parse e.response.body
        puts "Received HTTP #{e.message}: #{errorResponse["error"]}"
        nil
      end
    end

    def self.prefix_token(token)
      (/bearer /.match(token).nil?) ? "bearer #{token}" : token
    end
  end
end
