---
layout: post
title: 0011-CodeReview-test_hexstruct2.rb
short_title: 0011-CodeReview-test_hexstruct2.rb
tags: 0011 CodeReview
---
{% include base.html %}


[あなたの Ruby コードを添削します 【第 2 回】 HexStruct.rb]({% post_url articles/0011/2005-11-16-0011-CodeReview %}) 添削後のテストスクリプトです。

```ruby
require 'test/unit'
require 'hexstruct2'

FixedSizeFrame = HexStruct2.define {
  fixed_size_field :MsgCode, 2
  fixed_size_field :from_add, 3
  fixed_size_field :to_add, 3
  fixed_size_field :data, 5
}

VariableSizeFrame = HexStruct2.define {
  fixed_size_field :MsgCode, 2
  fixed_size_field :from_add, 3
  fixed_size_field :to_add, 3
  variable_size_field :data
}

NestedFrame = HexStruct2.define {
  fixed_size_field :MsgCode, 2
  fixed_size_field :from_add, 3
  fixed_size_field :to_add, 3
  struct_field(:sub) {
    fixed_size_field :DataType, 2
    fixed_size_field :Len, 1
    variable_size_field :data
  }
}

RepeatFrame = HexStruct2.define {
  InnerFrame = list_field(:list) {
    fixed_size_field :index, 1
    fixed_size_field :code, 2
  }
}

class TestHexStruct2 < Test::Unit::TestCase
  
  def test_s_byte_size
    assert_equal 13, FixedSizeFrame.byte_size
    assert_equal 8, VariableSizeFrame.byte_size
    assert_equal 11, NestedFrame.byte_size
    assert_equal 0, RepeatFrame.byte_size
    assert_equal 3, InnerFrame.byte_size
  end
  
  def test_s_size
    assert_equal 13, FixedSizeFrame.size
    assert_equal 8, VariableSizeFrame.size
    assert_equal 11, NestedFrame.size
    assert_equal 0, RepeatFrame.size
    assert_equal 3, InnerFrame.size
  end
  
  def test_s_new__fixed
    frame = FixedSizeFrame.new
    assert_equal 0, frame.MsgCode
    assert_equal 0, frame.from_add
    assert_equal 0, frame.to_add
    assert_equal 0, frame.data
  end
  
  def test_s_new__variable
    frame = VariableSizeFrame.new
    assert_equal 0, frame.MsgCode
    assert_equal 0, frame.from_add
    assert_equal 0, frame.to_add
    assert_equal 0, frame.data
  end
  
  def test_s_new__struct
    frame = NestedFrame.new
    assert_equal 0, frame.MsgCode
    assert_equal 0, frame.from_add
    assert_equal 0, frame.to_add
    assert_equal 0, frame.sub.DataType
    assert_equal 0, frame.sub.Len
    assert_equal 0, frame.sub.data
  end
  
  def test_s_parse__fixed
    items = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "0102030405", # data
    ]
    frame = FixedSizeFrame.parse(items.join)
    assert_equal 0x23, frame.MsgCode
    assert_equal 0x110, frame.from_add
    assert_equal 0x203, frame.to_add
    assert_equal 0x102030405, frame.data
  end
  
  def test_s_parse__variable
    items = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "010203040506070809", # data
    ]
    frame = VariableSizeFrame.parse(items.join)
    assert_equal 0x23, frame.MsgCode
    assert_equal 0x110, frame.from_add
    assert_equal 0x203, frame.to_add
    assert_equal 0x10203040506070809, frame.data
  end
  
  def test_s_parse__struct
    items = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "0011",       # sub.DataType
      "03",         # sub.Len
      "AABBCC"      # sub.data
    ]
    frame = NestedFrame.parse(items.join)
    assert_equal 0x11,   frame.sub.DataType
    assert_equal 0x3,     frame.sub.Len
    assert_equal 0xAABBCC, frame.sub.data
  
    frame = NestedFrame.parse(items.join)
    frame.sub.data = 0xFFEEDDCCBBAA
    frame.sub.Len = frame.sub[:data].size
    assert_equal "0023000110000203001106FFEEDDCCBBAA", frame.string
  end

  def test_s_parse__list
    str = "115555226666337777448888"
    frame = RepeatFrame.parse(str)
    assert_equal 0x11,   frame.list[0].index
    assert_equal 0x5555, frame.list[0].code
    assert_equal 0x22,   frame.list[1].index
    assert_equal 0x6666, frame.list[1].code
    assert_equal 0x33,   frame.list[2].index
    assert_equal 0x7777, frame.list[2].code
    assert_equal 0x44,   frame.list[3].index
    assert_equal 0x8888, frame.list[3].code
    assert_equal str, frame.to_s
    frame.list.push InnerFrame.new([0x55, 0x9999])
    assert_equal str + "559999", frame.string
  end

  def test_byte_size
    assert_equal 13, FixedSizeFrame.new.byte_size
    assert_equal 8, VariableSizeFrame.new.byte_size
    assert_equal 11, NestedFrame.new.byte_size
    assert_equal 0, RepeatFrame.new.byte_size
    assert_equal 3, InnerFrame.new.byte_size
  end

  def test_size
    assert_equal 13, FixedSizeFrame.new.size
    assert_equal 8, VariableSizeFrame.new.size
    assert_equal 11, NestedFrame.new.size
    assert_equal 0, RepeatFrame.new.size
    assert_equal 3, InnerFrame.new.size
  end

  def test_GETTER
    frame = VariableSizeFrame.new
    frame[:MsgCode].value = 0x22
    assert_equal 0x22, frame.MsgCode
    frame[:MsgCode].value = 0x33
    assert_equal 0x33, frame.MsgCode
    frame[:from_add].value = 0x123
    assert_equal 0x123, frame.from_add
    frame[:data].value = 0xAABBCCDDEEFF
    assert_equal 0xAABBCCDDEEFF, frame.data
  end
  
  def test_SETTER
    frame = VariableSizeFrame.new
    frame.MsgCode = 0x22
    assert_equal 0x22, frame[:MsgCode].value
    frame.MsgCode = 0x33
    assert_equal 0x33, frame[:MsgCode].value
    frame.from_add = 0x123
    assert_equal 0x123, frame[:from_add].value
    frame.data = 0xAABBCCDDEEFF
    assert_equal 0xAABBCCDDEEFF, frame[:data].value
  end
  
  def test_EQ
    a = VariableSizeFrame.new
    b = VariableSizeFrame.new
    assert_equal true, (a == a)
    assert_equal true, (a == b)
    assert_equal true, (b == a)
    a.MsgCode = 0x22
    assert_equal false, (a == b)
    assert_equal false, (b == a)
    b.MsgCode = 0x22
    assert_equal true, (a == b)
    assert_equal true, (b == a)

    assert_equal FixedSizeFrame.new, FixedSizeFrame.new
    assert_equal NestedFrame.new, NestedFrame.new
    assert_equal RepeatFrame.new, RepeatFrame.new
  end
  
  def test_AREF
    a = ["0023", "000110", "000203", "010203040506070809"]
    frame = VariableSizeFrame.parse(a.join)
    assert_instance_of HexStruct2::FixedSizeField, frame[:MsgCode]
    assert_instance_of HexStruct2::FixedSizeField, frame[:from_add]
    assert_instance_of HexStruct2::FixedSizeField, frame[:to_add]
    assert_instance_of HexStruct2::VariableSizeField, frame[:data]
    assert_equal 0x23, frame[:MsgCode].value
    assert_equal 0x110, frame[:from_add].value
    assert_equal 0x203, frame[:to_add].value
    assert_equal 0x10203040506070809, frame[:data].value
  end
  
  def test_XxxxField_byte_size
    items = [
      "0023",       # MsgCode
      "000110",     # from_add
      "000203",     # to_add
      "010203040506070809", # data
    ]
    frame = VariableSizeFrame.parse(items.join)
    assert_equal 2, frame[:MsgCode].byte_size
    assert_equal 3, frame[:from_add].byte_size
    assert_equal 3, frame[:to_add].byte_size
    assert_equal 9, frame[:data].byte_size
  end

  def test_VariableField_byte_size=
    frame = VariableSizeFrame.new
    frame.data = 0x1234
    assert_equal "1234", frame[:data].string
    frame[:data].byte_size = 4
    assert_equal "00001234", frame[:data].string
    frame[:data].byte_size = 0
    assert_equal "1234", frame[:data].string
  end

  def test_to_a
    assert_equal [0, 0, 0, 0], FixedSizeFrame.new.to_a
    assert_equal [0, 0, 0, 0], VariableSizeFrame.new.to_a
    assert_equal [0, 0, 0, [0, 0, 0]], NestedFrame.new.to_a
    assert_equal [[]], RepeatFrame.new.to_a

    a = ["0023", "000110", "000203", "010203040506070809"]
    frame = VariableSizeFrame.parse(a.join)
    assert_equal [0x23, 0x110, 0x203, 0x10203040506070809], frame.to_a

    a = ["0023", "000110", "000203", ["0011", "03", "AABBCC"]]
    frame = NestedFrame.parse(a.join)
    assert_equal [0x23, 0x110, 0x203, [0x11, 0x3, 0xAABBCC]], frame.to_a
  end
  
  def test_exceptions
    frame = VariableSizeFrame.new
    assert_raise(NoMethodError) {
      frame.no_such_member
    }
    assert_raise(KeyError) {
      frame[:no_such_member]
    }
    assert_raise(ArgumentError) {
      FixedSizeFrame.parse("0001")
    }
    assert_raise(ArgumentError) {
      FixedSizeFrame.parse("0011000000400000111111111122")
    }
  end

end

```


