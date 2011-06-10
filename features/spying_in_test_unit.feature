Feature: Spying in TestUnit/Minitest
  As an RSpec hater
  I want to use Matahari in other frameworks

	Background: test helper
		Given a file named "test_helper.rb" with:
		"""
    require File.expand_path(File.dirname(__FILE__) + '../../../lib/matahari')
    require 'test/unit'
    class Test::Unit::TestCase
      include Matahari::Adapters::TestUnit
    end
		"""


  Scenario: Using TestUnit
    Given a file named "test_unit_test.rb" with:
    """
		require File.dirname(__FILE__) + '/test_helper'

    class SpyingTest < Test::Unit::TestCase
      def test_a_simple_interaction
        mata_hari = spy(:mata_hari)

        mata_hari.is_a_double_agent?

        assert_received(mata_hari) { mata_hari.has_received?.is_a_double_agent? }
      end
    end
    """
    When I run `ruby test_unit_test.rb`
    Then the output should contain "1 tests, 1 assertions, 0 failures, 0 errors, 0 skips"

  Scenario: Using TestUnit (failing test)
    Given a file named "test_unit_test.rb" with:
    """
		require File.dirname(__FILE__) + '/test_helper'

    class SpyingTest < Test::Unit::TestCase
      def test_a_simple_interaction
        mata_hari = spy(:mata_hari)

        mata_hari.is_a_double_agent?

        assert_received(mata_hari) { mata_hari.has_received?.is_a_spy? }
      end
    end
    """
    When I run `ruby test_unit_test.rb`
    Then the output should contain "1 tests, 1 assertions, 1 failures, 0 errors, 0 skips"
    Then the output should contain "Spy(:mata_hari) expected to receive :is_a_spy? once, received 0 times"

	Scenario: Using test unit to assert negatively
		Given a file named "negative_assertion_test.rb" with:
		"""
		require File.dirname(__FILE__) + '/test_helper'

		class SpyingTest < Test::Unit::TestCase
		  def test_a_method_call_never_happens
			  mata_hari = spy(:mata_hari)

				assert_not_received(mata_hari) { mata_hari.has_received?.is_a_spy? }
			end
		end
		"""
		When I run `ruby negative_assertion_test.rb`
		Then the output should contain "1 tests, 1 assertions, 0 failures, 0 errors"

	Scenario: Using test unit to assert negatively (failing test)
		Given a file named "negative_assertion_test.rb" with:
		"""
		require File.dirname(__FILE__) + '/test_helper'

		class SpyingTest < Test::Unit::TestCase
		  def test_a_method_call_never_happens
			  mata_hari = spy(:mata_hari)
				
				mata_hari.some_method

				assert_not_received(mata_hari) { mata_hari.has_received?.some_method }
			end
		end
		"""
		When I run `ruby negative_assertion_test.rb`
		Then the output should contain "1 tests, 1 assertions, 1 failures, 0 errors"
		And the output should contain "Spy(:mata_hari) expected not to receive :some_method but received it once"
