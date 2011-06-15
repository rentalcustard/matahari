require 'spec_helper'
describe InvocationMatcher do
  it "matches simple invocations" do
    #we have to use rspec mocks here because testing matahari with matahari
    #makes my brain hurt

    subject = mock(:subject)
    invocation_matcher = InvocationMatcher.new

    subject.should_receive(:invocations).and_return([{:method => :one, :args => [[]]}])

    invocation_matcher.one

    invocation_matcher.matches?(subject).should be_true
  end

  it "matches invocations based on arguments" do
    subject = mock(:subject)
    correct_invocation_matcher = InvocationMatcher.new
    incorrect_invocation_matcher = InvocationMatcher.new

    subject.should_receive(:invocations).twice.and_return([{:method => :one, :args => [["Hello", "goodbye"]]}])

    correct_invocation_matcher.one("Hello", "goodbye")
    incorrect_invocation_matcher.one("Hello", "goodbye", "Hello again")

    correct_invocation_matcher.matches?(subject).should be_true
    incorrect_invocation_matcher.matches?(subject).should be_false
  end

  it "gives a failure message for should when method not called" do
    subject = mock(:subject)
    invocation_matcher = InvocationMatcher.new

    subject.should_receive(:invocations).and_return([{:method => :one, :args => [[]]}])
    subject.should_receive(:name).and_return(:subject)

    invocation_matcher.two

    invocation_matcher.matches?(subject).should be_false

    invocation_matcher.failure_message_for_should.should == "Spy(:subject) expected to receive :two once, received 0 times"
  end

  it "gives a failure message for should when method called with wrong arguments" do
    subject = mock(:subject)
    invocation_matcher = InvocationMatcher.new

    subject.should_receive(:invocations).and_return([{:method => :one, :args => [[]]}])
    subject.should_receive(:name).and_return(:subject)

    invocation_matcher.one("Hello")

    invocation_matcher.matches?(subject).should be_false

    invocation_matcher.failure_message_for_should.should ==  "Spy(:subject) expected to receive :one(\"Hello\") once, received 0 times"
  end

  it "gives a failure message for should when method called wrong number of times" do
    subject = mock(:subject)
    invocation_matcher = InvocationMatcher.new(2.times)

    subject.should_receive(:invocations).and_return([{:method => :one, :args => [[]]}])
    subject.should_receive(:name).and_return(:subject)

    invocation_matcher.one

    invocation_matcher.matches?(subject).should be_false

    invocation_matcher.failure_message_for_should.should == "Spy(:subject) expected to receive :one twice, received once"
  end

  it "gives a failure message for should not" do
    subject = mock(:subject)
    invocation_matcher = InvocationMatcher.new

    subject.should_receive(:invocations).and_return([{:method => :two, :args => [[]]}])
    subject.should_receive(:name).and_return(:subject)

    invocation_matcher.two

    invocation_matcher.matches?(subject).should be_true

    invocation_matcher.failure_message_for_should_not.should == "Spy(:subject) expected not to receive :two but received it once"
  end
end
