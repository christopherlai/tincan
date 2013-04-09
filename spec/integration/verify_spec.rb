require 'spec_helper'

describe 'Verify integration' do
  it 'should require a code' do
    post 'v1/phone_numbers/verify'
    last_status.must_equal 400
    last_json['error'].must_equal 'bad_request'
  end

  it 'should require a valid code' do
    post 'v1/phone_numbers/verify', code: 'asdf'
    last_status.must_equal 400
    last_json['error'].must_equal 'invalid_code'

    phone = Tincan::PhoneNumber.create!('+14152751660')
    post 'v1/phone_numbers/verify', code: phone.code
    last_status.must_equal 200

    get "v1/phone_numbers/#{phone.id}"
    last_json['verified_at'].wont_be_nil
  end
end
