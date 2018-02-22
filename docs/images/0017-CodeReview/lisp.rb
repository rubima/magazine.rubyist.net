@buf = []
@fenv = [] #関数用環境
@genv = [] #大域環境

def getToken
  while (x = @buf.shift) == nil
    print "> "
    l = gets
    return nil if !l #eof
    while l.gsub!(/[^\010][\010]/,"") do end
    if l =~ /^;.*$/ #コメント
      print "-"
      next
    end
    l.chomp.scan(/\s+|;.*$|([^()' ]+|.)/){|s,| @buf.push s if s}
  end
  x
end

def parse0
  case r = parse
  when "(" then [parse0]
  when ")" then []
  when "."
    result = parse
    raise "err" if parse != ")"
    result
  else [r, parse0]
  end
end

def parse
  case x = getToken
  when "(" then parse0
  when "'" then ["quote", [parse,[]]]
  when /\A-?\d+\z/ then x.to_i #数字
  else x                       #数字以外は文字列
  end
end

def pr(x)
  case x
  when Integer, String then x.to_s   #数字 アトム
  when Array #リスト
    res = "("
    if x != []
      res << pr(x[0])
      x = x[1]
      while x.class == Array && x != [] do
        res << " #{pr(x[0])}"
        x = x[1]
      end
      res << " . #{pr(x)}" if x != []
    end
    res << ")"
  end
end

def define(x) #関数定義
  @fenv = [[x[1][0], [x[1][1][0], x[1][1][1][0]]]].concat(@fenv) 
  x[1][0]
end

def findVar(x, env)
  env.assoc(x)
end

def evlis(l, env)
  if l == [] then [] else [eval(l[0], env), evlis(l[1], env)] end
end

def eval(x, env)
  case x
    #    when NilClass then []
  when Integer then x
  when String
    if v = env.assoc(x) then v[1]
    elsif v = @genv.assoc(x) then v[1]
    elsif x == "t" then "T"
    else raise "Undefined variable: #{x}"
    end
  when Array
    return [] if x == []
    case x[0]
    when "if"
      if eval(x[1][0], env) != []
        eval(x[1][1][0], env)
      else
        eval(x[1][1][1][0], env)
      end
    when "while" 
      while eval(x[1][0], env) != [] do
        eval(x[1][1][0], env)
      end
    when "quote" then x[1][0]
    when "set"
      result = eval(x[1][1][0], env)
      if (v = findVar(x[1][0], env)) then v[1] = result
      elsif (v = findVar(x[1][0], @genv)) then v[1] = result
      else
        @genv = [[x[1][0], result]].concat(@genv)
        result
      end 
    when "begin"
      x = x[1]
      while x != [] do 
        result = eval(x[0], env)
        x = x[1]
      end
      result
    else
      l = evlis(x[1], env)
      case x[0]
      when "+" then l[0] + l[1][0]
      when "-" then l[0] - l[1][0]
      when "*" then l[0] * l[1][0]
      when "/" then l[0] / l[1][0]
      when "=" then l[0] == l[1][0] ? "T" : []
      when ">" then l[0] > l[1][0] ? "T" : []
      when "<" then l[0] < l[1][0] ? "T" : []
      when "print" 
        print "#{pr(l[0])}\n"
        l[0]
      when "car" then l[0][0]
      when "cdr" then l[0][1]
      when "cons" then [l[0], l[1][0]]
      when "eq" then l[0] == l[1][0] ? "T" : []
      when "null?" then l[0] == [] ? "T" : []
      when "number?" then l[0].kind_of?(Integer) ? "T" : []
      when "symbol?" then l[0].class != Array ? "T" : []
      when "list?" then l[0].class == Array ? "T" : [] 
      when nil then []
      else
        if f = @fenv.assoc(x[0])
          local_env = []
          x = f[1][0]
          while x != [] do
            local_env = [[x[0], l[0]]].concat(local_env)
            x = x[1]
            l = l[1]
          end
          eval(f[1][1], local_env.concat(env))
        else
          raise "Undefined function: #{x[0]}"
        end
      end
    end
  else
    raise "class = #{x.class}"
  end
end

trap("INT","EXIT")
loop {
  begin
    print "-"
    break if (x = parse) == "quit" || x == nil
    if x.class == Array && x[0] == "define"
      print "#{define(x)}\n"
    else
      print "#{pr(eval(x, []))}\n\n"
    end
  rescue => evar
    print "error: ", evar, "\n"
    retry
  end
}
