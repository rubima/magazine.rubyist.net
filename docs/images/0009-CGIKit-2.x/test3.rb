require 'kconv'

str = "\x48\x65\x6c\x6c\x6f\x2c\x20\xa4\xeb\xa4\xd3\xa4\xde\xa1\xaa"

s      = str.tosjis
e      = str.toeuc
u      = str.toutf8 
u2     = str.kconv(Kconv::UTF8,  Kconv::EUC)

print s, "\n"
p u
p u2
p (u == u2)
p (e == str)
