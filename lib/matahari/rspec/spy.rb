module Matahari
  module RSpec
    module Extensions
      def spy(name = nil)
        Spy.new(name)
      end
    end
  end
end
