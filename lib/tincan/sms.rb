module Tincan
  class SMS
    class << self
      def sender=(val)
        @sender = val
      end

      def send(number, message)
        raise NoSmsSenderError.new unless @sender
        @sender.call number.e164, message.gsub('CODE', number.code)
      end
    end

    class NoSmsSenderError < ArgumentError; end
  end
end
