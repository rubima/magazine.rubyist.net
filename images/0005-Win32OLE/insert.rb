 def generateINSERT tablename,values
   fields = values.map{|field,value,flag| field}
   field_statement = fields.join(",")
   
   sql = "INSERT INTO #{tablename} ( #{field_statement} ) "
   vs = values.map do |field,value,rawvalue|
     if rawvalue
       "#{value}"
     else
       "'#{value}'"
     end
   end
   value_statement = vs.join(",")
   sql.concat "VALUES ( #{value_statement} )"
   return sql
 end
 
 values = [
   ['Name','ä÷ìåëÂêkç–'],
   ['Day','1923/09/01'],
   ['Magnitude',7.9,true],
   ['NumOfDeaths',142807,true],
   ['DeadOrAlive',"TRUE",true]]
 
 puts generateINSERT("earthquake",values)
