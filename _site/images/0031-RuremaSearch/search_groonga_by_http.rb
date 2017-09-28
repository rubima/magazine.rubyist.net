# 「description」カラムに「1つが」含まれているエントリを検索
% wget -O - 'http://localhost:10041/d/select?table=Entries&match_columns=description&query=1つ'
[[...],
 [[[...],
   [..., ["_key", ...], ["name", ...], ["summary", ...], ["description", ...], ...]],
  [..., "String#sub", "sub", "置換", "1つ置換", ...],
  ...]]
# 「sub」が含まれているエントリを検索。ただし、「name」が
# 「sub」だった場合は重みを大きくする。
% wget -O - 'http://localhost:10041/d/select?table=Entries&match_columns=name*100|summary|description&query=sub'
[[...],
 [[[...],
   [..., ["_key", ...], ["name", ...], ["summary", ...], ["description", ...], ...]],
  [..., "String#sub", "sub", "置換", "1つ置換", ...],
  ...]]
