require 'base62'

module Tincan
  module Utils
    module_function

    def generate_code(length = 8)
      SecureRandom.random_bytes((length / 2.0).ceil).unpack('C*').map do |int|
        int.base62_encode.rjust 2, '0'
      end.join[0...length]
    end
  end
end
