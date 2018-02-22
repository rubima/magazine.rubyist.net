def postfix2prefix(expr)
  expr.split(/\s+/).inject([]){|acc,x|
    p acc
    case x
    when "+", "-", "*", "/"
      acc.push([acc.pop(),acc.pop(),x].reverse())
    else
      acc.push(x)
    end
  }.flatten().join(" ")
end

def prefix2postfix(expr)
  expr.split(/\s+/).reverse.inject([]){|acc,x|
    p acc
    case x
    when "+", "-", "*", "/"
      acc.push([acc.pop(),acc.pop(),x])
    else
      acc.push(x)
    end
  }.flatten().join(" ")
end

p postfix2prefix("1 2 2 / + 3 4 5 * + -")
p prefix2postfix("- + 1 / 2 2 + 3 * 4 5")
