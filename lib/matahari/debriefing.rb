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
