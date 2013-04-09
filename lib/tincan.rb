require 'tincan/version'
require 'tincan/utils'
require 'tincan/phone_number'
require 'tincan/application'

require 'redis'
require 'redis/namespace'

module Tincan
  def self.redis
    # Set redis to nothing make the setter run and setup a default if it's nothing
    self.redis = {} unless defined? @@redis

    # Return the namespaced Redis instance
    @@redis
  end

  def self.redis=(options = {})
    client = nil
    if options.is_a?(Redis)
      client = options
    else
      url = options[:url] || determine_redis_provider || 'redis://localhost:6379/0'
      driver = options[:driver] || 'ruby'
      namespace = options[:namespace] || 'tincan'

      client = Redis.connect(url: url, driver: driver)
    end

    @@redis = Redis::Namespace.new(namespace, redis: client)
  end

private

  def self.determine_redis_provider
    return ENV['REDISTOGO_URL'] if ENV['REDISTOGO_URL']
    provider = ENV['REDIS_PROVIDER'] || 'REDIS_URL'
    ENV[provider]
  end
end
