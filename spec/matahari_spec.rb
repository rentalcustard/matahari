require File.dirname(__FILE__) + "/../lib/matahari"
require 'rspec'

describe "Spy" do
	it "takes an optional name parameter" do
		named = spy(:bond)
		unnamed = spy

		named.name.should == :bond
		unnamed.name.should == nil
	end

	context "in the field" do
		it "remains as a sleeper agent until called upon" do
			mata_hari = spy(:mata_hari)
			lambda do 
				mata_hari.one
				mata_hari.two
				mata_hari.three
			end.should_not raise_error NoMethodError
		end

		it "captures communications" do
			mata_hari = spy(:mata_hari)

			mata_hari.one
			mata_hari.two

			mata_hari.should have_received.one
			mata_hari.should have_received.two
			mata_hari.should_not have_received.three
			mata_hari.should_not have_received.four
		end

		it "captures the details of communications" do
			mata_hari = spy(:mata_hari)

			mata_hari.one
			mata_hari.two("Hello")

			mata_hari.should have_received.two("Hello")
			mata_hari.should_not have_received.two("Goodbye")
			mata_hari.should_not have_received.three("Stuff")
		end

		it "allows complex assertions about the number of calls" do
			mata_hari = spy(:mata_hari)

			mata_hari.one
			mata_hari.one
			mata_hari.one

			mata_hari.should have_received(3.times).one
			mata_hari.should_not have_received(4.times).one
		end

		it "doesn't stop you stubbing" do
			mata_hari = spy(:mata_hari)
			
			mata_hari.stubs(:test) { "Hello" }

			mata_hari.test.should == "Hello"
			mata_hari.should have_received.test			
		end

		#this is useful for those not using rspec
		it "allows you to check method calls via a predicate method" do
			mata_hari = spy(:mata_hari)
			
			mata_hari.one
			mata_hari.two
			mata_hari.two

			mata_hari.has_received?.one.should be_true	
			mata_hari.has_received?(2.times).two.should be_true
		end
	end
end
