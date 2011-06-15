$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'matahari/spy'
require 'matahari/invocation_matcher'
require 'matahari/adapters/matahari_methods'
require 'matahari/adapters/rspec'
require 'matahari/adapters/test_unit'
require 'matahari/version'
