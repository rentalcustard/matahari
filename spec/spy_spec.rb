require File.dirname(__FILE__) + "/../lib/matahari"
require 'rspec'
require 'rspec/expectations'

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

			mata_hari.should have_received(:one)
			mata_hari.should have_received(:two)
			mata_hari.should_not have_received(:three)
			mata_hari.should_not have_received(:four)
		end

		it "captures the details of communications" do
			mata_hari = spy(:mata_hari)

			mata_hari.one
			mata_hari.two("Hello")

			mata_hari.should have_received(:two).with("Hello")
			mata_hari.should_not have_received(:three).with("Stuff")
		end
	end
end
