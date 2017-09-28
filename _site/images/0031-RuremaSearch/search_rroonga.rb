entries = Groonga["Entries"]
# 「description」カラムに「1つ」が含まれているエントリを検索
result = entries.select do |record|
  record.description =~ "1つ"
end
# 「sub」が含まれているエントリを検索。ただし、「name」が
# 「sub」だった場合は重みを大きくする。
result = entries.select do |record|
  target = record.match_target do |match_record|
    (match_record["name"] * 100) |
      (match_record["summary"]) |
      (match_record["description"])
  end
  target =~ "sub"
end
