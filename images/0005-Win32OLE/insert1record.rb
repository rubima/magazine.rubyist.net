require 'win32ole'

conn = WIN32OLE.new("ADODB.Connection")
connstr = "DRIVER={Microsoft Access Driver (*.mdb)};Dbq=sample1.mdb"
conn.Open connstr

begin
  sql = "INSERT INTO earthquake (Name,Day,Magnitude,NumOfDeaths,DeadOrAlive) " + 
    "VALUES ('ä÷ìåëÂêkç–','1923/09/01',7.9,142807,TRUE);"
  conn.Execute sql
rescue
  STDERR.puts sql
  STDERR.puts $!
end

conn.Close
