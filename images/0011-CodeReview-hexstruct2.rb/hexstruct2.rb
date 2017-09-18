#
# Copyright (C) 2005 Minero Aoki
# 
# This program is free software.
# You can distribute/modify this program under the terms of the Ruby License.
#

require 'stringio'

class HexStruct2

  class << self
    def define(&block)
      new_class(&block)
    end

    def fixed_size_field(name, byte_size)
      define_field name, FixedSizeField.new(nil, byte_size)
    end

    def variable_size_field(name)
      define_field name, VariableSizeField.new(nil)
    end

    def struct_field(name, &block)
      c = new_class(&block)
      define_field name, StructField.new(nil, c)
      c
    end

    def list_field(name, &block)
      c = new_class(&block)
      define_field name, ListField.new([], c)
      c
    end

    private

    def new_class(&block)
      c = Class.new(::HexStruct2)
      c.instance_variable_set :@field_specs, []
      c.module_eval(&block)
      c
    end

    def define_field(name, prototype)
      @field_specs.push [name.to_s.intern, prototype]
      define_field_accessor name
    end

    def define_field_accessor(name)
      define_method(name) {
        self[name].value
      }
      define_method("#{name}=") {|obj|
        self[name].value = obj
      }
    end
  end

  class << self
    def byte_size
      @field_specs.map {|name, prototype| prototype }\
          .inject(0) {|sum, prototype| sum + prototype.byte_size }
    end

    alias size byte_size
  end

  class << self
    def parse(str)
      f = StringIO.new(str)
      result = for_io(f)
      raise ArgumentError, 'string too long' unless f.eof?
      result
    end

    def new(values = nil)
      return for_io(DevZero.new) unless values
      super
    end

    def for_io(f)
      new(@field_specs.map {|name, prototype| prototype.read_value(f) })
    end
  end

  class DevZero
    def read(len = nil)
      len ? ('0' * len) : ''
    end

    def eof?
      true
    end
  end

  def initialize(values)
    specs = self.class.instance_variable_get(:@field_specs)
    unless values.size == specs.size
      raise ArgumentError,"wrong # of values (#{values.size} for #{specs.size})"
    end
    @alist = specs.zip(values).map{|(name, proto), val| [name, proto.new(val)] }
  end
  
  def inspect
    "\#<#{self.class} #{@alist.map {|name, field| "#{name}=#{field.value.inspect}" }.join(', ')}>"
  end

  def byte_size
    fields().inject(0) {|sum, field| sum + field.byte_size }
  end

  alias size byte_size

  def [](name)
    name, field = @alist.assoc(name)
    raise KeyError, "wrong member name: #{name}" unless field
    field
  end

  def fields
    @alist.map {|name, field| field }
  end

  def ==(other)
    self.class == other.class and self.to_s == other.to_s
  end 
  
  def string
    fields().map {|field| field.string }.join('')
  end

  alias to_s string
  
  def to_a
    fields().map {|field| field.to_a_item }
  end

  class FixedSizeField
    def initialize(int, byte_size)
      @value = nil
      @byte_size = byte_size
      self.value = int if int
    end

    def read_value(f)
      s = f.read(@byte_size * 2)
      raise ArgumentError, 'field too short' unless s
      raise ArgumentError, 'field too short' unless s.size == @byte_size * 2
      s.hex
    end

    def new(val)
      self.class.new(val, @byte_size)
    end

    attr_reader :value

    def value=(int)
      if (int >> (@byte_size * 8)) > 0
        raise ArgumentError, "integer too big: #{int}"
      end
      @value = int
    end

    attr_reader :byte_size
    alias size byte_size

    def string
      sprintf("%0#{@byte_size * 2}X", @value)
    end

    alias to_a_item value
  end

  class VariableSizeField
    def initialize(val, byte_size = nil)
      case
      when val.kind_of?(Integer), val.nil?
        @value = val
        @byte_size = (byte_size || 0)
      when val.kind_of?(String)
        @value = val.hex
        @byte_size = val.size / 2
      else
        raise TypeError, "unexpected type: #{val.class}"
      end
    end

    def read_value(f)
      f.read
    end

    def new(val)
      self.class.new(val)
    end

    attr_accessor :value

    def byte_size
      [@byte_size, string().size / 2].max
    end

    alias size byte_size

    attr_writer :byte_size
    alias size= byte_size=

    def string
      return '' unless @value
      return '' if @value == 0
      s = sprintf("%0#{@byte_size * 2}X", @value)
      (s.size % 2 == 0) ? s : '0' + s
    end

    alias to_a_item value
  end

  class StructField
    def initialize(struct, klass = nil)
      @value = struct
      @class = klass
    end

    def read_value(f)
      @class.for_io(f)
    end

    def new(val)
      self.class.new(val)
    end

    attr_accessor :value

    def byte_size
      (@value || @class).byte_size
    end

    alias size byte_size

    def string
      @value.string
    end

    def to_a_item
      @value.to_a
    end
  end

  class ListField
    def initialize(list, klass = nil)
      @value = list
      @class = klass
    end

    def read_value(f)
      list = []
      until f.eof?
        list.push @class.for_io(f)
      end
      list
    end

    def new(val)
      self.class.new(val)
    end

    attr_accessor :value

    def byte_size
      @value.inject(0) {|sum, struct| sum + struct.byte_size }
    end

    alias size byte_size

    def string
      @value.map {|struct| struct.string }.join('')
    end

    alias to_a_item value
  end

end
