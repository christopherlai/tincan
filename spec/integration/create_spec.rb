require 'spec_helper'

describe 'Creating a phone number integration' do
  it 'requires a valid phone number' do
    post 'v1/phone_numbers', phone_number: '+14152751660'
    last_json['e164'].must_equal '+14152751660'
    last_json['local_format'].must_equal '(415) 275-1660'
  end
end
