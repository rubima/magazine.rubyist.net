Groonga::Schema.define do |schema|
  # 完全一致検索用の語彙表。トークナイザーはなし。
  schema.create_table("Names",
                      :type => :hash,
                      :key_type => "ShortText") do |table|
  end

  # 検索対象のテーブル
  schema.create_table("Entries",
                      :type => :hash,
                      :key_type => "ShortText") do |table|
    table.reference("name", "Names")
    table.text("summary")
    table.text("description")
  end

  # 全文検索用の語彙表。トークナイザーとしてN-gramを使用。
  schema.create_table("Terms",
                      :type => :patricia_trie,
                      :key_type => "ShortText",
                      :default_tokenizer => "TokenBigram",
                      :key_normalize => true) do |table|
   # 全文検索用の索引
    table.index("Entries.summary", :with_position => true)
    table.index("Entries.description", :with_position => true)
  end

  schema.change_table("Names") do |table|
    # 全文検索用の索引
    table.index("Entries.name", :with_position => true)
  end
end
