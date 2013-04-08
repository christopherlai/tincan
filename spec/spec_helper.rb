require 'rubygems'
require 'bundler'
Bundler.require :test

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'minitest/autorun'
require 'tincan'

# Support files
Dir["#{File.expand_path(File.dirname(__FILE__))}/support/*.rb"].each do |file|
  require file
end

class IntegrationTest < MiniTest::Spec
  include Rack::Test::Methods
  include RequestMacros

  def app
    Tincan::Application
  end

  register_spec_type(/integration$/, self)
end
