require "test/unit"
require "./dicomkensyo.rb"

class TC < Test::Unit::TestCase
  def setup
#    @o = DicomKensyo.new
  end

  def test_main
    o = DicomKensyo.new
    assert_equal( nil, o.main )
  end

  def test_copy_dcm
    o = DicomKensyo.new
    idx = 8
    fname = "./US000001"+sprintf("_%02d", idx)
    assert_equal( fname, o.copy_dcm( idx ) )
    assert_equal( true, FileUtils.compare_file( fname, "./US000001" ) )

    idx = 99
    fname = "./US000001"+sprintf("_%02d", idx)
    assert_equal( fname, o.copy_dcm( idx ) )
    assert_equal( true, FileUtils.compare_file( fname, "./US000001" ) )
  end

end
