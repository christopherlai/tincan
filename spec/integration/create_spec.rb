require 'spec_helper'

describe 'Create integration' do

  before do
    Tincan::SMS.sender = lambda do |number, body|
      @messages = [] unless @messages
      @messages << {number: number, body: body}
    end
  end

  after do
    Tincan::SMS.sender = nil
  end

  it 'requires a phone number' do
    post 'v1/phone_numbers'
    last_status.must_equal 400
  end

  it 'requires a valid phone number' do
    post 'v1/phone_numbers', phone_number: '+14152751660', message_format: 'Click this: https://seesaw.co/CODE'
    last_status.must_equal 201
    last_json['e164'].must_equal '+14152751660'
    last_json['local_format'].must_equal '(415) 275-1660'

    # Verify the last messages are in the correct formats
    @messages.last[:number].must_equal last_json['e164']
    @messages.last[:body].must_match /https\:\/\/seesaw.co\/(\S+)/
  end

  it 'handles invalid phone numbers' do
    post 'v1/phone_numbers', phone_number: '+1415275166', message_format: 'Click this: https://seesaw.co/CODE'
    last_status.must_equal 400
  end

  it 'handles missing message formats' do
    post 'v1/phone_numbers', phone_number: '+14152751660'
    last_status.must_equal 400
  end

  it 'sends an SMS'
  it 'store a redirect URI'
end
