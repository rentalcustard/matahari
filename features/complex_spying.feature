Feature: complex spying
	>As a developer
	In order to test collaborations between objects fully
	I want to use matahari to match on arguments and number of invocations

	Background: Object under test
		Given a file named "object_under_test.rb" with:
		"""
		class ObjectUnderTest
		  def initialize(printer)
			  @printer = printer
			end

			def do_stuff
		    @printer.reset!	
			  @printer.print!(5)
				@printer.print!(5)
				@printer.power_down!(:now)
				@printer.power_down!(:right_now)
			end
		end
		"""

	Scenario: Matching arguments (success)
		Given a file named "test.rb" with:
		"""
		require 'matahari'
		require 'object_under_test'
		
		describe ObjectUnderTest do
		  it "prints 5" do
				printer = spy(:printer)
			  object_under_test = ObjectUnderTest.new(printer)

				object_under_test.do_stuff

				printer.should have_received.print!(5)
			end
		end
		"""
		When I run "rspec test.rb"
		Then the output should contain "1 example, 0 failures"

	Scenario: Matching number of calls (success)
		Given a file named "test.rb" with:
		"""
		require 'matahari'
		require 'object_under_test'
		
		describe ObjectUnderTest do
		  it "prints 5" do
				printer = spy(:printer)
			  object_under_test = ObjectUnderTest.new(printer)

				object_under_test.do_stuff

				printer.should have_received(2.times).print!
			end
		end
		"""
		When I run "rspec test.rb"
		Then the output should contain "1 example, 0 failures"

	Scenario: Matching number of calls and arguments (success)
		Given a file named "test.rb" with:
		"""
		require 'matahari'
		require 'object_under_test'
		
		describe ObjectUnderTest do
		  it "prints 5" do
				printer = spy(:printer)
			  object_under_test = ObjectUnderTest.new(printer)

				object_under_test.do_stuff

				printer.should have_received(2.times).print!(5)
			end
		end
		"""
		When I run "rspec test.rb"
		Then the output should contain "1 example, 0 failures"

	Scenario: Matching number of calls regardless of arguments
		Given a file named "test.rb" with:
		"""
		require 'matahari'
		require 'object_under_test'
		
		describe ObjectUnderTest do
		  it "prints 5" do
				printer = spy(:printer)
			  object_under_test = ObjectUnderTest.new(printer)

				object_under_test.do_stuff

				printer.should have_received(2.times).power_down!
			end
		end
		"""
		When I run "rspec test.rb"
		Then the output should contain "1 example, 0 failures"

	Scenario: Matching arguments (failure)
		Given a file named "test.rb" with:
		"""
		require 'matahari'
		require 'object_under_test'
		
		describe ObjectUnderTest do
		  it "prints 5" do
				printer = spy(:printer)
			  object_under_test = ObjectUnderTest.new(printer)

				object_under_test.do_stuff

				printer.should have_received.print!(7)
			end
		end
		"""
		When I run "rspec test.rb"
		Then the output should contain "1 example, 1 failure"
		And the output should contain "Spy(:printer) expected to receive :print!(7) once, received 0 times"

	Scenario: matching number of calls (failure)
		Given a file named "test.rb" with:
		"""
		require 'matahari'
		require 'object_under_test'
		
		describe ObjectUnderTest do
		  it "prints 5" do
				printer = spy(:printer)
			  object_under_test = ObjectUnderTest.new(printer)

				object_under_test.do_stuff

				printer.should have_received(1.times).print!(5)
			end
		end
		"""
		When I run "rspec test.rb"
		Then the output should contain "1 example, 1 failure"
		And the output should contain "Spy(:printer) expected to receive :print!(5) once, received twice"
		
