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

csvfields = %w(Day Name Magnitude NumOfDeaths DeadOrAlive)
insertfields =  [
  ['Name',false],
  ['Day',false],
  ['Magnitude',true],
  ['NumOfDeaths',true],
  ['DeadOrAlive',true]]

startADO("sample1.mdb") do |conn|
  ARGF.each_line do |line|
    record = {}
    csvfields.zip(line.chomp.split(/,/)) do |field,value|
      record[field] = value
    end
    values = insertfields.map do |field,rawvalue| 
      if rawvalue
        "#{record[field]}"
      else
        "'#{record[field]}'"
      end
    end
    fieldStatement = insertfields.map{|f,v| f}.join(',')
    
    sql = "INSERT INTO earthquake (#{fieldStatement}) " + 
      "VALUES ( #{values.join(',')} );"
    begin
      conn.Execute sql
    rescue
      STDERR.puts sql
      STDERR.puts $!
    end
  end
end
