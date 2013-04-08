require 'sinatra'

module Tincan
  class Application < Sinatra::Application
    get '/' do
      'hi'
    end
  end
end
