require 'sinatra/base'
require 'fakie/errors'

module Tincan
  class Application < Sinatra::Base
    # Create phone number
    post '/v1/phone_numbers' do
      unless phone_number = params['phone_number']
        status 400
        return json({
          error: 'bad_request',
          error_description: "The `phone_number` parameter is required."
        })
      end

      unless message_format = params['message_format']
        status 400
        return json({
          error: 'bad_request',
          error_description: "The `message_format` parameter is required."
        })
      end

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

      SMS.send(phone, message_format)

      status 201
      json phone.as_json
    end

    # Verify phone number
    post '/v1/phone_numbers/verify' do
      unless code = params['code']
        status 400
        return json({
          error: 'bad_request',
          error_description: "The `code` parameter is required."
        })
      end

      if phone = PhoneNumber.verify_code!(code)
        return json(phone.as_json)
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

    def json(content)
      content_type 'application/json'
      MultiJson.dump(content)
    end

    def params
      return super if request.get? || !request.content_type || request.content_type.index('application/json') != 0
      @_params ||= MultiJson.load(request.env['rack.input'].read)
    end
  end
end
