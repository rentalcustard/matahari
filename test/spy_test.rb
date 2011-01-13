require 'test/unit'
require 'matahari'

class SpyTest < Test::Unit::TestCase
  #minimal test to make sure we stay compatible. For full tests, see spec/
  def test_matahari_works_with_test_unit
    mata_hari = spy(:mata_hari)

    mata_hari.one

    #I know this syntax sucks but at least it shows you don't *need* rspec to use matahari.
    #TODO make an assert_received method for test/unit
    assert mata_hari.has_received?.one.matches?(mata_hari)
    assert !mata_hari.has_received?.two.matches?(mata_hari)
  end
end
