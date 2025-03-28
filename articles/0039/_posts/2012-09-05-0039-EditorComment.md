---
layout: post
title: Rubyist Magazine 八周年
short_title: Rubyist Magazine 八周年
created_on: 2012-09-05
tags: 0039 EditorComment
---
{% include base.html %}


著者：郡司啓

## はじめに

おかげさまで、Rubyist Magazine は 8 周年を迎えました。そこで、今年 1 年間、およびこれまでのるびまについてまとめ、今後について考えてみたいと思います。

## 今年一年を振り返って

今年一年を振り返ってみると、号外の「RubyKaja のご紹介」を含めると 5 回、リリースしています。

* [0036]({{base}}{% post_url articles/0036/2011-11-28-0036-index %})
* [0037]({{base}}{% post_url articles/0037/2012-02-05-0037-index %})
* [0038]({{base}}{% post_url articles/0038/2012-05-22-0038-index %})
* [AnnounceRubyKaja]({{base}}{% post_url articles/RubyKaja/2012-06-16-kaja %})
* [0039]({{base}}{% post_url articles/0039/2012-09-05-0039-index %}) &lt;- 今ここ


昨年に引き続き今年もコンスタントにリリースすることができたように見えますが、昨年の RubyKaigi 直前特集号のボリュームを考えると、やや寂しい印象はぬぐえません。勢いと言うよりは淡々と継続されているようにも思えますが、無理のないペースで続けていくことは、それはそれで悪いことでもないのかもしれません。

それでは、8 年目の記事を見てみましょう。

高橋編集長による毎回圧巻の巻頭言ですが、今年も変わらず継続されています。内容も昨今話題のソーシャルコーディングについてや、 Ruby の価値基準の根幹である「たのしさ」について、そして組み込み用途向けとして注目されている mruby のソースコードの読み方の紹介、RubyKaigi の実行委員長の引継ぎ？など、多岐に渡っています。

* [0036 号 巻頭言]({{base}}{% post_url articles/0036/2011-11-28-0036-ForeWord %})
* [0037 号 巻頭言]({{base}}{% post_url articles/0037/2012-02-05-0037-ForeWord %})
* [0038 号 巻頭言]({{base}}{% post_url articles/0038/2012-05-22-0038-ForeWord %})
* [0039 号 巻頭言]({{base}}{% post_url articles/0039/2012-09-05-0039-ForeWord %})


Rubyist Magazine 常設記事となっている「Ruby の歩き方」ですが、内容がいい加減古くなってきているので、最近の事情に合わせて更新したいという話は何度か話題に上るものの、なかなか手を出せていないのが実情です。特にこれから Ruby を始めてみたいという方はこちらの記事を参照されると思いますので、どういった内容にすべきかも含めて良い案がありましたら編集部までご連絡いただけると幸いです。

* [FirstStepRuby]({{base}}{% post_url articles/first_step_ruby/2000-01-01-FirstStepRuby %})


インタビュー記事である Rubyist Hotlinks は、松田明さん、遠藤侑介さんと Ruby コミッタ編が続きました。お二方とも非常にいい意味でぶっ飛んだ方々で、面白いインタビュー記事となりましたので、少々長いのですがまだお読みでない方は是非どうぞ。次回以降もしばらくは Ruby コミッタ編が続きそうですが、そもそもインタビュー記事の作成に結構な負担がかかるという（編集者側の）問題は未解決のままなのが少々気になるところではあります。インタビュー記事自体はとても読み応えがあって、毎回楽しみにされている方も多いと思いますので、このあたりを今後もうまく回していけるようにする必要がありそうです。

* [Rubyist Hotlinks 【第 29 回】 松田明さん]({{base}}{% post_url articles/0037/2012-02-05-0037-Hotlinks %})
* [Rubyist Hotlinks 【第 30 回】 遠藤侑介さん]({{base}}{% post_url articles/0038/2012-05-22-0038-Hotlinks %})


シリーズ物としては、「他言語からの訪問」の第二回、上原さんによる Groovy の後編が掲載されました。他のプログラミング言語と Ruby を比較することで Ruby の良さや足りないものが見えてきますので、複数言語使いで一家言お持ちの方はぜひ「他言語からの訪問」シリーズに向けた記事を投稿してみてはいかがでしょうか。

* [他言語からの訪問 【第 2 回】 Groovy (後編)]({{base}}{% post_url articles/0037/2012-02-05-0037-GuestTalk %})


シリーズ物というわけではないのですが、私も他のプログラミング言語を引用したエッセイ記事を 2 つほど投稿させていただきました。雑誌記事的にはこうした軽めのエッセイがもっとあってもいいのかなあ、という個人的な思いから書いてみたものになります。Rubyist Magazine に投稿してみたいけど、難しい内容は書けないと思っているそこのあなた、Ruby を使っていて普段思ったこと、気がついたことなどをエッセイ記事として投稿してみませんか。

* [map と collect、reduce と inject ―― 名前の違いに見る発想の違い]({{base}}{% post_url articles/0038/2012-05-22-0038-MapAndCollect %})
* [式と文、評価と実行、そして副作用 ―― プログラムはいかにして動くのか【前編】]({{base}}{% post_url articles/0039/2012-09-05-0039-ExpressionAndStatement %})


またシリーズ物としては Regional RubyKaigi レポートが順調に続いています。おなじみの TokyuRuby 会議は 2 回も開催されていて実にハイペースなのと、とちぎ Ruby 会議、関西 Ruby 会議も 4 回目と回数を重ねてきていて、それぞれの特色が出てきているのではないでしょうか。みなと Ruby 会議は今回が初めてとなりましたが、主催コミュニティとなる Yokohama.rb の特色が出ていて良いですね。将来的にはパシフィコ横浜での開催を予定しているようですので、今後が楽しみです。

* [RegionalRubyKaigi レポート (25) TokyuRuby 会議 03]({{base}}{% post_url articles/0036/2011-11-28-0036-TokyuRubyKaigi03Report %})
* [RegionalRubyKaigi レポート (26) TokyuRuby 会議 04]({{base}}{% post_url articles/0037/2012-02-05-0037-TokyuRubyKaigi04Report %})
* [RegionalRubyKaigi レポート (27) とちぎ Ruby 会議 04]({{base}}{% post_url articles/0037/2012-02-05-0037-TochigiRubyKaigi04Report %})
* [RegionalRubyKaigi レポート (28) 関西 Ruby 会議 04]({{base}}{% post_url articles/0038/2012-05-22-0038-KansaiRubyKaigi04Report %})
* [RegionalRubyKaigi レポート (29) みなと Ruby 会議 01]({{base}}{% post_url articles/0039/2012-09-05-0039-MinatoRubyKaigi01Report %})


これまたシリーズ物というわけではないのですが、各種カンファレンス参加レポートやカンファレンス後日談など、Ruby に関するカンファレンスに関する記事が多いのも最近の傾向かと思います。特に海外との交流については今後も重要なテーマであると思われますので、海外のカンファレンスに参加したり、日本でも海外の Rubyist を呼んでイベントを開催したり、そうしたイベントに参加されたら是非レポート記事を投稿してみてください。

* [EuRuKo2011レポート]({{base}}{% post_url articles/0036/2011-11-28-0036-EuRuKo2011 %})
* [RubyConf2011レポート]({{base}}{% post_url articles/0036/2011-11-28-0036-RubyConf2011 %})
* [あなたが南米のRubyカンファレンスに参加するべきn個の理由【前編】]({{base}}{% post_url articles/0037/2012-02-05-0037-RubyOnSouthAmerica %})
* [Making of RubyKaigi2011 第二回]({{base}}{% post_url articles/0037/2012-02-05-0037-MakingOfRubyKaigi2011 %})
* [あなたが南米のRubyカンファレンスに参加するべきn個の理由【後編】]({{base}}{% post_url articles/0038/2012-05-22-0038-RubyOnSouthAmerica %})
* [達人プログラマ Dave Thomas が Asakusa.rb で話するというので聞いてきた]({{base}}{% post_url articles/0039/2012-09-05-0039-MetPragdaveAtAsakusarb %})


個別記事は次のとおりです。

* [Sinatra 再入門、 Padrino / Rack / その先の何か]({{base}}{% post_url articles/0036/2011-11-28-0036-SinatraReintroduction %})
* [Introducing ruby-dev Translation]({{base}}{% post_url articles/0036/2011-11-28-0036-ruby-dev-translation-en %})
* [Jeweler で作る Rails 用 RubyGems パッケージとそのテストについて]({{base}}{% post_url articles/0037/2012-02-05-0037-CreateRailsPlugin %})
* [Chef でサーバ管理を楽チンにしよう！ (第 2 回)]({{base}}{% post_url articles/0037/2012-02-05-0037-ChefInDECOLOG %})
* [AnnounceRubyKaja](AnnounceRubyKaja)
* [RubyMotion のご紹介]({{base}}{% post_url articles/0039/2012-09-05-0039-IntroductionToRubyMotion %})
* [Axlsx でテスト支援]({{base}}{% post_url articles/0039/2012-09-05-0039-TestingWithAxlsx %})
* [【八周年記念企画】 Rubyist Magazine へのたより]({{base}}{% post_url articles/0039/2012-09-05-0039-Comments %})
  * [Rubyist Magazine 八周年]({{base}}{% post_url articles/0039/2012-09-05-0039-EditorComment %})


Ruby のライブラリやフレームワーク、Ruby で書かれたツールの紹介記事のほか、0035 号に掲載された[ruby-dev translationのご紹介]({{base}}{% post_url articles/0035/2011-09-26-0035-ruby-dev-translation %})の英訳記事が目を引くところです。何度もテーマになる「日本と海外との隔たり」を埋める活動は、これからも継続して行っていきたいですね。

また今年はありがたいことに読者プレゼントが復活しました。

* [0036 号 読者プレゼント]({{base}}{% post_url articles/0036/2011-11-28-0036-Present %})
* [0038 号 読者プレゼント]({{base}}{% post_url articles/0038/2012-05-22-0038-Present %})
* [0039 号 読者プレゼント]({{base}}{% post_url articles/0039/2012-09-05-0039-Present %})


さらに献本いただいた方々から書籍紹介記事までお寄せいただきました。どうもありがとうございます。

* [書籍紹介『―Ruby on Rails 3 で作る― jpmobile によるモバイルサイト構築』]({{base}}{% post_url articles/0038/2012-05-22-0038-BookJpmobile %})
* [書籍紹介『たのしい開発 スタートアップRuby』]({{base}}{% post_url articles/0039/2012-09-05-0039-BookStartupRuby %})


8 年間で 39 号ということで、平均 4.875 回リリース/年（去年は 5.00 回リリース/年）。特別号や号外、エイプリルフールを入れると 45 回リリースなので、5.625 回リリース/年。記事数は特別号を入れて 531 記事で、66.375 記事/年ということになります。

## 今後

今年も昨年に引き続き記事を執筆してくれる方々のおかげで何とか年 4 回（号外を含めると年 5 回）ののリリースをすることができました。記事を書いていただいた皆様、どうもありがとうございました。

内部的な話をすると、相変わらず編集者が不足している状況で、色々と声はかけてみるものの根本的な解決には至っていません。特に負担が大きいのがインタビュー記事だと思いますが、なかなか良い方法が見つかっていないのが現状だと思います。とは言えインタビュー記事の価値は非常に高いと考えていますので、今後もうまく継続していきたいですね。

投稿していただける記事、それを編集する編集者、そしてお読みいただいている読者の皆様の 3 者によって Rubyist Magazine は成り立っていると思いますが、その垣根は意外なほど低く、（個人的な話をさせていただくと）現に一読者であった私がいつの間にか Rubyist Magazine の編集をしたり記事を投稿させていただいたりするようになりました。

そんな感じで Rubyist Magazine は一方的に読むだけではなく、読者が積極的に関わることの出来る雑誌だと思っています。そういう意味では若干オープンソースのプロジェクトに近いものがあり、オープンソースプロダクトに置き換えると、さしずめ編集者は Rubyist Magazine というプロダクトのコミッタであり、記事を書いていただける方はコントリビュータとも言えるのではないでしょうか。

そんな感じで現在お読みいただいている読者の皆様の中から新たに Rubyist Magazine に関わってみたいなあ、という方が出てくることを期待しつつ、今後の展望の結びにしたいと思います。

## おわりに

るびまは 8 周年を迎えました。ありがたいことです。8 周年という重みを受けつつ、継続は力なりということで、今後とも続けていけるといいですね。

というわけで、こんなるびまに、記事書いてみませんか？　もしくは、編集者になって、記事を編集してみませんか？

## 著者について

### 郡司啓

1975 年生まれ。Asakusa.rb 所属。本職は某メーカー勤務の営業マン。るびまはいつも楽しく読ませていただいていたのですが、いつのまにか記事を編集したり投稿させていただくようになりました。


