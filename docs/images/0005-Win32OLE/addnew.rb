require 'win32ole'

module Recordset
  def [] field
    self.Fields.Item(field).Value
  end

  def []= field,value
    self.Fields.Item(field).Value = value
  end
end

def startRS filename,sql
  cn = WIN32OLE.new("ADODB.Connection")
  rs = WIN32OLE.new("ADODB.Recordset")
  connstr = "DRIVER={Microsoft Access Driver (*.mdb)};Dbq=#{filename}"
  cn.ConnectionString = connstr
  cn.Open
  rs.Open sql,cn,3,3
  rs.extend Recordset
  begin 
    yield rs
  ensure
    rs.Close
    cn.Close
  end
end

sql = "SELECT * FROM earthquake;"
startRS("sample1.mdb",sql) do |rs|
  newrecords = 
    [["Day" , "2000-10-06"],
    ["Name","íπéÊåßêºïîínêk"],
    ["Magnitude","7.3"],
    ["NumOfDeaths","0"],
    ["DeadOrAlive","False"]]
  rs.AddNew
  newrecords.each do |field,value|
    rs[field] = value
  end
  rs.Update
end
