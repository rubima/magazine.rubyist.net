  require 'win32ole'
  illu = WIN32OLE.new('Illustrator.Application')
  #illu = WIN32OLE.connect('Illustrator.Application')
  module Illu; end
  WIN32OLE::const_load(illu, Illu)
