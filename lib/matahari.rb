$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Matahari
  VERSION = '0.0.1'
end

class Spy
	attr_reader :name, :invocations

	def initialize(name = nil)
		@name = name if name
		@invocations = []
		@stubbed_calls = {}
	end
	
	def stubs(sym, &block)
		@stubbed_calls[sym] = block
	end

	def method_missing(sym, *args, &block)
		if @verifying
			raise
		else
			record_invocation(sym, args)
			@stubbed_calls[sym].call if @stubbed_calls[sym]
		end
	end

	def has_received?
		@verifying = true
		raise
	end
	
	private
	def record_invocation(sym, *args)
		@invocations << {:method => sym, :args => args}
	end
end

class ArgumentMatcher
	def matches?(*stuff)
		true
	end

	def negative_failure_message
		"Expected not to receive"
	end
end

class Debriefing
	def initialize(expected_calls = nil)
		@expected_calls = expected_calls
	end

  def matches?(subject)
		invocations_matching_method = subject.invocations.select {|i| i[:method] == @call_to_verify}
		method_matched = invocations_matching_method.size > 0 
		no_args = @args_to_verify.size == 0
		matching_calls = invocations_matching_method.select {|i| i[:args].flatten === @args_to_verify}.size
		if @expected_calls
			checked_number_of_calls = true
		  args_match = matching_calls == @expected_calls
		else
			args_match = matching_calls > 0
		end
		matching = if checked_number_of_calls
								 args_match
							 else
								 method_matched && no_args || args_match
							 end

		if matching
			true
		else
			false
		end
	end

	def method_missing(sym, *args, &block)
		@call_to_verify = sym
		@args_to_verify = args
		self
	end
end

def have_received(times = nil)
	if times 
		@calls_expected = 0
		times.each { @calls_expected+= 1 }

		Debriefing.new(@calls_expected)
	else
		Debriefing.new
	end

end

def spy(name = nil)
	Spy.new(name)
end
