#
# XMLStore
#
# Copyright (c) 2005 Kazuhiro NISHIYAMA.
# You can redistribute it and/or modify it under the same terms as Ruby.
#
# $Id: xmlstore.rb,v 1.1 2005/03/09 13:58:25 znz Exp $

require 'pstore'
require 'soap/marshal'

class XMLStore < PStore
  def initialize(filename)
    super(filename)
  end

  def dump(table)
    SOAP::Marshal.dump(table)
  end

  def load(content)
    SOAP::Marshal.load(content)
  end

  def load_file(file)
    SOAP::Marshal.load(File.open(file, "rb"){|f| f.read})
  end
end
