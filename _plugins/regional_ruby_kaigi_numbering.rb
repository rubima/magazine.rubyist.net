# 「RegionalRubyKaigi レポート (NN) ...」というタイトルの (NN) を
# 全 RegionalRubyKaigi 記事を created_on 順に並べて自動採番する。
#
# ソース側の番号は (NUM) のようなプレースホルダでも、既存の (12) のような
# 数字でも構わない。ビルド時に正しい連番に書き換える。
# 「(特別編)」のような数字でも NUM でもないものは対象外。

module Jekyll
  module RegionalRubyKaigiNumbering
    # 数字または NUM プレースホルダのみ対象。
    TITLE_PATTERN = /\ARegionalRubyKaigi レポート \((\d+|NUM)\)/
    DIGIT_PATTERN = /\A\d+\z/
    TARGET_FIELDS = %w[title short_title].freeze

    def self.apply(site)
      targets = site.posts.docs.select do |post|
        post.data["title"] =~ TITLE_PATTERN
      end

      targets.sort_by! do |post|
        title = post.data["title"]
        current = title[TITLE_PATTERN, 1]
        # 既存番号がある場合は created_on 内での順序保存に使う。
        # プレースホルダ (NUM) は無限大扱いで末尾へ。
        num_key = current =~ DIGIT_PATTERN ? current.to_i : Float::INFINITY
        date_key = post.data["created_on"].to_s
        [date_key, num_key, post.path]
      end

      targets.each_with_index do |post, idx|
        number = format("(%02d)", idx + 1)
        TARGET_FIELDS.each do |field|
          value = post.data[field]
          next unless value =~ TITLE_PATTERN
          post.data[field] = value.sub(TITLE_PATTERN) { "RegionalRubyKaigi レポート #{number}" }
        end
      end
    end
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  Jekyll::RegionalRubyKaigiNumbering.apply(site)
end
