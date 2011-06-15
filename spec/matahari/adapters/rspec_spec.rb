require 'spec_helper'

describe Matahari::Adapters::RSpec do
  describe "#have_received" do
    context "with no iterator" do
      it "creates a InvocationMatcher with no restriction on number of calls" do
        InvocationMatcher.should_receive(:new)

        have_received
      end
    end

    context "with an iterator" do
      it "creates a InvocationMatcher with a restriction on number of calls" do
        iterator = 10.times
        
        InvocationMatcher.should_receive(:new).with(iterator)
        
        have_received(iterator)
      end
    end
  end
end
