require 'spec_helper'

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

    it "returns nil on method_missing with no stubs" do
      mata_hari = Spy.new(:mata_hari)

      mata_hari.one.should be_nil
    end

    it "doesn't stop you stubbing" do
      mata_hari = Spy.new(:mata_hari)

      mata_hari.stubs(:test) { "Hello" }

      mata_hari.test.should == "Hello"
      mata_hari.invocations.should == [{:method => :test, :args => [[]]}]
    end
    
    describe "#has_received?" do
      let(:mata_hari) { Spy.new(:mata_hari) }
      context "with no iterator passed" do
        it "returns a debriefing with no restriction on times called" do
          InvocationMatcher.should_receive(:new)

          mata_hari.has_received?
        end
      end

      context "with an iterator passed" do
        it "returns a debriefing with a restriction on times called" do
          iterator = 10.times
          InvocationMatcher.should_receive(:new).with(iterator)

          mata_hari.has_received?(iterator)
        end
      end
    end

    context "when a new method has been added to Object" do
      before do
        class Object
          def new_method
            "Hello!"
          end
        end
      end

      it "still works" do
        mata_hari = Spy.new(:mata_hari)

        mata_hari.new_method

        mata_hari.invocations.should == [{:method => :new_method, :args => [[]]}]
      end
    end
  end
end
