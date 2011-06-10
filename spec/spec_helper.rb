require File.dirname(__FILE__) + "/../lib/matahari"
require 'rspec'

RSpec.configure do |config|
	config.include Matahari::Adapters::RSpec
end
