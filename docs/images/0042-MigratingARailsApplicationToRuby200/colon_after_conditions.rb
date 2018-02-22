y = y0
while y > height:
  x = x0
  while x > width:
    calculate(x, y, dx, dy)
    x += dx
  end
  y += dy
end
