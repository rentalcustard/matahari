require 'spec_helper'

describe Matahari::Invocation do
  it "is equal to another when its properties are the same" do
    invocation_one = Matahari::Invocation.new(:one, [["some", "args"]])
    invocation_two = Matahari::Invocation.new(:one, [["some", "args"]])

    invocation_one.should == invocation_two
  end

  it "is not equal to another when their method properties differ" do
    invocation_one = Matahari::Invocation.new(:one, [["some", "args"]])
    invocation_two = Matahari::Invocation.new(:two, [["some", "args"]])

    invocation_one.should_not == invocation_two
  end

  it "is not equal to another when their args properties differ" do
    invocation_one = Matahari::Invocation.new(:one, [["some", "args"]])
    invocation_two = Matahari::Invocation.new(:one, [["some", "other", "args"]])

    invocation_one.should_not == invocation_two
  end
end
