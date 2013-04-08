require 'sinatra'
require 'sinatra/json'

module Tincan
  class Application < Sinatra::Application
    helpers Sinatra::JSON

    # Create phone number
    post '/v1/phone_numbers' do
      phone = PhoneNumber.create!(params[:phone_number])
      json phone
    end
  end
end
