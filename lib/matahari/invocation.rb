module Matahari
  class Invocation
    attr_reader :method, :args

    def initialize(method, args=nil)
      @method = method
      @args = args.flatten(1) if args
    end

    def ==(other)
      self.method == other.method && self.args == other.args
    end

    def ===(other)
      self.method == other.method
    end
  end
end
