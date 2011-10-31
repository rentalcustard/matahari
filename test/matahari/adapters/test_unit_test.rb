require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), "../../../lib/matahari"))

class TestUnitAdapterTest < Test::Unit::TestCase
  include Matahari::Adapters::TestUnit

  def test_assert_received_with_passing_test
    subject = spy(:matahari)

    subject.some_method

    assert_received(subject) { subject.has_received?.some_method }
  end

  def test_assert_not_received
    subject = spy(:matahari)

    assert_not_received(subject) { subject.has_received?.some_method }

  end
end
