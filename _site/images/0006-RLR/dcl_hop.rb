require "narray"
require "numru/dcl"
include NumRu                 # Most dennou-ruby products are in it
include NMath                 # Math module for NArray

n = 400
dt = 2*PI/(n-1)
t = NArray.sfloat(n).indgen! * dt        # 0 <= t <= 2*pi
x = 1e2 *sin(4*t)
y = 1e-3*cos(5*t)+6

DCL::gropn(1)                      # 1=>Display; 2=>PS file; 4=>Gtk
DCL::grfrm                               # initilize a frame (page)
DCL::ussttl('X-TITLE', 'x-unit', 'Y-TITLE', 'y-unit')
DCL::usgrph(x, y)
DCL::grcls
