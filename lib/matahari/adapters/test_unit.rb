module Matahari
  module Adapters
    module TestUnit
      include Matahari::Adapters::MatahariMethods

      def assert_received(subject, &block)
        result = block.call
        assert result.matches?(subject), result.failure_message_for_should
      end

			def assert_not_received(subject, &block)
				result = block.call
				assert !result.matches?(subject), result.failure_message_for_should_not
			end
    end
  end
end
