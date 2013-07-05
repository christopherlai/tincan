require 'spec_helper'

describe 'Verify integration' do
  it 'should require a code' do
    post '/verify'
    last_status.must_equal 400
    last_json['error'].must_equal 'bad_request'
  end

  it 'should require a valid code' do
    post '/verify', code: 'asdf'
    last_status.must_equal 400
    last_json['error'].must_equal 'invalid_code'

    phone = Tincan::PhoneNumber.create!('+14152751660')
    post '/verify', code: phone.code
    last_status.must_equal 200

    get "/#{phone.id}"
    last_json['verified_at'].wont_be_nil
  end
end
