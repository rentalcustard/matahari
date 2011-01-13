require File.dirname(__FILE__) + "/../lib/matahari"
require 'rspec'

describe "Spy" do
	it "takes an optional name parameter" do
		named = Spy.new(:bond)
		unnamed = Spy.new

		named.name.should == :bond
		unnamed.name.should == nil
	end

	context "in the field" do
		it "remains as a sleeper agent until called upon" do
			mata_hari = Spy.new(:mata_hari)
			lambda do 
				mata_hari.one
				mata_hari.two
				mata_hari.three
			end.should_not raise_error NoMethodError
		end

		it "captures communications" do
			mata_hari = Spy.new(:mata_hari)

			mata_hari.one
			mata_hari.two

			mata_hari.invocations.should == [{:method => :one, :args => [[]]}, {:method => :two, :args => [[]]}]
		end

		it "captures the details of communications" do
			mata_hari = Spy.new(:mata_hari)

			mata_hari.one
			mata_hari.two("Hello")

			mata_hari.invocations.should == [{:method => :one, :args => [[]]}, {:method => :two, :args => [["Hello"]]}]
		end

		# it "allows complex assertions about the number of calls" do
		# 	mata_hari = spy(:mata_hari)

		# 	mata_hari.one
		# 	mata_hari.one
		# 	mata_hari.one

		# 	mata_hari.should have_received(3.times).one
		# 	mata_hari.should_not have_received(4.times).one
		# end

		it "doesn't stop you stubbing" do
			mata_hari = Spy.new(:mata_hari)
			
			mata_hari.stubs(:test) { "Hello" }

			mata_hari.test.should == "Hello"
			mata_hari.invocations.should == [{:method => :test, :args => [[]]}]
		end
	end
end
