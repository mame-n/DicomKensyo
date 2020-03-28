require 'fileutils'
require 'dicom'
include DICOM

#Git test modification

class DicomKensyo
  def initialize(dcm_path = "./US000001", num_copy = 0)
    @dcm_path = dcm_path
    @num_copy = num_copy
  end

  def main
    @num_copy.times do |i|
      new_dcm_path = copy_dcm(i)
      dcm = DObject.read( new_dcm_path )
      dcm["0010,0010"].value = "DICOMKENSYO_Name" # Patient Name
      dcm["0010,0020"].value = "DICOMKENSYO_"+sprintf("%02d", i) # Patient ID
    end
  end

  def copy_dcm(i)
    new_dcm_path = @dcm_path + sprintf( "_%02d", i )
    FileUtils.cp @dcm_path, new_dcm_path
    new_dcm_path
  end

  def confirm
    Dir.glob( "./US000001_*" ).map do |fpath|
      dcm = DObject.read(fpath)
      puts "name,ID : #{dcm.value("0010,0010")}, #{dcm.value("0010,0020")}"
    end
  end


end

if $0 == __FILE__
  DicomKensyo.new(ARGV[0]).main
end

