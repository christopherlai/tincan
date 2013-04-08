require 'multi_json'

module Tincan
  class PhoneNumber
    attr_reader :id, :e164, :country, :formatted

    def self.find(id)
      result = Tincan.redis.hget('phone-numbers', id)
      return nil unless result

      new(MultiJson.load(result))
    end

    def initialize(hash)
      %{id e164 country formatted}.each do |key|
        set_instance_variable(":#{key}".to_sym, hash[key])
      end

      @verified_at = Time.at(hash['verified_at']) if hash['verified_at']
    end

    def verified?
      verified_at && verified_at < Time.now.utc
    end

    def as_json
      hash = {}
      %{id e164 country formatted}.each do |key|
        hash[key] = self.call(":#{key}".to_sym)
      end
      hash['verified_at'] = verified_at ? verified_at.to_i : nil
      hash
    end

    def to_json
      MultiJson.dump(as_json)
    end
  end
end
