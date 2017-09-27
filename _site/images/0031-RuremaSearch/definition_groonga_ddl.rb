# 検索対象のテーブル
table_create Entries TABLE_HASH_KEY ShortText
# 全文検索用の語彙表。トークナイザーとしてN-gramを使用。
table_create Terms TABLE_PAT_KEY ShortText --default_tokenizer TokenBigram
# 完全一致検索用の語彙表。トークナイザーはなし。
table_create Names TABLE_HASH_KEY ShortText

# 検索対象のデータ格納場所
column_create Entries name COLUMN_SCALAR Names
column_create Entries summary COLUMN_SCALAR Text
column_create Entries description COLUMN_SCALAR Text

# 全文検索用の索引
column_create Terms Entries_summary COLUMN_INDEX|WITH_POSITION Entries summary
column_create Terms Entries_description COLUMN_INDEX|WITH_POSITION Entries description

# 完全一致検索用の索引
column_create Names Entries_name COLUMN_INDEX|WITH_POSITION Entries name
