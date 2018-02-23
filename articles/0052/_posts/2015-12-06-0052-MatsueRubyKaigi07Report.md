---
layout: post
title: RegionalRubyKaigi レポート (55) 松江 Ruby 会議 07
short_title: RegionalRubyKaigi レポート (55) 松江 Ruby 会議 07
tags: 0052 MatsueRubyKaigi07Report
---
{% include base.html %}


* Table of content
{:toc}


書いた人 : 西田 雄也 さん、佐田 明弘 さん、井上 裕之 さん、本多 展幸 さん、木村 友哉 さん、橋本 将 さん

## RegionalRubyKaigi レポート 松江 Ruby 会議 07

### はじめに

2015 年 9 月 26 日 (土) に松江 Ruby 会議 07 が開催されました。今年のテーマは松江 Ruby 会議の発表を通して、一人でも多くの人に Ruby の楽しさを知ってもらいながら、Matsue.rb をよりにぎやかにするというものでした。今年は合計 66 名の方々に参加いただきました。また、YouTube の合計視聴数は 161 名 (2015 年 9 月 28 日現在) でした。

* 日時: 2015 年 9 月 26 日 (土) 11:00 〜 17:10 (懇親会: 18:00〜)
* 場所: 松江オープンソースラボ
* 主催: Matsue.rb (まつえるびー)
* 後援: 日本 Ruby の会
* 動画による中継 (YouTube): [https://www.youtube.com/playlist?list=PLbJxhePIoIPBSYjO2enmqSTpucHuHiA9S](https://www.youtube.com/playlist?list=PLbJxhePIoIPBSYjO2enmqSTpucHuHiA9S)
* Togetter まとめ: [http://togetter.com/li/895041](http://togetter.com/li/895041)
* 公式タグ・Twitter: [#matrk07](https://twitter.com/hashtag/matrk07)


### Redmine の歴史とアーキテクチャ (ゲスト講演)

* 発表者
  * Toshi MARUYAMA 氏 ([@marutosijp](https://twitter.com/marutosijp))

![02_guest.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/02_guest.jpg)

Redmine コミッタの Toshi MARUYAMA 氏に「Redmine の歴史とアーキテクチャ」と題してご講演いただきました。
氏は Mercurial overhaul とその他 SCM 周りのチケットにテスト付きのパッチを送っていたら 2010-12 に誘われてコミッタになったということでした。

Redmine の公開から現在に至るまでの歴史について、次のように伺いました。

* 2006-06-25 0.1.0 公開
* 2010-05-01 0.9.4 ここまで Jean-Philippe Lang (以下 JPL) がタグを打っていた。
* 2010-06-24 0.9.5 ここから Eric Davis がタグ打ち。
* 2010-10-31 1.0.3 ここまで Eric Davis がタグ打ち。
* 2010-11-27 Eric Davis が Redmine をやめると発表して、Redmine から ChiliProject が fork した。
* 2010-11-28 1.0.4 ここから JPL がタグ打ち。
* 2012-04-14 1.4.0 Bundler 対応 route の厳格化
* 2012-05-15 2.0.0 Rails 3.2.3 対応
* 2012-09-16 2.1.0 jQuery 化
* 2014-10-22 リビジョン 13482 Rails 4.1.6 対応
  * この時点で JPL から「Rails 4.2 がもうすぐリリースされる。Rails 5 がリリースされると 4.1 はセキュリティフィックスが入らなくなるため、Redmine 3.x は 4.2 を目指さないといけない。」とコメントがあった。
* 2015-02-19 3.0.0 Rails 4.2.0 対応


Redmine から fork したプロジェクトについては次のように言及されました。

* ChiliProject
  * Redmine から fork
  * 2013 年はコピーライトの年数の変更ぐらいしかコミットがなかった。
  * 2015-02-02 に終了した。色々な理由はあるだろうが、最大の理由は Rails 3 への移行に失敗したためと考えられる。
* OpenProject
  * ChiliProject から fork
  * ChiliProject が企業にコントロールされることと、お金ベースでコントロールされるのはどうかといった意見の違いから。
  * 時間の都合で詳しいご説明はありませんでしたが、こちらは開発が続いているようです。


Rails 3 への移行では、主に次の作業を行ったということでした。

* 1.3 以前は Redmine で利用しているライブラリの大部分を Redmine のリポジトリで管理していたが、Bundler 対応にあたっていくつか削除して Bundler に任せるようにした。
  * 対応初期時点まだかなりの数の外部由来ライブラリがリポジトリにあった。
* テストツールの object_daddy を fork した edavis10-object_daddy は削除した。
* Asset Pipeline をプラグインに適用するにはどうすれば良いか結論が出なくて未対応とした。


Rails 4.1 と 4.2 でも内部の構造が変わっていて、gem が対応や依存関係で苦労したということでした。
主に次の作業を行ったということでした。

* 最も大変だったのは Awesome Nested Set (以下 ans) の置換えで、元のソースコードと同梱していたソースコードに乖離していて、最終的に使うのをやめてシンプルな独自実装を行ったということでした。
  * ツリーが破壊されるバグを Redmine が独自に回避していた。
  * ans の 2.1.x のマイナーバージョン間で挙動が変化していた。Redmine 上では徹底したテストがあって判明した。
  * ans が stable ブランチでリファクタリングしていて Redmine 独自の回避が適用できない。
  * ans 3.0.x では 1 つのリビジョンで挙動が全く変わってしまって、しかもテストがない。
* Shoulda は削除した。
  * 似たような名前の gem が複数存在していた。
  * Rails 4.2 対応状況が不可解だった。
* 他に次のようなことがあったということでした。
  * MySQL 5.5 と 5.6 で行ロックとデッドロックの仕組みが変わっていた。MySQL から MariaDB がフォークしていてどちらにレポートすれば良いのかよくわからなかった。
  * Rails 本体の SQLite3 周りに不具合が見つかったので、修正して Rails に PR を取り込んでもらった。


Redmine 3.0.0 で Rails 4.2.0 対応したことに関連して、Rails 4.2.0 は MingGW (Windows) 環境と JRuby では動作しない点について次のように言及されました。

* MingGW
  * ASCII の文字セット以外の文字を含む URL に不具合があって、Rails に pull request を送って解決した。
* Rails が依存する Nokogiri が動かない。
* JRuby
  * activerecord-jdbc-adapter が対応していない。ただし、今朝見たら issue がクローズされていたのでもしかしたら改善できたかも。
  * Rails が依存する Nokogiri が動かない。


Redmine が Rails 5 に対応するための課題として、strong parameter への対応を挙げられました。Rails 4 対応時に progrected_attributes.gem を使って見送ったが、Rails 5 にはこの gem が対応しないために必要ということでした。

「ChiliProject が終了するぐらいには大変だった」と言われるほどの追従作業について、質疑応答では会場から「他のフレームワークを使う予定はないか」といったご質問がありましたが、「これからも Rails を使う」とお話がありました。

大きなプロジェクトが長期に渡ってメンテナンスし続けることの大変さが理解できるご講演でした。

### 昼休憩 (LT)

お昼ごはんを食べながら、山口友洋氏 ([@tgucchi](https://github.com/tgucchi)) の司会で以下の 5 件の LT の発表が行われました。

* WWDC に行ってきた話
  * 発表者
    * 木村友哉氏 ([@tomo-k](https://github.com/tomo-k))
* 島根大学ものづくり部 Pim の紹介
  * 発表者
    * 佐藤公治氏
* MidiosX を作りました
  * 発表者
    * 進藤元明氏 ([@motoakira](https://twitter.com/motoakira))
  * 資料
    * [http://www.slideshare.net/motoakira/midiosx](http://www.slideshare.net/motoakira/midiosx)
* 明日のために今日できること (仮
  * 発表者
    * きむらしのぶ氏 ([@mix_dvd](https://twitter.com/mix_dvd))
* 都会と田舎のライフスタイル GAP
  * 発表者
    * 小嵜英治氏 ([@eijik](https://github.com/eijik))


![03_lt01.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/03_lt01.jpg)
![03_lt02.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/03_lt02.jpg)
![03_lt03.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/03_lt03.jpg)
![03_lt04.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/03_lt04.jpg)
![03_lt05.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/03_lt05.jpg)

### Ruby にみるプログラミングの進化 (基調講演)

* 発表者
  * まつもとゆきひろ氏 ([@yukihiro_matz](https://twitter.com/yukihiro_matz))

![04_keynote.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/04_keynote.jpg)

我らが松江名誉市民！　ということで、今年もまつもとさんにご講演いただきました。いつもありがとうございます。

今回は「Ruby にみるプログラミングの進化」というタイトルでご講演いただきました。
前半はまつもとさんがプログラミングを学んでいった経緯と Ruby 開発当時の時代背景について、後半はまつもとさんの開発環境や開発手法についてお話いただきました。
特に後半の話は、普段の講演ではあまり聞くことができない貴重なお話だったと思います。
また、発表スライドでは、まつもとさんの 17 歳や 27 歳当時の貴重なお写真を拝見できました。

中学時代に BASIC からプログラミングを始めたそうですが、BASIC をやっていた頃はローカル変数などは考えもしない状況だったそうです。
その後、Pascal の本を読んだ時に、ローカル変数、ユーザー定義関数、再帰、ユーザー定義データ構造といった概念を知って感銘を受けたと同時に、すべてのプログラミング言語は誰かの手によって意図を持って設計されているものだと気づき、自分も設計してみたいと思ったとのことでした。

大学時代には、コンパイラ関連の著作で有名な中田育男先生の研究室に所属したそうですが、言語研究の分野において、日本の大学では、新しい言語を設計するよりは既存の言語のより良い処理系を実装するといった研究が主流であったとのことです。

その後、社会人となってから Ruby を開発することになるわけですが、Ruby を開発し始めた当時は以下の様な時代背景であったそうです。

* テキスト処理の仕事が多く、プログラムは小規模で、構造化の必要性はそれほど高くなかった。
* そのうち、規模の大きいものは手続き型からオブジェクト指向に移行していったが、スクリプティングにおいては一般的では無く、「Ruby is too good.」と言われたこともあった。
* Ruby を開発し始めた頃は自宅に PC が無く、PC を購入したのは何年か経ってから。PC を購入してからは、ソースコードを毎日 tarball に固めて、データを持ち運んでいた。
* 当時のソースコードは 1 万行くらいで、バージョン管理についてはそれほどニーズはなかった。
* ユニットテストが一般的に広まったのは XP が知られてからで、Ruby を作り始めた時は知らなかった。バグを直したときに、その場限りのテストコードを作ってはいた。


まつもとさんの開発環境や開発手法については、以下の話題が挙がっていました。

* エディタ: Emacs。vim や atom なども試してみた事はあるが、Emacs は環境なので全てを移行するのは難しい。
* コンパイラ: 昔から GCC。Clang などは本格的には使っていない。
* デバッガ: GDB を使っているが、それほど得意ではない (笑)。特にスレッドプログラミングでは、なんだかんだで print デバッグが多い。
* バージョン管理: SCCS -&gt; RCS -&gt; CSV -&gt; SVN -&gt; Git。バックアップとしてのコミットから、リリース・レビュー単位としてのコミットへ。


また、Git から派生して、GitHub についても次のように言及されていました。

* DVCS + Issues + SNS
* プルリクエスト。昔はパッチのやりとりや権限の管理が大変だった。
* カジュアルなフォーク。昔はフォークするのは後ろめたいことという風潮があった。
* ソーシャルコーディングの一般化した。
* 企業のソフトウェア開発における、OSS 方式へのスーパーハイウェイとなっている。


最後は、ユニットテストについての話題でした。
テスト嫌いを公言されているまつもとさんですが、その理由としては、プロダクトコードとテストコードの両方を書くのが DRY ではないと感じるからだそうです。
これについては、静的型付き言語における型宣言でも同じ感覚を持っておられるとのことでした。
テストに相当する部分はコンピュータが頑張って欲しいと思っておられるそうで、IDE のメソッド補完機能などがそれに近いイメージだとのことです。

それがさらに進むと、人間が話しかけただけでプログラミングができるような時代が来るかもしれないけど、そんな時代になっても、あるおじいさんは Linux のエミュレーションをお願いして Ruby を作り続けているんじゃないかな (笑) とのことでした。

実用面で人間自身がプログラミングをする必要がなくなると、プログラミングは伝統工芸のような扱いになっていくかもしれませんね。
ただ、そのような時代がきても、Ruby でプログラミングの楽しさを知った Rubyist たちは、娯楽としてのプログラミングを続けているような気がします。
Happy Hacking!

### matsuerb.products (2014..2015)

* 発表者
  * 橋本 将氏 ([@sho_hashimoto](https://twitter.com/sho_hashimoto))
* 資料
  * [https://prezi.com/0y1e6-b9-f2k/matsuerbproduct20142015/](https://prezi.com/0y1e6-b9-f2k/matsuerbproduct20142015/)

![05_matsuerb.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/05_matsuerb.jpg)

橋本氏による前回の松江 Ruby 会議から今回の松江 Ruby 会議までの Matsue.rb における活動内容のうち、GitHub で見られるようなものをまとめて紹介する内容でした (以下はその一部)。

* [structured_logger](https://github.com/nishidayuya/structured_logger): ログの出力の際に色々出力したい事が多いけど楽にそれを実現するための gem
* [midiosx](https://github.com/motoakira/midiosx): OSX の MIDI シーケンサ
* [brakefast](https://github.com/sho-h/brakefast): brakeman (Rails の脆弱性を見つけてくれるツール) を bullet 風に動かすようにした gem (未完成)
* [bundler_gemfile_license_audit](https://github.com/sho-h/bundler_gemfile_license_audit): Gemfile 中のライセンス違反がすぐわかるようにするためのもの (未完成)
* [Matsue.rb のロゴ](https://github.com/matsuerb/matsuerb-logo): CC0 で公開しているため、Ruby の部分だけ切り取って自由に使うこともできるようにするためのもの


前回の松江 Ruby 会議でのまつもとさんの講演を受けて、たとえ完璧ではなくても動くものがあれば公開してみようという事で橋本氏のプロダクトに未完成のものがありますが紹介をしたという事でした。

最後に橋本氏は未完成のものもある状態のため、俺たちの 2015 年 (の成果がわかる) のはこれからだ！　と締めくくって滑っていました。

### スプラウト.rb 〜 2 年目に突入 !!! 〜

* 発表者
  * 松岡 香里 氏 ([@kaorim8](https://twitter.com/kaorim8))
* コーチ
  * 佐田 明弘氏 ([@sada4](https://twitter.com/sada4))
  * 倉橋 徹 氏 ([@ToruKurahashi](https://github.com/ToruKurahashi))
  * 本多 展幸 氏 ([@nobyuki](https://twitter.com/nobyuki))

![06_sproutrb.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/06_sproutrb.jpg)

松岡氏の発表で Sprout.rb の活動についてご紹介いただきました。
前回の発表では参加者目線での紹介でしたが今回はコーチ目線でのお話をいただきました。
Sprout.rb は早くも 1 周年を迎えたそうで松岡氏は "コミュニティって続いていくのが当たり前ではなくて、本当に参加して頂いているみなさんと支援している人のおかげだと思っている" と挨拶をしておられました。
前年度から参加しておられる佐田氏に加え今年度から倉橋氏、本多氏も加わり少しずつ成長していっているようです。
松岡氏のコミュニティのご紹介の後コーチ陣からも一言ずつコメントをいただいています。

* 佐田氏


これまでは子供に対して教える機会があったものの Sprout.rb はどちらかというと年齢層が上だったので少し不安はあったそうです。
ただそこは大人！　間違えても受入れてもらいありがたかったそうです。

* 倉橋氏


懇親会前の 1 回のみの参加ということでみなさんからネタにされ笑いが絶えない発表でした。
冗談を言う反面 Rails を広めたいという熱い気持ちを語られておられ Rails 愛を感じました。

* 本多氏


松江で行われた RailsGirls の第 1 回からの継続学習ということで Sprout.rb では女性の比率が多いそうです。
仕事やプライベートで女性に教えることもあり女性率の多い Sprout.rb を紹介すれば間違いがないそうです。

最後に松岡さんから Sprout.rb の位置付けについておっしゃったことで、既存コミュニティの最初のハードルが高いと思う人の第一歩として活動できたらよいとのことでした。
今回の発表を見て、とても暖かい雰囲気のコミュニティであることが良く伝わってきました。

### プログラミングコンテスト 結果紹介

* 発表者
  * 吉岡隆行氏 ([@murateku](https://twitter.com/murateku))、内部 高志氏 ([@Takashi-U](https://github.com/Takashi-U))、倉橋 徹氏 ([@ToruKurahashi](https://github.com/ToruKurahashi))、本多 展幸氏 ([@nobyuki](https://twitter.com/nobyuki))、橋本 将氏 ([@sho_hashimoto](https://twitter.com/sho_hashimoto)) と受賞者の皆さん

![07_contest.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/07_contest.jpg)

松江 Ruby 会議 07 では paiza さんとの協賛で[オンラインでのプログラミングコンテスト](https://paiza.jp/poh/joshibato/matsue-ruby)が行われました。ゲームセンターあらし (アーケードゲーマーふぶき?) が元ネタに思えるキャラクターや島根県をイメージしたという巫女さんなど paiza さんの本気ぶりまで含めて委員長の吉岡氏から説明があった後で以下の流れで解説が進みました。

1. 問題の解説と模範解答の説明
1. 松江 Ruby 会議 07 の参加者のみを対象にした 1 位から 3 位の発表
1. 松江 Ruby 会議 07 の参加者のみを対象にした特別賞の発表
1. 全体での 9/26 時点での 1 位から 3 位の発表と解説 (※ paiza さんのコンテスト自体は 10/6 まで行われました)


元々スタッフも参加できるルールではあったためか、2. では受賞者が全員スタッフになってしまうというハプニングがありました。松江 Ruby 会議 07 での受賞者のコードは以下のようなものでした。

本多氏 (1 位: 116 バイト)

{% highlight text %}
{% raw %}
gets;w=$<.read.split.sort;c=l="";w.each{|d|d==(r=d.reverse)?c+=d : d<r&&w.bsearch{|x|r<=>x}&&l+=d};$><<l+c+l.reverse
{% endraw %}
{% endhighlight %}


吉岡氏 (2 位: 141 バイト)

{% highlight text %}
{% raw %}
l="";gets;b=$<.map{|a|a.chop}.sort;loop{w=b.shift||break;l.insert l.size/2,b.include?(r=w.reverse)?w+b.delete_at(b.index r):w==r ?w:""};$><<l
{% endraw %}
{% endhighlight %}


西田氏 (3 位: 142 バイト)

{% highlight text %}
{% raw %}
gets;a=gets("").split.sort;b=[];c="";while w=a.shift;d=w.reverse;(i=a.index d)?(a.delete_at i;c<<w):w==d&&b<<w;end;puts c+b.min.to_s+c.reverse
{% endraw %}
{% endhighlight %}


3 者とも入力を先に並べ替え (回答はアルファベット順で一番若いものが必要なため)、中心に来る文字列 (asa のような自身が回文になっている文字列) を選び、不要なものを捨てるという所までは同じのようです。それ以後のいかにコードを短くするかでバイト数に違いが出ているのが面白いですね。詳細な解説は長くなってしまうため省略しますが、よかったらどう違うかはじっくり見てみてください。

また、1 位となった本多氏にランキング全体の 1 位、3 位の方の回答を解説していただきました。当日は残念ながら時間の関係で全体の 2 位の方の解説は省略されてしまいましたが、[paiza開発日誌](http://paiza.hatenablog.com/entry/2015/10/27/%E3%80%90%E3%82%B3%E3%83%BC%E3%83%89%E3%82%B4%E3%83%AB%E3%83%95%E3%80%91%E5%88%9D%E5%BF%83%E8%80%85%E3%81%A7%E3%82%82%E3%82%8F%E3%81%8B%E3%82%8BRuby%E3%82%B7%E3%83%A7%E3%83%BC%E3%83%88%E3%82%B3%E3%83%BC)に同様の Matsue.rb 提供の解説を掲載されていますので、併せてご覧ください。

paiza オンラインハッカソンは次回開催予定もあるとの事ですので、もし興味のある方で参加に遅れたという方は是非参加してみてください。

### 学校で使用しているシステムについての話 〜わんわんクラブお仕事おたすけシステム〜

* 発表者
  * 藤井貴氏

![08_bijisen.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/08_bijisen.jpg)

松江総合ビジネスカレッジの学生である藤井貴氏に学校でおこなったシステムの更新作業についてご講演いただきました。
システムとは、学校でペットのトリミングの授業があり、その授業のモデルとして他の方が飼われているペットのわんちゃんをお預かりするため、その予約をするためのシステムとのことでした。
苦労した点を幾つかご紹介いただき、一例として更新作業のメンバは入れ替わりがあり、設計書やシステムで使用している独自のフレームワークを作成した初期メンバが既に卒業されてしまい、その引き継いだ設計書の不備の修正をあげていました。
会場はその独自のフレームワークが気になっていましたが、残念ながら学校内でのみ使用されているので公開されていないとのことでした。
そうした更新作業を通し、振り返ってみると以下のことを学習できたとのことでした。

* 設計書の大切さ
* 初期メンバーの大切さ
* プロジェクトリーダーの難しさ
* 犬についての知識


システムの更新作業は後輩の学生に引き継がれるため、システムの今後の改善点をあげ、後輩に期待しながら講演を終えられました。

### スモウルビー

* 発表者
  * 高尾宏治 氏 ([@takaokouji](https://twitter.com/takaokouji))
  * 本多展幸 氏 ([@nobyuki](https://twitter.com/nobyuki))

![09_progshou.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/09_progshou.jpg)

Ruby プログラミング少年団理事長、副理事長のお二人によるスモウルビーの新機能を紹介するためのライブコーディング (本多氏) 及びその解説 (高尾氏) でした。

ライブコーディングの前にまずは少年団が Ruby を対象としたスポーツ少年団によるコンピュータの楽しみと、リテラシーを学ぶための場だという事と、道場など少年団の活動の時期の紹介がありました (興味がある方は [http://smalruby.jp](http://smalruby.jp) の右上から「体験」、「道場」等を参照してください)。

ライブコーディングでは [0.4.0](https://github.com/smalruby/smalruby-editor/releases/tag/v0.4.0) の新機能である以下の 2 つの機能の内、1. を使ったミニゲームを作成しました。

1. キャラクターのコスチュームを次へ、次へと変える機能
1. キャラクターの画像をあたらしく追加する機能


あと 2 分で時間がなくなってしまうが大丈夫か？　という場面もありましたが、無事にツイン b... 某有名シューティングを連想するミニゲーム (自機がアイテムを攻撃する度に画像が切り替わるもの) を作りあげる事ができました。新機能の紹介に併せて、スモウルビーだけでそこそこ本格的なものが作れる事を紹介したかったとの事ですが、マップの編集への道筋を示す事ができればより本格的に作る事ができそうです。作成したプログラムは[こちら](https://github.com/nobyuki/matrk07)で公開されています。

また、身近に高校生以下のプログラミングに興味がありそうな方がいらっしゃいましたら、[本セッションの動画](https://www.youtube.com/watch?v=y-trBvQ0NLg)と[スモウルビー甲子園公式サイト](https://smalruby-koshien.jp)のリンクをご紹介してみてはいかがでしょうか。2016/01/10 まで応募を受け付けているとの事です。

### Ruby Quiz
![10_rubyquiz.jpg]({{site.baseurl}}/images/0052-MatsueRubyKaigi07Report/10_rubyquiz.jpg)

観客・スタッフ全員参加型の Ruby Quiz を開催しました。
Matsue.rb スタッフ考案の Ruby に関する択一問題が出題されました。
すべての問題が Ruby のコードに関する問題で、脳内コンパイラの性能と、いかに日頃から意識して Ruby を使っているかが問われました (以下はその内の 1 問)。

Q. 以下のコードを実行し、a と b を数値にして比較したとき、大きいのは a, b どちらでしょうか？

{% highlight text %}
{% raw %}
a = (1..9).reduce('') do |sum, value|
    sum.to_s + value.to_s
end

b = (1..9).reduce(0) do |sum, value|
    sum + value
end
{% endraw %}
{% endhighlight %}


制限時間 1 分という中で上記のような問題も出題され、日頃仕事や趣味で Ruby を使っているエンジニアでも苦戦していた様子でした。
最終的に勝ち残った方には、スポンサーの皆様より豪華景品が送られました。
2 択とはいえすぐに答えを出すことが難しい問題が多く、プログラミング言語としての奥深さを改めて実感する良いきっかけになったのではないでしょうか。

## 謝辞

### プログラミングコンテストでご協力いただきました、ギノ株式会社様

POH6 と共同開催という形でプログラミングコンテストのご協力をいただきました。
paiza (プログラマー向け転職サービス) で、気軽にコーディングスキルチェックを行うことができます。ご興味のある方はぜひお試しください。

[ギノ株式会社](http://www.gi-no.jp/) [paiza](https://paiza.jp/)

### スタッフ T シャツスポンサーをしていただきました、株式会社 spice life 様

前回に引き続き、スタッフ T シャツをご提供いただきました。一枚から発注が可能だそうです。イベントに、プライベートに、ぜひご利用ください。

[株式会社 spice life](http://spicelife.jp/index.html) [TMIX](http://tmix.jp/)

### ゲスト講演者の手配、書籍を提供していただきました、ファーエンドテクノロジー株式会社様

ゲスト講演をしていただいた、Toshi MARUYAMA 氏はファーエンドテクノロジーさんにご紹介していただきました。
また、プログラミングコンテストの副賞用に「入門 Redmine ―オープンソースの課題管理システム 第 4 版」を提供していただきました。

[ファーエンドテクノロジー株式会社](http://www.farend.co.jp/) [MyRedmine](http://hosting.redmine.jp/)

### その他、ご協力いただいた企業様

[株式会社ネットワーク応用通信研究所](http://www.netlab.jp/)
[株式会社テクノプロジェクト](http://www.tpj.co.jp/)
[株式会社イーストバック](http://www.eastback.co.jp/)
[株式会社八雲ソフトウェア](http://8clouds.co.jp/)
[株式会社システムリンク](http://www.sys-link.jp/)
[ガリレオスコープ株式会社](http://www.galileoscope.co.jp/)
[株式会社フォックス・リレーション](http://www.fox-r.com/)
[フェンリル株式会社](http://www.fenrir-inc.com/)
[株式会社モンスターラボ](http://monstar-lab.com/)
[株式会社 ティーエム 21](http://www.tm-21.co.jp/)

## 著者について

### 西田 雄也 ([@nishidayuya](https://twitter.com/nishidayuya))

プログラマ。
Redmine は職場ではもちろん、結婚式のタスク管理以降、家族でも使っている。
2014-12 に [redmine_text_format_converter](https://github.com/nishidayuya/redmine_text_format_converter) というプラグインを開発し、Redmine の書式を Textile から Markdown に変換して管理下の全てのプロジェクトを Markdown へ移行させました。

### 佐田 明弘 ([@sada4](https://twitter.com/sada4))

Matsue.rb にひっそりといるプログラマ。

### 井上 裕之 ([@ino_h](https://twitter.com/ino_h))

Ruby といろんなものをまぜるが好き。

### 本多 展幸 ([@nobyuki](https://twitter.com/nobyuki))

プログラミング教育おじさん。

### 木村 友哉 ([@tomo-k](https://github.com/tomo-k))

Apple 信者な Rubyist。

### 橋本 将 ([@sho_hashimoto](https://twitter.com/sho_hashimoto))

Matsue.rb の雑用係。[定例会](http://matsue.rubyist.net/about_us/#matsuerb)にはだいたい出席してます。[松江 Ruby 会議 05](http://magazine.rubyist.net/?0050-MatsueRubyKaigi05) からまさか 3 号連続での掲載になるとは思わなかった... (要は貯めてた訳ですが、やっと全部終わってほっとしています)。


