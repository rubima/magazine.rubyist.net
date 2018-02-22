#!/usr/bin/env ruby
#
# $Id: rdefs.rb,v 1.12 2004/12/10 12:31:23 aamine Exp $

require 'optparse'

DEF_RE = /\A\s*(?:
    def\s | class\s | module\s | include[\s\(]
  | alias(?:_\w+)?
  | attr_reader[\s\(]
  | attr_writer[\s\(]
  | attr_accessor[\s\(]
  | attr[\s\(]
  | public[\s\(]
  | private[\s\(]
  | protected[\s\(]
  )/x

def main
  print_line_number_p = false
  parser = OptionParser.new
  parser.banner = "#{File.basename $0} [-n] file..."
  parser.on('-n', '--lineno', 'Prints line number.') {
    print_line_number_p = true
  }
  parser.on('--help', 'Prints this message and quit.') {
    puts parser.help
    exit 0
  }
  begin
    parser.parse!
  rescue OptionParser::ParseError => err
    $stderr.puts err.message
    exit 1
  end

  f = Preprocessor.new(ARGF)
  re = DEF_RE
  while line = f.gets
    if re =~ line
      printf '%4d: ', f.lineno if print_line_number_p
      print getdef(line, f)
    end
  end
end

def getdef(str, f)
  until balanced?(str)
    str << f.gets
  end
  str
end

def balanced?(str)
  str.count('(') == str.count(')')
end

class Preprocessor
  def initialize(f)
    @f = f
  end

  def gets
    line = @f.gets
    if /\A=begin\s/ === line
      while line = @f.gets
        break if /\A=end\s/ === line
      end
      line = @f.gets
    end
    line
  end

  def lineno
    @f.lineno
  end
end

main
