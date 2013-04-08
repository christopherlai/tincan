require 'spec_helper'

describe Tincan::Utils do
  describe 'generate_code' do
    subject do
      Tincan::Utils.generate_code
    end

    it 'returns a string' do
      subject.must_be_kind_of String
    end

    it 'defaults to 8 characters' do
      subject.length.must_equal 8
    end

    it 'supports odd numbers of characters' do
      Tincan::Utils.generate_code(7).length.must_equal 7
    end
  end
end
