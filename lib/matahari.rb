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
	end

	def method_missing(sym, *args, &block)
		if @verifying
			raise
		else
			record_invocation(sym, args)
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
  def matches?(subject)
		invocations_matching_method = subject.invocations.select {|i| i[:method] == @call_to_verify}
		method_matched = invocations_matching_method.size > 0 
		matching = method_matched && @args_to_verify.size == 0 || invocations_matching_method.select {|i| i[:args].flatten === @args_to_verify}.size > 0

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

def have_received
	Debriefing.new
end

def spy(name = nil)
	Spy.new(name)
end
