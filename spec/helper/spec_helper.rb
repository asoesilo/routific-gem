require 'bundler/setup'
require 'dotenv'
require 'faker'
require 'routific'
require 'webmock'
require 'vcr'

require_relative './factory'

Bundler.setup
Dotenv.load

RSpec.configure do |c|
  WebMock.enable!

  VCR.configure do |vcr_config|
    vcr_config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    vcr_config.hook_into :webmock # or :fakeweb
    vcr_config.extend VCR::RSpec::Macros

    vcr_config.default_cassette_options = {
      :match_requests_on => [:method, :uri, :headers]
    }
  end
end
