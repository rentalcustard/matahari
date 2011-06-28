Feature: partial spying
  In order to test objects with multiple responsibilities (ahem, ActiveRecord)
  As a developer
  I want to let matahari pass on some calls to the real object

  Background: Object under test
    Given a file named "active_record_style_example.rb" with:
    """
    class User
      def self.find_for_some_specific_purpose
        User.find({:conditions => "something"})
      end
    end
    """
    And a file named "spec_helper.rb" with:
    """
    require 'matahari'
    require File.dirname(__FILE__) + '/active_record_style_example'

    RSpec.configure do |config|
      config.include Matahari::Adapters::RSpec
    end
    """

  Scenario: partial spying
    Given a file named "test.rb" with:
    """
    require File.dirname(__FILE__) + '/spec_helper'

    describe User do
      describe ".find_for_some_specific_purpose" do
        it "calls find with some conditions" do
        User = spy(:mata_hari, :subject => User)
          User.passes_on(:find_for_some_specific_purpose)

          User.find_for_some_specific_purpose

          User.should have_received.find({:conditions => "something"})
        end
      end
    end
    """
    When I run `rspec test.rb`
    Then the output should contain "1 example, 0 failures"

