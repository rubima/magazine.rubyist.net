f = File.open("tmp.txt", "a")

f.flock(File::LOCK_EX)
f.write("test\r\n")
f.close
