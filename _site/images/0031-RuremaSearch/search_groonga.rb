# 「description」カラムに「1つが」含まれているエントリを検索
select Entries description "1つ"
[[...],
 [[[...],
   [..., ["_key", ...], ["name", ...], ["summary", ...], ["description", ...], ...]],
  [..., "String#sub", "sub", "置換", "1つ置換", ...],
  ...]]
# 「sub」が含まれているエントリを検索。ただし、「name」が
# 「sub」だった場合は重みを大きくする。
select Entries "name * 100 | summary | description" "sub"
[[...],
 [[[...],
   [..., ["_key", ...], ["name", ...], ["summary", ...], ["description", ...], ...]],
  [..., "String#sub", "sub", "置換", "1つ置換", ...],
  ...]]
