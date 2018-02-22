#!ruby -Ks
require "runit/testcase"
require "runit/cui/testrunner"

require 'hex_struct'


class FixLengthFrame < HexStruct
  STRUCT = [
    [:MsgCode, 2],
    [:from_add, 3],
    [:to_add, 3],
    [:data, 5],
  ]
end

class VariableLengthFrame < HexStruct
  STRUCT = [
    [:MsgCode, 2],
    [:from_add, 3],
    [:to_add, 3],
    [:data, -1],
  ]
end

class DataPart < HexStruct
  STRUCT = [
    [:DataType, 2],
    [:Len, 1],
    [:data, -1],
  ]
end

class RepeatPart < HexStruct
  STRUCT = [
    [:index, 1],
    [:code,  2],
  ]
end



class TestHexStruct < RUNIT::TestCase
  
  def test_StructSize()
    assert_equal(13, FixLengthFrame.size)
    assert_equal(8, VariableLengthFrame.size)
    assert_equal(3, DataPart.size)
    assert_equal(3, RepeatPart.size)
  end
  
  def test_data_size()
    fix_length_frame = FixLengthFrame.new()
    assert_equal(13, fix_length_frame.byte_size)
    assert_equal(13, fix_length_frame.size)
    
  end
  
  def test_new_with_data_for_fixsize()
    data_arr = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "0102030405", # data(5byte)
    ]
    data_str = data_arr.join('')
    fix_length_frame = FixLengthFrame.new(data_str)
    assert_equal("0023", fix_length_frame.MsgCode)
    assert_equal("000110", fix_length_frame.from_add)
    assert_equal("0102030405", fix_length_frame.data)
  end
  
  def test_new_with_data_for_variablesize()
    data_arr = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "010203040506070809", # data(5byte)
    ]
    data_str = data_arr.join('')
    fix_length_frame = VariableLengthFrame.new(data_str)
    assert_equal("0023", fix_length_frame.MsgCode)
    assert_equal("000203", fix_length_frame.to_add)
    assert_equal("010203040506070809", fix_length_frame.data)
  end
  
  def test_new_without_data_for_fixsize()
    fix_length_frame = FixLengthFrame.new()
    assert_equal("00000000000000000000000000", fix_length_frame)
  end
  
  def test_new_without_data_for_variablesize()
    variable_length_frame = VariableLengthFrame.new()
    assert_equal("0000000000000000", variable_length_frame)
  end
  
  def test_setdata_to_member()
    frame = VariableLengthFrame.new()
    frame.MsgCode = "0022"
    frame.from_add = "000123"
    frame.data = "AABBCCDDEEFF"
    assert_equal("0022000123000000AABBCCDDEEFF", frame)
    
    frame.MsgCode = 0x33
    assert_equal("0033", frame.MsgCode)
    
    
  end
  
  def test_compare()
    frame_01 = VariableLengthFrame.new()
    frame_02 = VariableLengthFrame.new()
    assert_equal(true, frame_01 == frame_02)
    assert_equal(true, frame_01 == "0000000000000000")
    frame_01.MsgCode = "0022"
    assert_equal(false, frame_01 == frame_02)
    
  end
  
  def test_dataof()
    data_arr = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "010203040506070809", # data
    ]
    data_str = data_arr.join('')
    frame = VariableLengthFrame.new(data_str)
    assert_equal("000110", frame.data_of("from_add"))
  end
  
  def test_writeto()
    frame = VariableLengthFrame.new()
    frame.write_to("data", "AABBCCDD")
    assert_equal("AABBCCDD", frame.data)
    
    frame.write_to("MsgCode", 0x5566)
    assert_equal("5566", frame.MsgCode)
    
  end
  
  def test_writeto_integer()
    frame = VariableLengthFrame.new()
    frame.write_to("data", "AABBCCDD")
    
    frame.write_to("MsgCode", 0x5566)
    assert_equal("5566", frame.MsgCode)
    frame.write_to("data", 0x0123)
    assert_equal("00000123", frame.data)
    frame.data = ""
    
    frame.data = 0x1234
    assert_equal("1234", frame.data)
    
    
  end
  
  def test_sizeof()
    data_arr = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "010203040506070809", # data
    ]
    data_str = data_arr.join('')
    frame = VariableLengthFrame.new(data_str)
    assert_equal(2, frame.size_of("MsgCode"))
    assert_equal(3, frame.size_of("from_add"))
    assert_equal(9, frame.size_of("data"))
    
  end
  
  def test_toarr()
    data_str = "0023000110000203010203040506070809"
    frame = VariableLengthFrame.new(data_str)
    data_arr = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "010203040506070809", # data
    ]
    assert_equal(data_arr, frame.to_a)
  end
  
  def test_set_subitem()
    data_arr = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "001103AABBCC", # data
    ]
    frame = VariableLengthFrame.new(data_arr.join(''))
    frame.data = DataPart.new(frame.data)
    assert_equal(DataPart, frame.data.class)
    assert_equal("0011", frame.data.DataType)
    assert_equal("03", frame.data.Len)
    assert_equal("AABBCC", frame.data.data)
  end
  
  def test_write_to_subitem()
    data_arr = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "001103AABBCC", # data
    ]
    frame = VariableLengthFrame.new(data_arr.join(''))
    frame.data = DataPart.new(frame.data)
    
    app_frame = frame.data
    
    app_frame.data = "FFEEDDCCBBAA"
    app_frame.Len = app_frame.size_of("data")
    assert_equal("0023000110000203001106FFEEDDCCBBAA", frame)
  end
  
  def test_subitem_toarr()
    data_arr = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "001103AABBCC", # data
    ]
    frame = VariableLengthFrame.new(data_arr.join(''))
    frame.data = DataPart.new(frame.data)
    assert_equal(["0023","000110", "000203", ["0011", "03", "AABBCC"]], frame.to_a)
    
  end
  
  def test_subitem_each()
    frame = VariableLengthFrame.new()
    frame.data = ["0000", "1111", "2222", "3333"]
    arr = []
    frame.data.each {|data_block|
      arr.push data_block
    }
    assert_equal("1111", arr[1])
    assert_equal("00" * 8 + "0000111122223333", frame)
  end
  
  def test_subitem_each2()
    frame = VariableLengthFrame.new()
    frame.data = DataPart.new("0036FF")
    arr = []
    ["011111", "022222", "033333"].each {|data_str|
      arr.push RepeatPart.new(data_str)
    }
    frame.data.data = arr
    assert_equal("022222", frame.data.data[1])
  end
  
  def test_expection_nomember()
    frame = VariableLengthFrame.new()
    assert_exception(HexStruct::NoMemberError) {
      frame.no_member
    }
    assert_exception(HexStruct::NoMemberError) {
      frame.data_of("no_member")
    }
    assert_exception(HexStruct::NoMemberError) {
      frame.write_to("no_member", "00")
    }
  end
  
  def test_exception_size_err()
    assert_exception(HexStruct::SizeError) {
      FixLengthFrame.new("0001")
    }
    assert_exception(HexStruct::SizeError) {
      FixLengthFrame.new("0011000000400000111111111122")
    }
    frame = VariableLengthFrame.new("11112222223333334444")
    assert_exception(HexStruct::SizeError) {
      frame.MsgCode ="00"
    }
    assert_exception(HexStruct::SizeError) {
      frame.MsgCode =""
    }
    
    assert_no_exception(HexStruct::SizeError) {
      frame.data =""
    }
    assert_equal("1111222222333333", frame)
    
    
  end
  
  def setup()
  end
  def teardown()
  end
end

if ARGV.size == 0
  RUNIT::CUI::TestRunner.run(TestHexStruct.suite)
else
  ARGV.each{|test_method|
    RUNIT::CUI::TestRunner.run(TestHexStruct.new(test_method))
  }
end
