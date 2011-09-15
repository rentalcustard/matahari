require 'spec_helper'

describe Matahari::Spy do
  it "takes an optional name parameter" do
    named = Matahari::Spy.new(:bond)
    unnamed = Matahari::Spy.new

    named.name.should == :bond
    unnamed.name.should == nil
  end

  context "in the field" do
    it "remains as a sleeper agent until called upon" do
      mata_hari = Matahari::Spy.new(:mata_hari)

      lambda do 
        mata_hari.one
        mata_hari.two
        mata_hari.three
      end.should_not raise_error NoMethodError
    end

    it "captures communications" do
      mata_hari = Matahari::Spy.new(:mata_hari)

      mata_hari.one
      mata_hari.two

      mata_hari.invocations.should == [Matahari::Invocation.new(:one), Matahari::Invocation.new(:two)]
    end

    it "captures the details of communications" do
      mata_hari = Matahari::Spy.new(:mata_hari)

      mata_hari.one
      mata_hari.two("Hello")

      mata_hari.invocations.should == [Matahari::Invocation.new(:one), Matahari::Invocation.new(:two, "Hello")]
    end

    it "returns nil on method_missing with no stubs" do
      mata_hari = Matahari::Spy.new(:mata_hari)

      mata_hari.one.should be_nil
    end

    it "doesn't stop you stubbing" do
      mata_hari = Matahari::Spy.new(:mata_hari)

      mata_hari.stubs(:test) { "Hello" }

      mata_hari.test.should == "Hello"
      mata_hari.invocations.should == [Matahari::Invocation.new(:test)]
    end
    
    describe "#has_received?" do
      let(:mata_hari) { Matahari::Spy.new(:mata_hari) }
      context "with no iterator passed" do
        it "returns a debriefing with no restriction on times called" do
          Matahari::InvocationMatcher.should_receive(:new)

          mata_hari.has_received?
        end
      end

      context "with an iterator passed" do
        it "returns a debriefing with a restriction on times called" do
          iterator = 10.times
          Matahari::InvocationMatcher.should_receive(:new).with(iterator)

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
        mata_hari = Matahari::Spy.new(:mata_hari)

        mata_hari.new_method

        mata_hari.invocations.should == [Matahari::Invocation.new(:new_method)]
      end
      
      describe "#passes_on" do
        context "when the spy is initialized with the object" do
          before(:each) do
            @spy = Matahari::Spy.new(:mata_hari, :subject => Object.new)
          end
          
          it "calls the actual method" do
            @spy.passes_on(:new_method)

            @spy.new_method.should == "Hello!"
          end
        end
      end
    end
  end
end
