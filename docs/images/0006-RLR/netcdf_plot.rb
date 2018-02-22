require "numru/netcdf"
require "numru/dcl"
include NumRu

#  -- read data --
file = NetCDF.open("test.nc")          # made with netcdf_create.rb
xvar = file.var("x")                   # get a NetCDFVar object named "x"
yvar = file.var("y")
uvar = file.var("u")
x = xvar.get                           # read values of the variable
y = yvar.get
u = uvar.get
xname = xvar.att('long_name').get      # get a NetCDFAtt and read values
yname = yvar.att('long_name').get
uname = uvar.att('long_name').get
xunits = xvar.att('units').get
yunits = yvar.att('units').get
uunits = uvar.att('units').get

# -- graphics --
DCL.gropn(1)
DCL.sgpset('lfull',true)       # use the whole window even if not a square
DCL.uzfact(0.8)                             # --> a bit smaller characters
DCL.grfrm
DCL.grswnd(x.min, x.max, y.min, y.max)        # physical boundaries
DCL.grsvpt(0.2, 0.8, 0.2, 0.6)                # viewport on window
DCL.grstrf                                    # fix the "transform"
DCL.uelset("ltone",true)                      # color shading from now on
DCL.uetone(u)                                 # shading
DCL.ussttl(xname, xunits, yname, yunits)      # set axis titles
DCL.usdaxs                                    # axis
DCL.udcntz(u)                                 # contour
DCL.uxmttl('t', "#{uname} [#{uunits}]", 0.0)  # title at the top
DCL.grcls
