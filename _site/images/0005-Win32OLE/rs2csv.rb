require 'win32ole'

def startADO filename 
  cn = WIN32OLE.new("ADODB.Connection")
  connstr = "DRIVER={Microsoft Access Driver (*.mdb)};Dbq=#{filename}"
  cn.Open connstr
  begin 
    yield cn
  ensure
    cn.Close
  end
end

module Recordset
  def [] field
    self.Fields.Item(field).Value
  end

  def []= field,value
    self.Fields.Item(field).Value = value
  end
  
  def each_record
    if self.EOF or self.BOF
      return 
    end
    self.MoveFirst
    until self.EOF or self.BOF
      yield self
      self.MoveNext
    end
  end
end


startADO("sample1.mdb") do |cn|
  sql = "SELECT * FROM earthquake;"
  rs = cn.Execute(sql)
  rs.extend Recordset
  fields = ["Day","Name","Magnitude","NumOfDeaths","DeadOrAlive"]
  rs.each_record do |rs|
    values = fields.map do |field|
      rs[field]
    end
    puts values.join(",")
  end
end
