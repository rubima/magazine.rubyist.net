# This script requires tdp4r-1.2.2 (http://rubyforge.org/projects/tdp4r/).
require 'tdp'
require 'tdputils'

translator = TDParser.define{|g|
  g.prefix_expr =
    g.op - g.prefix_expr - g.prefix_expr >> proc{|x|
      [x[1],x[2],x[0]].join(" ")
    } |
    g.int >> proc{|x| x[0] }

  g.postfix_expr =
    g.int - (g.postfix_expr - g.op)*0 >> proc{|x|
      x[1].inject(x[0]){|acc,y|
        [y[1],acc,y[0]].join(" ")
      }
    }

  g.int  = token(:int) >> proc{|x| x[0].value}

  g.op   = (token('+') | token('-') | token('*') | token('/')) >> proc{|x| x[0] }

  def translate_prefix_notation(str)
    tokenizer = TDPUtils::StringTokenizer.new({
      /\d+/ => :int,
    }, /\s+/)
    prefix_expr.parse(tokenizer.generate(str))
  end

  def translate_postfix_notation(str)
    tokenizer = TDPUtils::StringTokenizer.new({
      /\d+/ => :int,
    }, /\s+/)
    postfix_expr.parse(tokenizer.generate(str))
  end
}

p translator.translate_prefix_notation("- + 1 / 2 2 + 3 * 4 5")
p translator.translate_postfix_notation("1 2 2 / + 3 4 5 * + -")
