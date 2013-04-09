require 'spec_helper'

describe Tincan::SMS do

  it 'should explode if you try to send without a sender' do
    p = proc { Tincan::SMS.send(Tincan::PhoneNumber.create!('+17174683737'), 'body') }
    p.must_raise Tincan::SMS::NoSmsSenderError
  end

end
