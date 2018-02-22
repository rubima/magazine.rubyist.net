require "kconv"

f = open("euc_jp.txt")
euc = f.read
f.close

f = open("iso_2022_jp.txt")
iso = f.read
f.close

out = open("euc_sjis.txt", "w")
out.write(Kconv.tosjis(euc))
out.close

out2 = open("iso_sjis.txt", "w")
out2.write(Kconv.tosjis(iso))
out2.close

