require 'multi_json'
require 'fakie'

module Tincan
  class PhoneNumber
    REDIS_KEY = 'phone-number'
    CODE_REDIS_KEY = 'phone-number-code'

    attr_reader :id, :e164, :country_code, :local_format, :verified_at
    attr_accessor :code

    class << self
      def create!(e164)
        # TODO: Make sure there aren't collisions
        parsed = Fakie.parse(e164)
        phone = new({
          'id' => Utils.generate_code(32),
          'e164' => parsed.e164,
          'country_code' => parsed.region_code,
          'local_format' => parsed.local_format
        })

        phone.save

        # Store code
        phone.code = Utils.generate_code(8)
        Tincan.redis.hset(CODE_REDIS_KEY, phone.code, phone.id)
        phone
      end

      def find(id)
        return nil unless id

        result = Tincan.redis.hget(REDIS_KEY, id)
        return nil unless result

        new(MultiJson.load(result))
      end

      def verify_code!(code)
        id = Tincan.redis.hget(CODE_REDIS_KEY, code)
        return nil unless phone = find(id)

        phone.verify!
        phone
      end
    end

    def initialize(hash)
      %w{id e164 country_code local_format}.each do |key|
        instance_variable_set(:"@#{key}", hash[key])
      end

      @verified_at = Time.at(hash['verified_at']) if hash['verified_at']
    end

    def verified?
      verified_at && verified_at < Time.now.utc
    end

    def verify!
      @verified_at = Time.now.utc
      save
    end

    def as_json
      hash = {}

      # Default attributes
      %w{id e164 country_code local_format}.each do |key|
        hash[key] = instance_variable_get(:"@#{key}")
      end

      # Add `verified_at` as an integer
      hash['verified_at'] = verified_at ? verified_at.to_i : nil

      # Return the hash
      hash
    end

    def to_json
      MultiJson.dump(as_json)
    end

    def save
      Tincan.redis.hset(REDIS_KEY, id, to_json)
    end
  end
end
