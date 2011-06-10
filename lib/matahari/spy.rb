class Spy
  attr_reader :name, :invocations

  def initialize(name = nil)
    @name = name if name
    @invocations = []
    @stubbed_calls = {}
    self.class.instance_methods.each do |meth|
      next if [:define_method, :stubs, :method_missing, :record_invocation].include?(meth)
    end
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
    if @verifying
      raise
    else
      record_invocation(sym, args)
      @stubbed_calls[sym].call if @stubbed_calls[sym]
    end
  end

  def has_received?(times=nil)
    if times 
      calls_expected = 0
			#this method gets called with an iterator, e.g. 3.times. This doesn't make
			#a whole lot of sense here, but it does in the context of the dsl.
			#Anyway, we want to convert that iterator back to an integer, and this seems
			#the easiest way
      times.each { calls_expected += 1 }

      Debriefing.new(calls_expected)
    else
      Debriefing.new
    end
  end

  private
  def record_invocation(sym, *args)
    @invocations << {:method => sym, :args => args}
  end
end
