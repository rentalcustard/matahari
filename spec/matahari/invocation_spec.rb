require 'spec_helper'

describe Matahari::Invocation do
  context "when method and args are the same as another invocation" do
    before do
      @invocation_one = Matahari::Invocation.new(:one, [["some", "args"]])
      @invocation_two = Matahari::Invocation.new(:one, [["some", "args"]])
    end

    it "is == to the other" do
      @invocation_one.should == @invocation_two
    end

    it "is === to the other" do
      @invocation_one.should === @invocation_two
    end
  end

  context "when methods are different and args the same" do
    before do
      @invocation_one = Matahari::Invocation.new(:one, [["some", "args"]])
      @invocation_two = Matahari::Invocation.new(:two, [["some", "args"]])
    end

    it "is not == to the other" do
      @invocation_one.should_not == @invocation_two
    end

    it "is not === to the other" do
      @invocation_one.should_not === @invocation_two
    end
  end

  context "when methods are the same and args different" do
    before do
      @invocation_one = Matahari::Invocation.new(:one, [["some", "args"]])
      @invocation_two = Matahari::Invocation.new(:one, [["some", "other", "args"]])
    end

    it "is not == to the other" do
      @invocation_one.should_not == @invocation_two
    end

    it "is === to the other" do
      @invocation_one.should === @invocation_two
    end
  end
end
