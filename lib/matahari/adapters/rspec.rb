module Matahari
  module Adapters
    module RSpec
      include Matahari::Adapters::MatahariMethods

      def have_received(times = nil)
        InvocationMatcher.new(times)
      end
    end
  end
end
