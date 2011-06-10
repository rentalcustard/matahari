Feature: Spying in TestUnit/Minitest
  As an RSpec hater
  I want to use Matahari in other frameworks

  Scenario: Using TestUnit
    Given a file named "test_unit_test.rb" with:
    """
    require File.expand_path(File.dirname(__FILE__) + '../../../../lib/matahari')
    require 'test/unit'
    class Test::Unit::TestCase
      include Matahari::Adapters::TestUnit
    end

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
    require File.expand_path(File.dirname(__FILE__) + '../../../../lib/matahari')
    require 'test/unit'
    class Test::Unit::TestCase
      include Matahari::Adapters::TestUnit
    end

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
