module Matahari
  module Adapters
    module MatahariMethods
      def spy(name = nil, opts={})
        Spy.new(name, opts)
      end
    end
  end
end
