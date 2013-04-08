require 'spec_helper'

describe 'Create integration' do
  it 'requires a phone number' do
    post 'v1/phone_numbers'
    last_status.must_equal 400
  end

  it 'requires a valid phone number' do
    post 'v1/phone_numbers', phone_number: '+14152751660'
    last_status.must_equal 201
    last_json['e164'].must_equal '+14152751660'
    last_json['local_format'].must_equal '(415) 275-1660'
  end

  it 'handles invalid phone numbers' do
    post 'v1/phone_numbers', phone_number: '+1415275166'
    last_status.must_equal 400
  end

  it 'sends an SMS'
  it 'store a redirect URI'
end
