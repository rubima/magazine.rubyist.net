---
layout: post
title: RegionalRubyKaigi レポート 平成 Ruby 会議 01
short_title: 平成 Ruby 会議 01 レポート
tags: 0061 regionalRubyKaigi
post_author: ryamakuchi
created_on: 2020-01-26
---
{% include base.html %}

## はじめに

令和元年の暮れに、[平成 Ruby 会議 01](https://heiseirb.github.io/kaigi01/) が開催されました。本記事はその開催レポートです。

2トラックのため全てのセッションは観れなかったのですが、執筆者が観に行くことのできたセッションについては感想も載せています。
また、セッションやイベントの感想については、執筆者個人の視点からのレポートとなっておりますので、あらかじめご了承いただければ幸いです。

### 平成.rb ってなに？

[平成.rb](https://heiseirb.connpass.com/) とは、平成生まれの Ruby エンジニアで集まり、ステップアップしていきたいという思いで作ったコミュニティです。
普段の勉強会では LT 会とモブプロ会を交互に行っています。

※ 名前から色々と誤解されることもありますが、**上の世代との壁は作らず、むしろ積極的な交流を推奨する**コミュニティです。

詳しいコンセプトなどを知りたい方は[平成.rb の方針](https://docs.google.com/presentation/d/1Gq1dKeML_MLQIilxlU09VBKcbe_b2SBlx8Q0WHaPXXA/)をご覧ください。

## 開催概要

### テーマ

令和元年の暮れに、平成生まれだけでなく、各世代で交流できるカンファレンスを開催する

### 開催日

2019-12-14（土）12:50 - 19:30

### 会場

[株式会社ドリコム](https://www.drecom.co.jp/company/accessmap/)

キーノートや LT 以外は、会場を分けて 2トラックでやらせてもらいました。

### 主催

平成.rb

### 参加者

およそ 180名

### 公式サイト

<https://heiseirb.github.io/kaigi01/>

### 公式タグ

[#heiseirubykaigi](https://twitter.com/hashtag/heiseirubykaigi/)

### ツイートまとめ

[平成 Ruby 会議 01 ツイート総集編 - Togetter](https://togetter.com/li/1451023/)

## [Opening talk] 平成.rbってなに？

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/opening.jpg)

[平成 Ruby 会議オープニング資料](https://docs.google.com/presentation/d/1mREH-7Um9Ek6Tld_KOTLaKKpw1MRM5UYZ3rHZ3UM0TM/)

実行委員長の [@tashiro_rb](https://twitter.com/tashiro_rb) がオープニングトークをしました。

会場では[平成世代にグッとくるプレイリスト](https://t.co/BH9CAZ6oKS)が流れていました。

## [Keynote] What is expected?

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/keynote1.jpg)

- 発表者: [@yui-knk](https://github.com/yui-knk)
- スライド: [What is expected? - Speaker Deck](https://speakerdeck.com/yui_knk/what-is-expected)
- ツイート: <https://togetter.com/li/1451564>

キーノートは @yui-knk さんの、Ruby の構文解析についてのお話でした。

しょっぱなからとても高レベルな内容で、事前に[Ruby のしくみ](https://www.amazon.co.jp/dp/4274050653)を読んだことがあるとより楽しめそうでした。

また、キーノートの順番については以下のような思惑があり決まったそうです。

> @yui-knk さんの keynote が top なのは、頭が未だ疲れ切っていない朝のうちにコアな話を入れておこうという策でした。@yui-knk さんに話したら笑ってくれました。

参照：[平成 Ruby 会議 01 をおえて｜tashiro｜note](https://note.com/tashiro_rb/n/nbe353bad81d7)

## [Track A]

### Ruby 2.7 ISeq バイナリ表現の改善について +α

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackA1.jpg)

- 発表者: [@NagayamaRyoga](https://github.com/NagayamaRyoga)
- スライド: [2019/12/14 平成 Ruby 会議 - Google スライド](https://docs.google.com/presentation/d/1kX7aIW0A4Eti8TsoWlS5acTuf0ns9nOnmJYXwCQLp2Y/)
- ツイート: <https://togetter.com/li/1451568>

Cookpad インターン生 @NagayamaRyoga さんの発表です。

Rails アプリケーションの起動を高速化するために行った取り組みが興味深かったです。
ISeq のシリアライズは C で実装されているため、C でどのように実装していったのかを図解付きで詳しく説明されていました。

### あなたのその gem、Windows でも動きますか？

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackA2.jpg)

- 発表者: [@unasuke](https://github.com/unasuke)
- スライド: [heiseirubykaigi-1 - unasuke - Rabbit Slide Show](https://slide.rabbit-shocker.org/authors/unasuke/heiseirubykaigi-1/)
- ツイート: <https://togetter.com/li/1451570>

トラック A の司会進行でもある @unasuke さんの発表です。

Middleman 本体に PR を出した際に、Windows での挙動を確認されたことから、Windows でも Gem が動くようにする取り組みについてのお話です。
「みなさんが最初に触った OS は？」というアンケートで、Windows が多かったのが印象的でした。なつかしいですね。

### ActiveSupport::Concern で開くメタプログラミングの扉

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackA3.jpg)

- 発表者: [@expajp](https://github.com/expajp)
- スライド: [ActiveSupport::Concern で開くメタプログラミングの扉 / The door of meta-programing is opened by ActiveSupport::Concern - Speaker Deck](https://speakerdeck.com/expajp/the-door-of-meta-programing-is-opened-by-activesupport-concern)
- ツイート: <https://togetter.com/li/1451571>

### 新規プロジェクトのリードエンジニアになるために

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackA4.jpg)

- 発表者: [@hotatekaoru](https://github.com/hotatekaoru)
- スライド: [新規プロジェクトのリードエンジニアになるために - Speaker Deck](https://speakerdeck.com/hotatekaoru/xin-gui-puroziekutofalseridoenzinianinarutameni)
- ツイート: <https://togetter.com/li/1451575>

平成.rb でおなじみ、メドピアの @hotatekaoru さんの発表です。

「なんでリファクタリング好きなんだろう？」という問いから始まり、メタ的な思考から実際に行ってみた内容をみることができ、納得感がある発表だなと思いました。
新規プロジェクト立ち上げの際に大いに参考になりそうな rails template が気になりました。

[hotatekaoru/rails_template](https://github.com/hotatekaoru/rails_template)

### Proc のススメ

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackA5.jpg)

- 発表者: [@sanfrecce-osaka](https://github.com/sanfrecce-osaka)
- スライド: [Proc のススメ / recommendation-of-proc - Speaker Deck](https://speakerdeck.com/sanfrecce_osaka/recommendation-of-proc)
- ツイート: <https://togetter.com/li/1451577>

---

このセッションの次の時間に、モブプロを行いました（後述）

---

### 逃げちゃダメだ！既存プロダクトに RSpec を導入していく戦い

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackA6.jpg)

- 発表者: [@ryamakuchi](https://github.com/ryamakuchi)
- スライド: [逃げちゃダメだ！既存プロダクトに RSpec を導入していく戦い](https://slides.com/ryamakuchi/introduce-rspec-to-existing-products#/)
- ツイート: <https://togetter.com/li/1451580>

本レポートを書いた @ryamakuchi の発表です。

テストカバレッジが 5% の既存プロダクトに立ち向かうという内容のお話です。
後日談ですが、このあとカバレッジが 20% を超えました（転職する前に 20% を超えて、本当に良かったです）

### Ruby 力を上げるためのコードリーディング

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackA7.jpg)

- 発表者: [@kinoppyd](https://github.com/kinoppyd)
- スライド: [20191214_heisei_ruby_kaigi - Google スライド](https://docs.google.com/presentation/d/1de64myiozcpiS18fvrmmlYLhXdl0y_qlUc-2TGZkNhY/)
- ツイート: <https://togetter.com/li/1451585>

### 階層的クラスタリングを Ruby で表現する

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackA8.jpg)

- 発表者: [@ayumitamai97](https://github.com/ayumitamai97)
- スライド: [階層的クラスタリングを Ruby で表現する / Implement Hierarchical Clustering Analysis Using Ruby - Speaker Deck](https://speakerdeck.com/ayumitamai97/implement-hierarchical-clustering-analysis-using-ruby)
- ツイート: <https://togetter.com/li/1451586>

@ayumitamai97 さんの「階層的クラスタ分析を Ruby で実装してみる」という、個性的でおもしろそうな発表です。

階層的クラスタリングの概要から始まり、**平成の邦楽ヒット曲の歌詞**を使って分析を行うという、平成 Ruby 会議らしいとてもエモい内容でした。
サンプルコードはこちらの GitHub に置いてあります。

[ayumitamai97/hierarchical-analysis-ward-method: 2019/12/14 平成Ruby会議セッションで使用したコード（前処理+ウォード法）](https://github.com/ayumitamai97/hierarchical-analysis-ward-method)

### Play with Ruby

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackA9.jpg)

- 発表者: [@Sean0628](https://github.com/Sean0628)
- スライド: [Play with Ruby - Speaker Deck](https://speakerdeck.com/sean0628/play-with-ruby-964daf99-4e63-4e97-b449-0823f586d966)
- ツイート: <https://togetter.com/li/1451587>

### 真の REST

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackA10.jpg)

- 発表者: [@tkawa](https://github.com/tkawa)
- スライド: [真の REST](https://www.slideshare.net/tkawa1/truerest20191214)
- ツイート: <https://togetter.com/li/1451589>

## [Track B]

### Textbringer でつくる Textbringer

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackB1.jpg)

- 発表者: [@shugo](https://github.com/shugo)
- スライド: [heiseirk01/README.md at master · shugo/heiseirk01](https://github.com/shugo/heiseirk01/blob/master/README.md)
- ツイート: <https://togetter.com/li/1451704>

※ 当日のプレゼンテーションは [Textbringer](https://github.com/shugo/textbringer) を使って行われました

### SimpleDelegator 活用のご提案

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackB2.jpg)

- 発表者: [@fujimura](https://github.com/fujimura)
- スライド: [SimpleDelegator 活用のご提案 - Speaker Deck](https://speakerdeck.com/fujimura/simpledelegatorhuo-yong-falsegoti-an)
- ツイート: <https://togetter.com/li/1451710>

### Ruby on Jeeeeeeeeets!! ✨🚀✨

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackB3.jpg)

- 発表者: [@AquaLamp](https://github.com/AquaLamp)
- スライド: [Ruby on Jeeeeeeeeets!! ✨🚀✨ - Speaker Deck](https://speakerdeck.com/aqualamp/ruby-on-jeeeeeeeeets)
- ツイート: <https://togetter.com/li/1451714>

Jets に詳しい管理栄養士の @AquaLamp さんによる発表です。

セッション時のスライドのアニメーションが死ぬほどキレイで、しかもパワポで作ったと聞いてびっくりしました。
Jets が Rails に似ていること、なおかつサーバーレスに異世界転生！**クラウド無双**... という具合にパワーワードが頭から離れない、良いセッションでした。

### Async / Await functions in Ruby

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackB4.jpg)

- 発表者: [@sat0yu](https://github.com/sat0yu)
- スライド: [Async / Await functions in Ruby - Google スライド](https://docs.google.com/presentation/d/1tI4RKB6XmRj-cl5Bpvv9uiMoab6RlDy-v5ZWfLVQcfY/)
- ツイート: <https://togetter.com/li/1451718>

### 既存 RailsApplication の高速化

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackB5.jpg)

- 発表者: [@cobafan](https://github.com/cobafan)
- ツイート: <https://togetter.com/li/1451720>

平成.rb オーガナイザーである @cobafan さんの発表です。

既存の Rails アプリケーションを高速化するために、ベストプラクティスなコードが実装されてほしい。
CI などでベストプラクティスなコードになっているかをチェックできるような Gem を作っている、という内容でした。

セッション後の質問タイムで実装で困っていることの解決法を募ったところ、@pocke さん達が解決法のアイディアを出していて、つよい... となりました。

### Ruby で JVM を実装してみる

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackB6.jpg)

- 発表者: [@daikimiura](https://github.com/daikimiura)
- スライド: [Ruby で JVM を実装してみる / Implement JVM with Ruby - Speaker Deck](https://speakerdeck.com/daikimiura/implement-jvm-with-ruby)
- ツイート: <https://togetter.com/li/1451722>

@daikimiura さんの発表です。モブプロの裏番組でしたが、タイトルの通りおもしろそうな発表でたくさん人が集まっていました。

Go や Rust や PHP で JVM を実装している人たちにインスパイアされ、Ruby でも実装できるはず！と、思い作ってみた、という内容です。
クラスファイルを読み取り、書いてある命令を実行する箇所の解説が、JVM の仕様を少し知れた良い機会になりました。

[daikimiura/merah: merah is a JVM implementation by Ruby](https://github.com/daikimiura/merah)

---

トラック A でモブプロをやっている間、トラック B は休憩所に。

お父さんに連れられて、小学校 2年生の小さいお子さん（最年少！）も参加していました。

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/child.jpg)

---

### Good to know yaml

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackB7.jpg)

- 発表者: [@MITSUBOSHI](https://github.com/MITSUBOSHI)
- スライド: [Good to know yaml - Speaker Deck](https://speakerdeck.com/mitsuboshi/good-to-know-yaml)
- ツイート: <https://togetter.com/li/1451725>

### Rust で gem を作ろう

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackB8.jpg)

- 発表者: [@atomiyama](https://github.com/atomiyama)
- スライド: [Rust で gem を作ろう - Speaker Deck](https://speakerdeck.com/atomiyama/rustdegemwozuo-rou)
- ツイート: <https://togetter.com/li/1451726>

### やわらか増税

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackB9.jpg)

- 発表者: [@ikaruga777](https://github.com/ikaruga777)
- スライド: [yawaraka zouzei - Speaker Deck](https://speakerdeck.com/uvb_76/yawaraka-zouzei)
- ツイート: <https://togetter.com/li/1451731>

### ActiveRecord の pluck メソッドがおかしな挙動をしたので調べてみた

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackB10.jpg)

- 発表者: [@mtkasima](https://github.com/mtkasima)
- スライド: [平成Ruby会議01.pdf - Speaker Deck](https://speakerdeck.com/mtkasima/ping-cheng-rubyhui-yi-01)
- ツイート: <https://togetter.com/li/1451734>

平成.rb オーガナイザーでトラック B の司会進行 @mtkasima さんの発表です。

途中でおかしな挙動をしている pluck の実装を追うために、ActiveRecord の中身を追うライブコーディングが始まったのが観ていて楽しかったです。
そして最後に、**pluck_for_kasima** というメソッドを爆誕させていたのが、とても彼らしいエンタメ性あふれる発表でした。

### Regression Test for RuboCop

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/trackB11.jpg)

- 発表者: [@pocke](https://github.com/pocke)
- スライド: [Regression Test for RuboCop: 平成Ruby会議 - Google スライド](https://docs.google.com/presentation/d/e/2PACX-1vSjKwZo-G0_hVk2WE_ALk-qyWX_QKD45BNZ460jwAkzyyw2mxvzxV-uGqznBg2DyiM8XNje5RoAq24w/embed?start=false&loop=false&delayms=3000&slide=id.p)
- ツイート: <https://togetter.com/li/1451736>

RuboCop コアチームメンバーである @pocke さんの発表です。

RuboCop はこわれやすい。なぜ Regression test が必要か、そして Regression test の仕組みについてから説明していただきました。
実際に Regression test をしてみて RuboCop やプラグインのバグを見つけよう、というところがワクワクするような内容でした。

## [Track A] モブプログラミング

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">モブプロってます！<a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a> <a href="https://t.co/PXnrbswvps">pic.twitter.com/PXnrbswvps</a></p>&mdash; かしま (@mtkasima) <a href="https://twitter.com/mtkasima/status/1205745896324882432?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

平成.rb の勉強会では、普段 LT 会とモブプロ会を交互に行っています。

普段の勉強会の様子を体験してもらえるようなコンテンツを用意しました。

- A コース（Enumerable 再実装コース）
- B コース（OSS チャレンジコース）

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Enumerableの再実装、意外と苦戦したけどなんとかできて楽しかった！<a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a></p>&mdash; 藤井裕起@マネーフォワード (@yuki_fujii_mf) <a href="https://twitter.com/yuki_fujii_mf/status/1205749217827770369?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

それぞれ楽しくモブプロに熱中していただけたようで良かったです！普段の勉強会にもぜひいらしてください 🙌

## スポンサー LT

今回、各スポンサー様には多大なご協力をいただきました。皆さま本当にありがとうございます。

### 株式会社ドリコム - 会場スポンサー

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">平成Ruby会議でスポンサーtalkさせていただきました<br>会場/協賛にお困りの方いらっしゃったらお声がけください<a href="https://t.co/l27RA3AJWF">https://t.co/l27RA3AJWF</a><a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a></p>&mdash; おーはら (@ohrdev) <a href="https://twitter.com/ohrdev/status/1205782077565652992?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### ストアーズ・ドット・ジェーピー株式会社 - クリエイティブスポンサー

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">企業LTでつかった資料です！地域コミュニティを一緒に盛り上げていけたら嬉しいです💃<a href="https://t.co/UwJmiuUbuK">https://t.co/UwJmiuUbuK</a><a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a> <a href="https://twitter.com/hashtag/heying?src=hash&amp;ref_src=twsrc%5Etfw">#heying</a></p>&mdash; Mana Kondo (@_mkondo) <a href="https://twitter.com/_mkondo/status/1205779072208367618?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### 株式会社タイミー - スタッフスポンサー

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ワーカーさんが（僕と一緒に）設営や受付業務を手伝わせていただくスポンサーをいたします。<br><br>平成.rbのコミュニティメンバーの方々が一人でも多くキーノートやコンテンツを見ることができればと思い協賛しております〜！！ <a href="https://t.co/CFY48M6yxk">https://t.co/CFY48M6yxk</a></p>&mdash; かめいけ (@kameike) <a href="https://twitter.com/kameike/status/1204971970879582209?ref_src=twsrc%5Etfw">December 12, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### 楽天株式会社 - コーヒースポンサー

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">色々大変だったけど、楽しかったです☕️<br><br>平成Ruby会議にてコーヒースポンサーを行いました！ | 楽天株式会社ラクマ事業部 by 焼山 里佳子 <a href="https://t.co/qjT65D82E2">https://t.co/qjT65D82E2</a> <a href="https://twitter.com/hashtag/wantedly?src=hash&amp;ref_src=twsrc%5Etfw">#wantedly</a></p>&mdash; はっせー (@Dear_you_cry) <a href="https://twitter.com/Dear_you_cry/status/1206396225014026240?ref_src=twsrc%5Etfw">December 16, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### スマートキャンプ株式会社 - ドリンクスポンサー

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">かきました。スポンサーとしての参加でしたが、一般参加者としてもめちゃくちゃ楽しかったです！！ありがとうございました！ <a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a><br>平成Ruby会議 01 にドリンクスポンサーとして参加しました - SMARTCAMP Engineer Blog <a href="https://t.co/mdc2N2ITHn">https://t.co/mdc2N2ITHn</a></p>&mdash; はぜ (@haze_it_ac) <a href="https://twitter.com/haze_it_ac/status/1206220391007391744?ref_src=twsrc%5Etfw">December 15, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### 株式会社オプト - フードスポンサー

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">本日はこちらでフードスポンサーをさせていただきます！<br>ステッカーも配布しているので是非！<a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a> <a href="https://t.co/eYTghVZY5T">https://t.co/eYTghVZY5T</a></p>&mdash; オプトテクノロジーズ (@OptTechnologies) <a href="https://twitter.com/OptTechnologies/status/1205697190770855936?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### メドピア株式会社 - ドリンクスポンサー

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">本日の平成RubyKaigiのLT資料です！ 頑張ってPRマージされるまで行きたい <a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a> <a href="https://twitter.com/hashtag/heiseirubykaigiA?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigiA</a><a href="https://t.co/FSUP0FmCnC">https://t.co/FSUP0FmCnC</a></p>&mdash; Teruhisa Fukumoto💎 (@terry_i_) <a href="https://twitter.com/terry_i_/status/1205784546957905920?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### 株式会社 SmartHR - フードスポンサー

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">SmartHR 会社紹介資料です！<a href="https://t.co/lC4E690kDM">https://t.co/lC4E690kDM</a><br> <a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a></p>&mdash; Masafumi Kabe (@kabetch_) <a href="https://twitter.com/kabetch_/status/1205786808946024448?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### 株式会社マチマチ - フードスポンサー

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">はてなブログに投稿しました！ <a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a> にフードスポンサーとして参加した感想です！<br><br>平成Ruby会議01にフードスポンサーとして参加しました - マチマチ技術ブログ <a href="https://t.co/cxpbwKUi3J">https://t.co/cxpbwKUi3J</a> <a href="https://twitter.com/hashtag/%E3%81%AF%E3%81%A6%E3%81%AA%E3%83%96%E3%83%AD%E3%82%B0?src=hash&amp;ref_src=twsrc%5Etfw">#はてなブログ</a></p>&mdash; ぱん🍞 (@nappan23) <a href="https://twitter.com/nappan23/status/1206848825656131584?ref_src=twsrc%5Etfw">December 17, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## 飛び込み LT

当日飛び込み LT を募集したところ、なんと 3人も応募がありました！ありがとうございます 🙏

どの発表も飛び込み LT とは思えないほどのクオリティで、かなり盛り上がりました。

### OSS で結果を出す方法

- ツイート: <https://togetter.com/li/1451739>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">今日の資料です！<br>「OSSで結果を出す方法」<a href="https://t.co/5WwDFaHxcK">https://t.co/5WwDFaHxcK</a> <a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a></p>&mdash; Akinori MUSHA (@knu) <a href="https://twitter.com/knu/status/1205792280503705600?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">めちゃくちゃいい話がガンガンされているが時間が足りないｗ <a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a></p>&mdash; 黒曜@デレ7thナゴド両日現地 (@kokuyouwind) <a href="https://twitter.com/kokuyouwind/status/1205791198440345601?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### Ruby と Lisp の切っても切れない関係

- ツイート: <https://togetter.com/li/1451746>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">pixivFANBOXでRubyとLispの切っても切れない関係 <a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a> を公開しました！ <a href="https://t.co/KuwY22p4AF">https://t.co/KuwY22p4AF</a></p>&mdash; ゴルフ場デベロッパー (@tadsan) <a href="https://twitter.com/tadsan/status/1205904957095858176?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">tadsanのLT、Emacs愛がすごかった。そして疾走感がすごかったw <a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a></p>&mdash; igaiga (@igaiga555) <a href="https://twitter.com/igaiga555/status/1205792916343422976?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### TECH::EXPERT で学んだこと

- ツイート: <https://togetter.com/li/1451754>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">飛び込みLTできることになった<a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a></p>&mdash; ゆーすけ@TECH::EXPERT 59期 就活中 (@YKhojo) <a href="https://twitter.com/YKhojo/status/1205777917675892736?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">スクールの達成度と受け入れる側の期待値が一致できると、みんな幸せになれそう。<br> <a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a></p>&mdash; まどぎわ (@madogiwa_boy) <a href="https://twitter.com/madogiwa_boy/status/1205793926335975424?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## [Keynote] Breaking Change

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/keynote2.jpg)

- 発表者: [@koic](https://github.com/koic)
- スライド: [Breaking Change - Speaker Deck](https://speakerdeck.com/koic/breaking-change)

お待ちかね最後のキーノート、@koic さんの発表です！

始まる前、会場の雰囲気がアツくなってきたのが分かりました。内容も、安定の @koic さんらしい発表でした。

全体を通して、OSS や破壊的変更について改めて再認識するような内容だと感じました。
「不便だと思ったら提案すれば良い」など、これが正しいふるまいだよね、と思えたり、そこに対する解決方法がエンジニアらしいな、と、とても学ぶことが多かったです。
あと RuboCop を使って破壊的変更に対して分かりやすく警告を出そう、という取り組みが、なかなか RuboCop ハックしていてすごかったです。

そして、最後の「あなたがコミュニティ」には、会場にいたみんなが 2020年に向けてやっていこう！と感じたのではないでしょうか。RubyKaigi 2020 も楽しみです！

## 懇親会

![]({{base}}{{site.baseurl}}/images/0061-HeiseiRubyKaigi01Report/afterParty.jpg)

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">お疲れ様でした！<br>学んだことも沢山あって、知り合いにも会えて、本当に楽しいイベントでした。<br><br>お寿司🍣、ハンバーガー🍔、お酒🍺<br>スポンサーの方々、運営やボランティアスタッフの方々、スピーカーさん楽しいイベントをありがとうございました！<br> <a href="https://twitter.com/hashtag/heiseirubykaigi?src=hash&amp;ref_src=twsrc%5Etfw">#heiseirubykaigi</a> <a href="https://t.co/utF99xu2oC">pic.twitter.com/utF99xu2oC</a></p>&mdash; シロ (@shiroemons) <a href="https://twitter.com/shiroemons/status/1205844314166718465?ref_src=twsrc%5Etfw">December 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

ハンバーガーや寿司がデプロイされ、みんなで楽しく懇親会をしている様子です。

実は、懇親会ではこっそりぼっちパトロールをしていたのですが、なんとぼっちはひとりもいませんでした。こういう懇親会を継続していきたいです。

みんなそれぞれ好きに集まって会社の話をしたり、メタプログラミング反省会をしたりと、いつもの楽しい懇親会でした。
帰り際には「蛍の光」を BGM で流して、無事、〆のラーメンを食べに解散しました。

## まとめ

平成 Ruby 会議 01 は、運営メンバー・スポンサーの皆さま、そして、参加者の皆さまのおかげで、勢いのあるすばらしいイベントとなりました！圧倒的感謝です。

全体を見ていただくと分かるとおり、とてもレベルの高い内容が盛りだくさんとなっています。

今回の平成 Ruby 会議の裏テーマは、「**つくる側とつかう側の両方を知る**」ことだと感じました。

つくる側がどんな気持ちで実装しているのか、つかう側はどんなことを考えながらプログラミングしているのか、両方の視点から色々なセッションをみることができたと思います。

今回の Keynote やセッション、LT をみて、

「OSS コミットへの機運が高まった！」

「普段なかなか潜れない、深いところまで知ることができた！」

という方が多かったのではないでしょうか？

この刺激を大事にして、2020年もみんなでやっていきしたいと思います！

### あわせて読みたい

運営スタッフもイベントについて詳しく紹介しています。ぜひご覧ください。

- [平成Ruby会議01をおえて｜tashiro｜note](https://note.com/tashiro_rb/n/nbe353bad81d7)
  - 実行委員長の [@tashiro_rb](https://twitter.com/tashiro_rb) が書いた総まとめ記事です
- [平成Ruby会議01を終えて｜cobafan｜note](https://note.com/cobafan/n/nd84b384a63bb)
  - オーガナイザー兼スピーカーの [@cobafan](https://twitter.com/cobafan) が書いた記事です。運営側からみた平成 Ruby 会議についてです

また、参加者の方々にもブログレポートを書いていただきました。すべては紹介しきれないのですが、いくつかピックアップしましたのでぜひこちらもご覧ください。

- [平成Ruby会議に参加してきました！ - 宮水の日記](https://miyamizu.hatenadiary.jp/entry/2019/heiseirubykaigi)
- [『平成Ruby会議』に行ってきたよメモ - コード日進月歩](https://shinkufencer.hateblo.jp/entry/2019/12/14/000000)
- [平成Ruby会議01に参加しました - @znz blog](https://blog.n-z.jp/blog/2019-12-14-heiseirubykaigi-01.html)
- [平成Ruby会議01 に参加してきました #heiseirubykaigi - Smoky God Express](https://hkdnet.hatenablog.com/entry/2019/12/15/130900)

## 著者について

rry（[@ryamakuchi](https://twitter.com/ryamakuchi)）: 2020年 1月〜 STORES.jp で Rails エンジニアをやります（ちょうど転職したてです）

平成 Ruby 会議の運営にジョインしたのは 10月頃からで、これまで運営陣のパワフルな活動に支えられてきました。みんないつもありがとう！今年もよろしくお願いします。
