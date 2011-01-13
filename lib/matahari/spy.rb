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

	def has_received?(times=nil)
		if times 
			@calls_expected = 0
			times.each { @calls_expected+= 1 }

			Debriefing.new(@calls_expected)
		else
			Debriefing.new
		end
	end

	private
	def record_invocation(sym, *args)
		@invocations << {:method => sym, :args => args}
	end
end
