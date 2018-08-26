---
layout: post
title: るびまバージョンアップの裏側
short_title: るびまバージョンアップの裏側
tags: 0058 migrate_rubima
---
{% include base.html %}

## はじめに

るびま編集部のmiyohideです。いつもるびまを見ていただきありがとうございます。
さて、2018年4月22日（日）にるびまのシステムを更新しました。るびま閲覧者にとって大きな変更ポイントは、

- 要望の多かったスマホでの記事表示を見やすくした
- 記事のURLが変わった

があります。また、るびまを提供するシステム構成としては、

- カスタマイズしたHikiシステムからJekyll + GitHub Pagesを使ったシステムに移行
  - Hikiを動かしていたサーバの定期メンテナンスからの開放
  - 2018年現在、マークアップ言語として親しみやすいMarkdownで記事が書ける

という変更点があります。

この記事では、るびまのシステムを更新するに至った経緯と移行方法、リリース、その後の運用について記します。

## 更新するに至った経緯

今回るびまを更新するに至った理由は次の3点があります。

- 現システムをメンテナンスできる人がいない
- 運用コストが高い
- Markdownで記事を書きたいという著者さんからの要望

それぞれ詳細を記します。

### 現システムをメンテナンスできる人がいない

るびまは2004年9月に第1号が創刊されてから毎年発行され続けているRubyist とそうでない人のためのウェブ雑誌です。

長い歴史を持つウェブ雑誌ですので、編集部メンバーも入れ替わりが発生します。段々と当時の経緯を知る人がいなくなりました。

結果として、るびまを動かしているカスタマイズしたHikiをメンテナンスできる人がいなくなり、GitHubリポジトリに多くのIssueが立てられていましたが、誰も対応できずに放置されている状態が続いていました。

### 運用コストが高い

るびまは長らく[Sqale](http://sqale.jp)と呼ばれるPaaSサービスを使って運営してきましたが、2017年5月のサービス終了に伴い独自にサーバーを構築して運用していました。このため、定期的なパッチ当てが必要になり、地味に運用負荷が高くなりました。

他にも、

- 記事を書くために必要なアカウントの作成
- RSSフィードの手動更新

など、システム由来の運用コストが積み重なり、運用コストが高い状態が続いていました。

### Markdownで記事を書きたい

また、記事の著者さんから「Markdownで記事を書きたい」という要望が多く寄せられるようになってきました。編集部は要望に答える形でMarkdownで記事をもらいHikiに変換する作業を行っていましたが、ただでさえ少ない編集部員にとってその作業も大きな負担となっていました。

## 移行

上記のような経緯から、るびまを新しいシステムに移行することにしました。新しいシステムの候補はいろいろと選択肢がありましたが、https://www.ruby-lang.org/ja/ で採用されているJekyllに目が止まり、Jekyllでシステムを構築することにしました。

### 過去記事の移行

移行において問題となったのは、800件ほどある過去記事の移行でした。移行しないということも考えましたが、スマホで読みやすくするというニーズが有ったため、全記事をHikiからMarkdownに移行することにしました。

HikiからMarkdownへの移行のために、今回簡単な移行ツール「[rubimahiki2md](https://github.com/miyohide/rubimahiki2md)」を作成しました。このツールは[HikiDoc](https://github.com/hiki/hikidoc)というHikiからHTMLやXHTMLを生成するツールに対してMarkdownへの変換機能を追加実装したものです。ここでは具体的な例で変換機能を見ていくことにします。

### インライン要素に対する変換

まず、インライン要素に対する変換です。処理対象のHikiデータから1行ずつ読み込み、Hiki記法にマッチするかどうか`case`文で見ていきます。Hiki記法で見出し要素は`!`や`!!!`などで表すのですが、これを正規表現`/\A!+/`で検出させます。

```ruby
def compile_blocks(src)
  f = LineInput.new(StringIO.new(src))
  while line = f.peek
    if f.lineno == 0
      compile_fileheader(f.gets)
      next
    end
    case line
    when COMMENT_REGEX  ## コメントの処理。正規表現/\A\/\//で検出
      f.gets
    when HEADER_REGEX   ## 見出し要素の処理。正規表現/\A!+/で検出
      compile_header(f.gets)
    when LIST_REGEX     ## リスト要素の処理。正規表現/\A#{Regexp.union("*", "#")}+/で検出
      compile_list(f)
  （以下省略）
end
```

あとは各インライン要素ごとに用意した変換メソッドを呼び出します。見出し要素の例で言えば、`compile_header`メソッドを呼び出し、見出し要素のレベルの取得と見出し文字列を取得後、Markdown変換処理である`headline`メソッドを呼び出します。

```ruby
def compile_header(line)
  @header_re ||= /\A!{1,6}/
  level = 1 + (line.slice!(@header_re).size - 1)
  title = strip(line)  ## 前後の空白文字を削除
  @output.headline(level, compile_inline(title))
end
```

Markdown変換処理である`headline`メソッドでは引数で与えられた見出し要素のレベルと見出し文字列をもとにMarkdown文字列を生成します。

```ruby
def headline(level, title)
  @f.puts
  @f.puts '#' * (level+1) + " #{title}"
end
```

### ブロック要素に対する変換

続いて複数行に渡って意味を成すブロック要素に対する変換について見ていきます。これも考え方はインライン要素の場合と同様で正規表現によってブロック要素の開始と終了を検出し、変換処理を行います。

例として引用記法についてみてみます。Hikiにおける引用は`" `ではじめる行として表現します。これを正規表現`\A""[ \t]?`で検索します。正規表現にマッチしたら、以下に示す`compile_blockquote`メソッドを呼び出します。

```ruby
BLOCKQUOTE_REGEX = /\A""[ \t]?/
def compile_blockquote(f)
  @output.blockquote_open
  f.while_match(BLOCKQUOTE_REGEX) do |line|
    @output.blockquote_line(evaluate_plugin_block(line.sub(BLOCKQUOTE_REGEX, "")))
    skip_comments(f)
  end
  @output.blockquote_close
end
```

`compile_blockquote`メソッドでは、引用の開始、引用の内部、引用の終了ごとにそれぞれMarkdownの変換メソッド`blockquote_open`、`blockquote_line`、`blockquote_close`を呼び出し変換処理を行っています。

```ruby
def blockquote_open
  @f.puts
end
def blockquote_line(str)
  @f.puts "> #{escape_markdown(str)}"
end
def blockquote_close
  @f.puts
end
```

### プラグイン

るびまはHikiで提供している記法以外にプラグインを使って独自の記法をサポートしていました。例えば脚注を表現する`{% raw %}{{fn('脚注の内容')}}{% endraw %}`や画像を埋め込む`{% raw %}{{attach_view('ファイル名')}}{% endraw %}`などがプラグインを使っていました。

これらプラグインの変換についても`{% raw %}{{{% endraw %}`と`{% raw %}}}{% endraw %}`を正規表現で検出し、プラグインの内容（`fn('脚注の内容')`や`attach_view('ファイル名')`など）を取り出します。

その後、以下のソース片が示すように[hiki/pluginutil.rb](https://github.com/hiki/hiki/blob/6610f9f53c394a28f202dc5ae0209615a02ae824/lib/hiki/pluginutil.rb)にある`Hiki::Util.methodwords`を使ってプラグインの内容をメソッド名と引数とに分割し、`send`でプラグインごとの変換処理を呼び出し変換を行いました。

```ruby
def inline_plugin(src)
  method, *args = Hiki::Util.methodwords(src)
  begin
    send(method, *args)
  rescue NoMethodError
    # 省略。エラー処理を実装
  end
end

# 画像埋め込みプラグイン対応
def attach_view(*args)
  # タイトルにある赤色矢印記号は分かりやすい名前に変更。一括変換する
  if args[0] == 'u26.gif'
    "![title_mark.gif]({{site.baseurl}}/images/title_mark.gif)"
  else
    "![#{args[0]}](#{attach_path(args[0])})"
  end
end
```

## リリース

このようにして過去記事をすべてMarkdownに変換し、JekyllでHTMLファイルを生成、GitHub Pages上にWebページとして表示させることができるようになりました。
リリース直後に55号のindexページでリンクのテキストが抜けていることがわかりましたが、[@yancyaさんがpull requestを出してくれた](https://github.com/rubima/magazine.rubyist.net/pull/39)おかげで早急に対応することができました。リリース直後に早速読者の方からのフィードバックで記事のメンテナンスができ、今回の移行の成果を感じられた出来事でした。

## その後の運用

昨年までは定期的にるびまを可動しているサーバの定期メンテナンスを手作業で実施していましたが、現在はそのような作業がなくなり運用負荷が大きく減ったことを実感しています。結果として、るびまに対するメンテナンスに時間を掛けることができ、

- RubyKaigi 2018直前特集号のリリース
- 動かなくなっていたSNSボタンの修正
- HTTPS化

などを行っています。

みなさまに多くの記事を届けられるよう、るびまを続けていこうと考えています。今後もるびまをよろしくお願いします。
