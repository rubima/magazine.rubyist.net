f = File.open("bbs.dat", "r")
arr = []
l = f.gets

while l 
  arr << l
  l = f.gets
end

f.close

i = arr.length - 1

while i >= 0 
  print arr[i]
  i = i - 1
end

