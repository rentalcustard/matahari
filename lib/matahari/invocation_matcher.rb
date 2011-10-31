module Matahari
  class InvocationMatcher
    def initialize(iterator = nil)
      @expected_call_count = iterator ? iterator.count : nil
    end

    def matches?(subject)
      @subject = subject

      @matching_calls = @expected_invocation.args ?
        @subject.invocations.select {|i| @expected_invocation == i } :
        @subject.invocations.select {|i| @expected_invocation === i }

      match_passes?(@matching_calls)
    end

    def failure_message_for_should_not
      "Spy(:#{@subject.name}) expected not to receive :#{@expected_invocation.method} but received it #{prettify_times(@matching_calls.size)}"
    end

    def failure_message_for_should
      if @expected_invocation.args
        "Spy(:#{@subject.name}) expected to receive :#{@expected_invocation.method}(#{@expected_invocation.args.map(&:inspect).join(", ")}) #{prettify_times(@expected_call_count)}, received #{prettify_times(@matching_calls.size)}"
      else
        "Spy(:#{@subject.name}) expected to receive :#{@expected_invocation.method} #{prettify_times(@expected_call_count)}, received #{prettify_times(@matching_calls.size)}"
      end
    end

    #Allows chaining of method calls following has_received?/should have_received,
    #e.g. spy.should_have received.some_method, where #some_method is handled by
    #method_missing, its arguments and name being stored until #matches? is called.
    def method_missing(sym, *args, &block)
      #when args are supplied, we need to wrap them in an array because Invocation's #initialize
      #flattens them by one step
      @expected_invocation = args.size > 0 ? Matahari::Invocation.new(sym, [args]) : Matahari::Invocation.new(sym)
      self
    end

    def prettify_times(times)
      case times
      when 1
        "once"
      when nil
        "once"
      when 2
        "twice"
      else
        "#{times} times"
      end
    end
    private :prettify_times

    def match_passes?(matching_calls)
      if @expected_call_count
        matching_calls.size == @expected_call_count
      else
        matching_calls.size > 0
      end
    end
    private :match_passes?
  end
end
