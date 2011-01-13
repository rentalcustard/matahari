require 'spec_helper'
describe Debriefing do
	it "matches simple invocations" do
		#we have to use rspec mocks here because testing matahari with matahari
		#makes my brain hurt

		subject = mock(:subject)
		debriefing = Debriefing.new

		subject.should_receive(:invocations).and_return([{:method => :one, :args => [[]]}])

		debriefing.one

		debriefing.matches?(subject).should be_true
	end

	it "matches invocations based on arguments" do
		subject = mock(:subject)
		correct_debriefing = Debriefing.new
		incorrect_debriefing = Debriefing.new

		subject.should_receive(:invocations).twice.and_return([{:method => :one, :args => [["Hello", "goodbye"]]}])

		correct_debriefing.one("Hello", "goodbye")
		incorrect_debriefing.one("Hello", "goodbye", "Hello again")

		correct_debriefing.matches?(subject).should be_true
		incorrect_debriefing.matches?(subject).should be_false
	end

	it "gives a failure message for should when method not called" do
		subject = mock(:subject)
		debriefing = Debriefing.new

		subject.should_receive(:invocations).and_return([{:method => :one, :args => [[]]}])
		subject.should_receive(:name).and_return(:subject)

		debriefing.two

		debriefing.matches?(subject).should be_false

		debriefing.failure_message_for_should.should == "Spy(:subject) expected to receive :two once, received 0 times"
	end

	it "gives a failure message for should when method called with wrong arguments" do
		subject = mock(:subject)
		debriefing = Debriefing.new

		subject.should_receive(:invocations).and_return([{:method => :one, :args => [[]]}])
		subject.should_receive(:name).and_return(:subject)

		debriefing.one("Hello")

		debriefing.matches?(subject).should be_false

		debriefing.failure_message_for_should.should ==  "Spy(:subject) expected to receive :one(\"Hello\") once, received 0 times"
	end

	it "gives a failure message for should when method called wrong number of times" do
		subject = mock(:subject)
		debriefing = Debriefing.new(2)

		subject.should_receive(:invocations).and_return([{:method => :one, :args => [[]]}])
		subject.should_receive(:name).and_return(:subject)

		debriefing.one

		debriefing.matches?(subject).should be_false

		debriefing.failure_message_for_should.should == "Spy(:subject) expected to receive :one twice, received once"
	end
end
