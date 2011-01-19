Feature: Test spying
  >As a developer  
  In order to test collaborations between objects  
  I want to use test spies  

  Scenario: Spying with rspec
    Given a file named "test.rb" with:
    """
    require 'matahari'

    describe "Spying" do
      it "captures method calls and allows assertions" do
        mark_kennedy = spy(:kennedy)

        mark_kennedy.is_a_cop?

        mark_kennedy.should have_received.is_a_cop?
        mark_kennedy.should_not have_received.is_a_policeman?
      end
    end
    """
    When I run "rspec test.rb"
    Then the output should contain "1 example, 0 failures"

  Scenario: Unsuccessful spying
    Given a file named "failing_test.rb" with:
    """
    require 'matahari'

    describe "Failing" do
      it "gives descriptive messages" do
        james_bond = spy(:bond)

        james_bond.is_a_cad?

        james_bond.should have_received.is_007?
      end
    end
    """
    When I run "rspec failing_test.rb"
    Then the output should contain "1 example, 1 failure"
    And the output should contain "Spy(:bond) expected to receive :is_007? once, received 0 times"

  Scenario: Unsuccessful spying with should_not
    Given a file named "negative_test.rb" with:
    """
    require 'matahari'

    describe "negativity" do
      it "gives descriptive messages" do
        mata_hari = spy(:mata_hari)

        mata_hari.is_a_double_agent?

        mata_hari.should_not have_received.is_a_double_agent?
      end
    end
    """
    When I run "rspec negative_test.rb"
    Then the output should contain "1 example, 1 failure"
    And the output should contain "Spy(:mata_hari) expected not to receive :is_a_double_agent? but received it once"
