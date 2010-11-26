$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Matahari
  VERSION = '0.0.1'
end

class Spy
	attr_reader :name

	def initialize(name = nil)
		@name = name if name
		@invocations = Hash.new(0)
	end

	def method_missing(sym, *args, &block)
		record_invocation(sym)
	end

	def has_received?(sym)
		@invocations[sym] > 0
	end

	private
	def record_invocation(sym)
		@invocations[sym] += 1
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

class RSpec::Matchers::Has
	def with(*args)
		ArgumentMatcher.new
	end
end

def spy(name = nil)
	Spy.new(name)
end
