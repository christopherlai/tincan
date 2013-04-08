require 'sinatra'
require 'sinatra/json'
require 'fakie/errors'

module Tincan
  class Application < Sinatra::Application
    helpers Sinatra::JSON

    # Create phone number
    post '/v1/phone_numbers' do
      return unless phone_number = require_parameter(:phone_number)
      begin
        phone = PhoneNumber.create!(phone_number)
      rescue Fakie::InvalidPhoneNumber
        status 400
        hash = {
          error: 'invalid_phone_number',
          error_description: 'The phone number provided was invalid.'
        }
        return json(hash)
      end

      # TODO: Send text message...

      status 201
      json phone
    end

    # Verify phone number
    post '/v1/verify' do
      return unless code = require_parameter(:code)

      if phone = PhoneNumber.verify_code!(code)
        return json(phone)
      end

      status 400
      json({
        error: 'invalid_code',
        error_description: 'There were no phone numbers matching the given code.'
      })
    end

    # Show phone number
    get '/v1/phone_numbers/:id' do
      if phone = PhoneNumber.find(params[:id])
        return json(phone)
      end

      status 404
      json({
        error: 'not_found',
        error_description: 'A phone_number was not found with this id.'
      })
    end

  private

    def require_parameter(key)
      unless value = params[key]
        status 400
        hash = {
          error: 'bad_request',
          error_description: "The `#{key}` parameter is required."
        }
        json hash
        return nil
      end
      value
    end
  end
end
