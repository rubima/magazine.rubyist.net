def generateUPDATE tablename,values,constraints
  fields = values.map{|field,value,flag| field}
  field_statement = fields.join(",")

  sql = "UPDATE #{tablename} SET "
  vs = values.map do |field,value,rawvalue|
    if rawvalue
      "#{field} = #{value}"
    else
      "#{field} = '#{value}'"
    end
  end
  set_statement = vs.join(" , ")
  sql.concat set_statement
  
  where_statement = constraints.map do |field,value,rawvalue|
    if rawvalue
      "#{field} = #{value}"
    else
      "#{field} = '#{value}'"
    end
  end.join(" AND ")
  
  sql.concat " WHERE #{where_statement};"
  return sql
end

values = [['Magnitude',7.9,true],
  ['NumOfDeaths',142807,true],
  ['DeadOrAlive',"TRUE",true]]

constraints = [['Name','ä÷ìåëÂêkç–'],['Day','1923/09/01']]

puts generateUPDATE("earthquake",values,constraints)
