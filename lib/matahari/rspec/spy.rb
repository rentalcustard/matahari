module Matahari
  module RSpec
    module Extensions
      def spy(name = nil)
        Spy.new(name)
      end
    end
  end
end


module RSpec
  module Mocks
    module ExampleMethods
      include Matahari::RSpec::Extensions
    end
  end
end
