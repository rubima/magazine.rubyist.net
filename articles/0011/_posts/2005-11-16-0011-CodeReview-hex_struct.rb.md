---
layout: post
title: 0011-CodeReview-hex_struct.rb
short_title: 0011-CodeReview-hex_struct.rb
tags: 0011 CodeReview
---


[あなたの Ruby コードを添削します 【第 2 回】 HexStruct.rb]({% post_url articles/0011/2005-11-16-0011-CodeReview %}) で解説した、添削前のソースコードです。

```ruby
# IE Control Library Ver.0.1.0    2003/11/30
# Copyright (C) 2005 Oka Yasushi <yac@tech-notes.dyndns.org>
# 
# You may redistribute it and/or modify it under the same license terms as Ruby.

class HexStruct
  class NoMemberError < StandardError
  end
  class SizeError < StandardError
  end
  class FormatError < StandardError
  end
  
  STRUCT = [
    [:len,   1],  # lenメンバは1バイト
    [:code,  2],  # codeメンバは2バイト
    [:data, -1]   # dataメンバは不定長
  ]
  
  def HexStruct::size()
    total_size = 0
    self::STRUCT.each {|sym, elem_size|
      if (sym == nil) or (elem_size == nil)
        raise FormatError, "Illegal STRUCT Format.", caller
      end
      if elem_size > 0 
        total_size += elem_size
      end
    }
    total_size
  end
  
  def initialize(hex_str=nil)
    unless hex_str
      hex_str = "00" * self.class::size()
    end
    @item_list = []
    @cache = {}
    to_itemlist(hex_str)
  end
  
  def byte_size()
    @item_list.flatten.join('').size / 2
  end
  alias size byte_size
  
  def size_of(member_name)
    member_check(member_name)
    
    item_size, item_data = @cache[member_name]
    if item_size > 0
      item_size
    else
      item_data.size / 2
    end
  end
  
  
  def data_of(member_name)
    member_check(member_name)
    
    item_size, item_data = @cache[member_name]
    item_data
  end
  
  def write_to(member_name, data)
    member_check(member_name)
    
    item_size, item_data = @cache[member_name]
    
    if data.is_a?(HexStruct) or data.is_a?(Array)
      index = @item_list.index(item_data)
      @item_list[index] = data
      @cache[member_name] = [item_size, @item_list[index]]
      return data
    elsif data.is_a?(Integer)
      current_size = item_data.size
      set_param = sprintf("%0#{current_size}X", data)
      item_data.replace(set_param)
    else
      if (item_size > 0) and (item_size * 2 != data.size)
        raise SizeError, "unmatch data size.", caller
      end
      item_data.replace(data)
    end
  end
  
  def ==(other)
    self.to_str == other.to_s
  end 
  
  def to_str
    str = ""
    @item_list.flatten.each {|item|
      str += item.to_s
    }
    str
  end
  alias to_s to_str
  
  
  def to_ary
    arr = []
    @item_list.each {|item|
      if item.is_a?(String)
        arr.push item
      elsif item.is_a?(Array)
        sub_arr = []
        item.each {|sub_item|
          sub_arr.push sub_item.to_a
        }
        arr.push sub_arr
      else 
        arr.push item.to_ary
      end
    }
    arr
  end
  alias to_a to_ary
  
  
  def inspect()
    arr = []
    self.class::STRUCT.each {|member_sym, item_size|
      item = data_of(member_sym.to_s)
      if item.is_a?(String)
        arr.push "#{member_sym}:#{item.to_s}"
      else
        arr.push "#{member_sym}:<#{item.inspect}>"
      end
    }
    
    "#{self.class}:[#{arr.join(", ")}]"
  end
  
  private
  
  def to_itemlist(hex_str)
    offset = 0
    @cache.clear
    @item_list.clear
    self.class::STRUCT.each {|member_sym, item_size|
      if (member_sym == nil) or (item_size == nil)
        raise FormatError, "Illegal STRUCT Format.", caller
      end
      if item_size > 0
        item_data = hex_str[(offset * 2), item_size * 2]
        if (item_data == "") or (item_data == nil)
          raise SizeError, "unmatch data size.", caller
        end
        offset += item_size
      else
        item_data = hex_str[(offset * 2)..-1]
        offset += item_data.size / 2
      end
      @item_list.push item_data
      @cache[member_sym.to_s] = [item_size, item_data]
    }
    if offset != hex_str.size / 2
      raise SizeError, "unmatch data size.", caller
    end
  end
  
  def method_missing(method_sym, *params)
    #puts "method_missing()"; p [method_sym, *params]
    if method_sym.to_s =~ /\w=$/
      member_name = method_sym.to_s.gsub(/=$/, "")
      write_to(member_name, *params)
    else
      member_name = method_sym.to_s
      set_flag = false
    end
    
    unless @cache.key?(member_name)
      hex_str = self.to_s
      if hex_str.methods.include?(member_name)
        return hex_str.send(method_sym, *params)
      else
        raise NoMemberError, "'#{member_name}' is not member.", caller
      end
    end
    item_size, item_data = @cache[member_name]
    item_data
  end
  
  def member_check(member_name)
    unless @cache.key?(member_name)
      raise NoMemberError, "#{member_name} is not member.", caller
    end
  end
end

```


