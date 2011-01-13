Feature: Test spying
	As a developer
	In order to test collaborations between objects
	I want to use test spies
	So that I don't have to specify irrelevant interactions

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
