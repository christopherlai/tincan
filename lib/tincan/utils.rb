require 'base62'

module Tincan
  module Utils
    module_function

    def generate_code(bytes = 4)
      SecureRandom.random_bytes(bytes).unpack('C*').map do |int|
        int.base62_encode.rjust 2, '0'
      end.join
    end
  end
end
