module Matahari
  class Invocation
    attr_reader :method, :args

    def initialize(method, *args)
      @method = method
      @args   = args.flatten(1) unless args.empty?
    end

    def ==(other)
      self.method == other.method && self.args == other.args
    end

    def ===(other)
      self.method == other.method
    end
  end
end
