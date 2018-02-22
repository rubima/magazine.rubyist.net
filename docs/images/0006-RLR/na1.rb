require "narray"
na = NArray.float(3,2).indgen!         # indgen! --> 0,1,2,..
nb = NArray.to_na( [ [1.0],            # Will be a float NArray
                     [10 ] ] )
nc = NArray.sfloat(12).random!
print "na = "; p na
print "nb = "; p nb
print "nc = "; p nc
print "na + nb = "; p na + nb
print "na >= nb = "; p na >= nb
na[na >= nb] = 999
print "na[na>=nb]=999 --> na = "; p na

print "na[0..1,true] = "; p na[0..1,true]
print "na[true,-1]";      p na[true,-1]
print "na[[0,2,0],true]"; p na[[0,2,0],true]

include NMath
print "sqrt(na) = "; p sqrt(na)
print "log10(na + 1) = "; p log10(na + 1)
