$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Matahari
	VERSION = '0.0.1'
end

require 'matahari/spy'
require 'matahari/debriefing'
require 'matahari/rspec/matchers'

def spy(name = nil)
	Spy.new(name)
end
