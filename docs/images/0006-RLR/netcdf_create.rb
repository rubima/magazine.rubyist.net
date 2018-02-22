require "numru/netcdf"
include NumRu
include NMath

#   -- create a new dataset --
file = NetCDF.create("test.nc")             # .nc is the standard suffix

#   -- define data --
nx, ny = 50, 25
xdim = file.def_dim("x",nx)
ydim = file.def_dim("y",ny)
require "date"
file.put_att("history","Created by #{$0}  #{Date.today}")

xvar = file.def_var("x","sfloat",[xdim])        # x coordinate variable
xvar.put_att("long_name","longitude")
xvar.put_att("units","degrees")

yvar = file.def_var("y","sfloat",[ydim])        # y coordinate variable
yvar.put_att("long_name","latitude")
yvar.put_att("units","degrees")

uvar = file.def_var("u","sfloat",[xdim,ydim])   # 2D along x and y 
uvar.put_att("long_name","wind speed")
uvar.put_att("units","m/s")

file.enddef                                  # end the define mode

#   -- create data values for test --
x = NArray.sfloat(nx, 1).indgen! * (360.0/(nx-1))
y = NArray.sfloat(1, ny).indgen! * (180.0/(ny-1)) - 90.0
x_rad = x * (PI/180)
y_rad = y * (PI/180)
u = (30 + 5*cos(2*x_rad)) * ( 0.2 - cos(3*y_rad) )

#   -- write data values --
xvar.put( x )
yvar.put( y )
uvar.put( u )

file.close
