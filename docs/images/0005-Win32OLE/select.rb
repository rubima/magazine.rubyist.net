def generateSELECT tablename,fields,constraints
  field_statement = fields.join(",")

  sql = "SELECT #{field_statement} FROM #{tablename} "
  
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

fields = %w(Name Magnitude NumOfDeaths DeadOrAlive)
constraints = [['Name','ä÷ìåëÂêkç–'],['Day','1923/09/01']]

puts generateSELECT("earthquake",fields,constraints)
