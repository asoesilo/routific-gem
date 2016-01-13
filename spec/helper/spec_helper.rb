require 'bundler/setup'
Bundler.setup

require 'faker'

require 'dotenv'
Dotenv.load

require 'routific'
require 'pry'
require 'webmock/rspec'

require_relative './factory'

WebMock.allow_net_connect!

RSpec.configure do |config|
end
