require 'spec_helper'
require 'test/unit'

class DummyTestCase < Test::Unit::TestCase
  include Matahari::Adapters::TestUnit
end

describe Matahari::Adapters::TestUnit do
  before(:each) do
    @dummy = DummyTestCase.new "dummy"
  end

  describe "#assert_received" do
    context "with a passing test" do
      it "passes" do
        subject = spy(:matahari)

        subject.some_method

        lambda { @dummy.assert_received(subject) { subject.has_received?.some_method } }.should_not raise_error
      end

      context "with a failing test" do
        it "fails with an informative message" do
          subject = spy(:matahari)

          lambda { @dummy.assert_received(subject) { subject.has_received?.some_method } }.
            should raise_error(MiniTest::Assertion, "Spy(:matahari) expected to receive :some_method once, received 0 times")
        end
      end
    end
  end

  describe "#assert_not_received" do
    context "with a passing test" do
      it "passes" do
        subject = spy(:matahari)

        lambda { @dummy.assert_not_received(subject) { subject.has_received?.some_method } }.
          should_not raise_error
      end
    end

    context "with a failing test" do
      it "fails with an informative message" do
        subject = spy(:matahari)

        subject.some_method

        lambda { @dummy.assert_not_received(subject) { subject.has_received?.some_method } }.
          should raise_error(MiniTest::Assertion, "Spy(:matahari) expected not to receive :some_method but received it once")
      end
    end
  end
end
