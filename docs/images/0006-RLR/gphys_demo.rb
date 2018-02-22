require "numru/ggraph"      # require "numru/gphys" if graphic is not needed
include NumRu

gphys = GPhys::IO.open('test.nc','u')   # create a GPhys obj on data in file

DCL.gropn(1)
DCL.sldiv('y',2,1)                   # 'y'oko narabe, 2 by 1 window division
GGraph.contour( gphys )
GGraph.line( gphys.cut('y'=>-15..15).mean('y') )
DCL.grcls
