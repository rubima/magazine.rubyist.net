=begin
=dcl_3D.rb: 3D projection of 2D plots
==History
* 2005/04 Horinouchi: modifyied map3d5.rb, a demo program in ruby-dcl
=end

require "narray"
require "numru/dcl"
include NumRu
include NMath

nx = 21
ny = 21
xmin = -10
xmax = 10
ymin = -10
ymax = 10
vxmin = 0.2
vxmax = 0.8
vymin = 0.1
vymax = 0.5
zmin = 0.0
zmax = 20
vzmin = 0.0
vzmax = 0.6
xvp3 = -0.7
yvp3 = -0.7
zvp3 = 1.2
xfc3 = (vxmax-vxmin)/2
yfc3 = (vymax-vymin)/2
zfc3 = (vzmax-vzmin)/2
dx1 = 1
dx2 = 5
dy1 = 1
dy2 = 4
dz1 = 1
dz2 = 5
kmax = 5
pmin = 0
pmax = 1

#-- data ---
x = xmin + NArray.sfloat(nx,   1).indgen! * ((xmax-xmin)/(nx-1.0))
y = ymin + NArray.sfloat(1,   ny+1).indgen! * ((ymax-ymin)/(ny-1.0))
u =     x + 0.2*y
v = 0.2*x -     y 
p = exp(-x**2/64 -y**2/25)

#-- graph ---
iws = (ARGV[0] || (puts ' WORKSTATION ID (I)  ? ;'; DCL::sgpwsn; gets)).to_i
DCL::sgopn iws

DCL::sgfrm

#-- X-Y 平面: 下レベル ----
DCL::sgswnd(xmin, xmax, ymin, ymax)
DCL::sgsvpt(vxmin, vxmax, vymin, vymax)
DCL::sgstrn(1)
DCL::sgstrf

DCL::scspln(1, 2, vzmin)
DCL::scseye(xvp3, yvp3, zvp3)
DCL::scsobj(xfc3, yfc3, zfc3)
DCL::scsprj

DCL::uxaxdv('B', dx1, dx2)
DCL::uxaxdv('T', dx1, dx2)
DCL::uxsttl('B', 'X-axis', 0.0)

DCL::uyaxdv('L', dy1, dy2)
DCL::uyaxdv('R', dy1, dy2)
DCL::uysttl('L', 'Y-axis', 0.0)

DCL::ugrset('RSIZET', 0.014)
DCL::ugvect(u, v)

#-- X-Y 平面: 上レベル ----
vzlev = vzmin + (vzmax-vzmin)*0.6
DCL::scspln(1, 2, vzlev)
DCL::scsprj

dp = (pmax-pmin)/kmax.to_f
for k in 1..kmax
  tlev1 = (k-1)*dp
  tlev2 = tlev1 + dp
  ipat  = 600 + k - 1
  DCL::uestlv(tlev1, tlev2, ipat)
end
DCL::uetone(p)

DCL::udlset('LMSG', false)
DCL::udgclb(p, 0.1)
DCL::udcntr(p)
DCL::slpvpr(1)

#-- X-Z 平面 ----
DCL::sgswnd(xmin, xmax, zmin, zmax)
DCL::sgsvpt(vxmin, vxmax, vzmin, vzmax)
DCL::sgstrn(1)
DCL::sgstrf

DCL::scspln(1, 3, vymax)
DCL::scsprj

DCL::uzinit
DCL::uyaxdv('L', dz1, dz2)
DCL::uysttl('L', 'Z-axis', 0.0)

DCL::sgcls

