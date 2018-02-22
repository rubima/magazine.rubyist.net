=begin
=dcl_map_proj.rb: map projection demo
==History
* 2005/04 Horinouchi: modifyied map3d2.rb, a demo program in ruby-dcl
=end

require "narray"
require "numru/dcl"
include NumRu
include NMath

#-- data ---
nx = 37
ny = 37
xmin = 0
xmax = 360
ymin = -90
ymax = 90
lon = ( NArray.sfloat(nx+1,   1).indgen!*(xmax-xmin)/nx + xmin ) * (PI/180)
lat = ( NArray.sfloat(1,   ny+1).indgen!*(ymax-ymin)/ny + ymin ) * (PI/180)
sin_lat = sin(lat)
p = 3*sqrt(1-sin_lat**2)*sin_lat*cos(lon) - 0.5*(3*sin_lat**2-1)

#-- graph ---
iws = ARGV[0] || 1
DCL::gropn iws

DCL::grfrm
DCL::sgswnd(xmin, xmax, ymin, ymax)
DCL::sgsvpt(0.1, 0.9, 0.1, 0.9)
DCL::sgssim(0.4, 0.0, 0.0)
DCL::sgsmpl(135.0, 35.0, 0.0)
DCL::sgstxy(-180.0, 180.0, 0.0, 90.0)
DCL::sgstrn(30)
DCL::sgstrf

DCL::uelset("ltone",true)
DCL::uetone(p)

DCL::umpmap('coast_world')
DCL::umpglb

DCL::grcls

