module Matahari
  module Adapters
    module RSpec
      include Matahari::Adapters::MatahariMethods

      def have_received(times = nil)
        Debriefing.new(times)
      end
    end
  end
end
