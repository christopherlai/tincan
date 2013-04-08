require 'spec_helper'

describe Tincan::Utils do
  describe 'generate_code' do
    subject do
      Tincan::Utils.generate_code
    end

    it 'must return a string' do
      subject.must_be_kind_of String
    end

    it 'must return be 8 characters' do
      subject.length.must_equal 8
    end
  end
end
