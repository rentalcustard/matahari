class Spy
  attr_reader :name, :invocations

  def initialize(name = nil)
    @name = name if name
    @invocations = []
    @stubbed_calls = {}
    class << self
      instance_methods.each do |meth|
        next if [:name, :define_method, :stubs, :method_missing, :record_invocation, :invocations, :has_received?, :object_id, :respond_to?, :respond_to_missing?, :instance_eval, :instance_exec, :class_eval, :__send__, :send, :should, :should_not].include?(meth)
        undef_method(meth)
      end
    end
  end

  #When a given method call, sym, is invoked on self, call block and return its result
  def stubs(sym, &block)
    @stubbed_calls[sym] = block
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
    times_as_int = times ? times.inject(&:+) : nil
    Debriefing.new(times_as_int)
  end

  private
  def record_invocation(sym, *args)
    @invocations << {:method => sym, :args => args}
  end
end
