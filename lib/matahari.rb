$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'matahari/spy'
require 'matahari/debriefing'
require 'matahari/rspec/matchers'
require 'matahari/rspec/spy'
require 'matahari/version'
