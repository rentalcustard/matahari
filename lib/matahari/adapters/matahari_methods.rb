module Matahari
  module Adapters
    module MatahariMethods
      def spy(name = nil)
        Spy.new(name)
      end
    end
  end
end
