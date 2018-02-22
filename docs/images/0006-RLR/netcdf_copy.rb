#  Makes a copy of a NetCDF file:
#  % ruby netcdf_copy.rb path_from path_to

require "numru/netcdf"
include NumRu
usage = "\n\nUSAGE:\n% ruby #{$0} path_from path_to\n"
raise usage if ARGV.length != 2
path_from, path_to = ARGV
from = NetCDF.open(path_from)
to = NetCDF.create(path_to)
from.each_dim{|dim| to.def_dim(dim.name, dim.length_ul0)} # len==0 if unlimited
from.each_att{|att| to.put_att(att.name, att.get)}
from.each_var do |var|
  newvar = to.def_var(var.name, var.ntype, var.dim_names)
  var.each_att{|att| newvar.put_att(att.name, att.get)}
end
to.enddef
from.each_var{|var| to.var(var.name).put(var.get)}
to.close
