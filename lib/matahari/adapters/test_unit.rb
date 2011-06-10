module Matahari
  module Adapters
    module TestUnit
      include Matahari::Adapters::MatahariMethods

      def assert_received(subject, &block)
        result = block.call
        assert result.matches?(subject), "#{result.failure_message_for_should}"
      end
    end
  end
end
