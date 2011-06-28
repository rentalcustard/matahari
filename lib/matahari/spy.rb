class Spy
  attr_reader :name, :invocations

  def initialize(name = nil, opts={})
    @subject = opts[:subject]
    @name = name
    @invocations = []
    @stubbed_calls = {}
    class << self
      instance_methods.each do |meth|
        whitelist = [:name, :define_method, :stubs, :passes_on, :method_missing, :record_invocation, :invocations, :has_received?, :object_id, :respond_to?, :respond_to_missing?, :instance_eval, :instance_exec, :class_eval, :__send__, :send, :should, :should_not, :__id__, :__send__]
        next if whitelist.include?(meth) || whitelist.include?(meth.to_sym)
        undef_method(meth)
      end
    end
  end

  #When a given method call, sym, is invoked on self, call block and return its result
  def stubs(sym, &block)
    @stubbed_calls[sym] = block
  end

  def passes_on(sym)
    @stubbed_calls[sym] = @subject.method(sym)
  end

  #Captures the details of any method call and store for later inspection
  def method_missing(sym, *args, &block)
    record_invocation(sym, args)
    @stubbed_calls[sym].call if @stubbed_calls[sym]
  end

  #Pass an iterator to this method to specify the number of times the method should
  #have been called. E.g. spy.has_received?(3.times). While other iterators might work,
  #the idea is to allow this nice DSL-ish way of asserting on the number of calls, hence
  #the odd method signature.
  def has_received?(times=nil)
    InvocationMatcher.new(times)
  end

  private
  def record_invocation(sym, *args)
    @invocations << {:method => sym, :args => args}
  end
end
