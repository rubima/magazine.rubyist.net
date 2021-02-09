---
layout: post
title: RegionalRubyKaigi レポート (37) 大江戸 Ruby 会議 03
short_title: RegionalRubyKaigi レポート (37) 大江戸 Ruby 会議 03
created_on: 2013-05-29
tags: 0042 OoedoRubyKaigi03Report regionalRubyKaigi
---
{% include base.html %}


## RegionalRubyKaigi レポート (37) 大江戸 Ruby 会議 03

### 開催概要
: ![8564408660_9452806671.jpg](http://farm9.staticflickr.com/8531/8564408660_9452806671.jpg)

開催日
: 2013-03-16(土) 10:00 - 17:50

開催場所
: [深川江戸資料館](http://www.kcf.or.jp/fukagawa/)小劇場

主催
: [Asakusa.rb](http://asakusa.rubyist.net/)

参加者
: およそ 200 名

資料
: [公式ページ](http://regional.rubykaigi.org/oedo03)

公式タグ
: [odrk03](http://b.hatena.ne.jp/search/tag?q=odrk03&users=1)

公式ハッシュタグ
: [#odrk03](http://twitter.com/search?q=%23odrk03)

大江戸 Ruby 会議 03 ツイートまとめ
: [http://togetter.com/li/472551](http://togetter.com/li/472551)

### はじめに

![8563625056_86fa940c36.jpg](http://farm9.staticflickr.com/8530/8563625056_86fa940c36.jpg)

2013 年 3 月 16 日に、地域 Ruby の会のひとつである Asakusa.rb の 200 回目の meetup を記念して「大江戸 Ruby 会議 03」が開催されましたので、本記事にてレポートをお送りします。

前回の「[大江戸 Ruby 会議 01]({{base}}{% post_url articles/0034/2011-06-12-0034-OoedoRubyKaigi01Report %})」から約 2 年が経っていますが、その間に欠番となる「[大江戸 Ruby 会議 02]({{base}}{% post_url articles/0039/2012-09-05-0039-MetPragdaveAtAsakusarb %})」を挟んでいますので、おおむね 1 年に一度と順調に開催を重ねている地域 Ruby 会議のひとつと言えるのではないでしょうか。

## 招待講演 1

### 『A Rubyist life in London』 ([発表資料](https://speakerdeck.com/makoto_inoue/a-rubyist-life-in-london))

#### [@makoto_inoue](https://twitter.com/makoto_inoue)
: ![8564713948_1709b09293.jpg](http://farm9.staticflickr.com/8250/8564713948_1709b09293.jpg)

今はロンドンに住んでいる [@makoto_inoue](https://twitter.com/makoto_inoue) さんのお話は、ロンドンでの暮らしと NewBamboo での働き方、海外から見た Rubyist の姿についてでした。Rubyist が他とは違うのは日本語リソースが多いことで、海外に向けて翻訳するチャンスがあり、しかも Rubyist はとても英語ができるのに長文を書くスタミナがなくてもったいないと海外から日本の Rubyist について思うところをおっしゃっていました。

## Ninja Talks 1

### 『気づいたらここに立っていた(仮)』 ([発表資料](https://speakerdeck.com/takkanm/ordk03-ninja-talk))

#### [@takkanm](https://twitter.com/takkanm)

![8564715426_e43e412bc6.jpg](http://farm9.staticflickr.com/8391/8564715426_e43e412bc6.jpg)

[@takkanm](https://twitter.com/takkanm) さんが Asakusa.rb に参加する以前の話と、Asakusa.rb に参加してからどのように自分が変わったか、というお話でした。Asakusa.rb に参加する以前は「自分のためにコードを書く」という意識であったところが、 Asakusa.rb に参加して「オープンソースを直すというのがあたりまえ」という人たちを目の当たりにすることで、「積極的にオープンソースに貢献していこう」という意識に変わったとのことでした。また「特別な力がなくてもオープンソースに貢献できる」ことを強調され、使ってるツールに不満があったら自分の出来る範囲でバグ修正やバグ報告をしましょう、とおっしゃっていました。

### 『asakusa.rbに一年間通ったらこうなった』 ([発表資料](https://speakerdeck.com/katsyoshi/asakusa-dot-rbni-nian-jian-tong-tutarakounatuta))

#### [@katsyoshi](https://twitter.com/katsyoshi)
: ![8563612835_9d8c7dde4c.jpg](http://farm9.staticflickr.com/8090/8563612835_9d8c7dde4c.jpg)

[@katsyoshi](https://twitter.com/katsyoshi) さんによる [mikutter](http://mikutter.hachune.net/) という Ruby で書かれた Twitter クライアントに関するお話でした。mikutter の動かし方から mikutter のプラグインの説明、mikutter で利用しているログ収集ツール [fluentd](http://fluentd.org/) の説明、また fluentd の安定版である [td-agent](https://github.com/treasure-data/td-agent) を ARM アーキテクチャで動作させた話など、「普段の Asakusa.rb で [@katsyoshi](https://twitter.com/katsyoshi) さんが黙々とやっていること」を存分に公開していただきました。

### 『某レシピ共有サイトの Ruby 1.9 対応で大変苦労しました』 ([発表資料](https://speakerdeck.com/mrkn/what-a-hard-work-to-make-the-recipe-sharing-service-available-on-ruby-1-dot-9-3))

#### [@mrkn](https://twitter.com/mrkn)

![8564716136_7d8a12c4b4.jpg](http://farm9.staticflickr.com/8087/8564716136_7d8a12c4b4.jpg)

[@mrkn](https://twitter.com/mrkn) さんによる、今まで Ruby 1.8 上で動作していた某レシピ共有サイトを Ruby 1.9 上で動作させるために色々と苦労されたお話でした。中でも「バグを前提として書かれていたコードが、Ruby のバージョンが上がることで問題になる」という話や、「良くない書き方をすると警告を出すようにして、開発者に自発的に直すようにしてもらう」といった工夫の話など、いかにして Ruby 1.8 から Ruby 1.9 への非互換性を「組織として」乗り越えて行ったかを実装面と運用面から具体的な体験談とともに解説されていたのが印象的でした。

## 基調講演 1

### 『Ruby の GC の問題点と改善手法についての一考察』 ([発表資料](http://www.atdot.net/~ko1/activities/oedorubykaigi03_ko1_pub.pdf))

#### [@koichisasada](https://twitter.com/koichisasada)
: ![8563616489_f081a72670.jpg](http://farm9.staticflickr.com/8368/8563616489_f081a72670.jpg)

設立初期からの Asakusa.rb メンバーで、Ruby コミッタの ささだこういち ([@koichisasada](https://twitter.com/koichisasada)) さんによる基調講演があり、Ruby のGCについて、これまで改善してきた事とこれからの展望について、分かりやすく発表してくれました。ささださんは、現在 Heroku でフルタイムコミッタとして活躍しており、最近は  ~~ワンダと巨像~~  GC の改善に注力しているとのことです。

まず、Ruby 2.0 になって、Ruby の GC はどう変わったのか、という話がありました。大きな変更は Copy On Write (以下 CoW) に対する親和性が上がった事です。Copy On Write とはプロセスのフォークによってメモリの状態を複製する際に、実際にメモリに割り当てられている値が変化していない場合は元のメモリ領域を参照し、変更があった時点でその部分だけを複製する処理の事です。これによりメモリの使用量を節約することができます。これは後述する Bitmap Marking という仕組みにより実現されています。

Ruby の GC は基本的には Mark&amp;Sweep 方式で実装されており、オブジェクトを mark して辿れなかったものを sweep して回収する仕組みになっています。1.9.3 がリリースされた時に、GC で長い時間処理が停止してしまうのを避けるために、lazy sweep という仕組みが導入されました。これは、GC の sweep タイミングを遅らせて段階的に処理する事で、GC 時間を短くする事が狙い、とのことです。一方で、メモリの開放が遅くなったり、キャッシュのローカリティが動作速度に影響を及ぼすかもしれない、というデメリットについても説明してくれました。

また、Ruby の GC は保守的 GC で、ポインタっぽく見える値はとりあえずオブジェクトのポインタとして扱う、という仕組みになっているという話がありました。保守的 GC は C 言語で Ruby を拡張する際に親和性が高いというメリットがあるため、こういう実装になっているようです。

そして、今回 Ruby 2.0 で実装された Bitmap Marking の概要についての説明がありました。Bitmap Marking では GC のための Mark bit を管理する Bitmap 領域を用意し、Mark をそこでまとめて扱うようになりました。従来のマーキング処理では、オブジェクトのメモリ領域自体に Mark bit をセットしていました。そうすると Rubyが内部で保持している RVALUE という構造体の値が変化してしまいます。これでは、GC のためのマーキング処理が行われる度にメモリの値が書き変わってしまい、CoW に向かない動作になってしまいます。そのため、Ruby 2.0 ではBitmap Marking を導入し、GC のマーキング処理が行われても、オブジェクトのメモリに変化が発生しないように改善されました。もちろんメリットだけではなく、Mark bit を探索するためには Bitmap 領域を経由する必要が出てくるため、GC の動作自体が若干遅くなる可能性もある、という話もありました。

最後に Ruby の GC には現状どういう問題があるのか、そして今後どうしていこうと考えているかについて、語ってくれました。今の Ruby の GC はまだまだ効率が良くないことや、メモリコンパクションが無いこと等が大きな問題だと考えているとのことです。元々は C 言語での実装や拡張に対して親和性を高くするためにやっていた事が、今効率性を高めていくためには負債になってしまっている、という要因のが要因です。ですが、今後の改善案として、世代別 GC を実現して効率を高めたいと考えているそうなので、次のメジャーバージョンアップでは、更に効率良い GC が実現されているかもしれません[^1]。

資料には、もう一つ 2.0 で実装されたマーキング処理の非再帰処理化についても書かれていましたが、発表時間の都合で、今回は話を聞くことができませんでした。興味がある方は、是非発表資料の方も参照してみてください。

## Ninja Talks 2

### 『RubyConfのNinjaの話の続きのおはなし』 ([発表資料](http://www.slideshare.net/yamanekko/oedo2013))

#### [@yuri_at_earth](https://twitter.com/yuri_at_earth)

![8563617537_ec25faef2b.jpg](http://farm9.staticflickr.com/8091/8563617537_ec25faef2b.jpg)

[@yuri_at_earth](https://twitter.com/yuri_at_earth) さんによる、mruby を使った組込み開発入門のお話でした。組込み開発は「プログラムを書いて何かする」状態にするまでの環境整備がとても大変なので、挫折してしまう人が多いとのことです。そこで STM32F4-Discovery という安価な組込み評価キットをターゲットにして、mruby で組込み開発をできるようにするまでの手順を整備して、組込み開発にたどりつくまでの敷居を下げる取り組みをされているとのことでした。

### 『Travis-ciでのemberjsのi18n』 ([発表資料](https://speakerdeck.com/randym/duo-yan-yu-emberjs-i18n))

#### [@morgan_randy](https://twitter.com/morgan_randy)
: ![8564721626_a727434028.jpg](http://farm9.staticflickr.com/8386/8564721626_a727434028.jpg)

[@morgan_randy](https://twitter.com/morgan_randy) さんによる、JavaScript の MVC フレームワークである [Ember.js](http://emberjs.com/) を多言語に対応させるお話でした。Ember.js は JavaScript を利用した静的なサイトを作成するのに利用され、[Travis CI](https://travis-ci.org/) の Web クライアントとしても利用されています。[@morgan_randy](https://twitter.com/morgan_randy) さんは rake-pipeline-i18n-filter と localeapp-handlebars_i18n を利用して多言語用 YAML を JSON に変換して Ember.js による多言語対応の静的なサイトを構築するデモを実施されていました。

### 『ぼくのかんがえたさいきょうのお問い合わせ管理システム』 ([発表資料](https://speakerdeck.com/hsbt/awesome-inquiry-management-system))

#### [@hsbt](https://twitter.com/hsbt)

![8563619399_be51d43d50.jpg](http://farm9.staticflickr.com/8225/8563619399_be51d43d50.jpg)

[@hsbt](https://twitter.com/hsbt) さんによる、[@hsbt](https://twitter.com/hsbt) さんの勤務先のカスタマーサービス部門が利用している「お問い合わせ管理システム」の問題点を改善したお話でした。既存の「お問い合わせ管理システム」では SQL の LIKE 演算子による「なんちゃって全文検索」であったために動作が遅かったところを、[Apache Solr](http://lucene.apache.org/solr/) による全文検索エンジンを組み込むことで高速化に成功したとのことでした。また今回実装された「お問い合わせ管理システム」[Whispered](https://github.com/hsbt/whispered) とその動作環境を構築してくれる構成管理スクリプト [whispered-puppet](https://github.com/hsbt/whispered-puppet) はオープンソースとして GitHub に公開されているそうですので、興味のある方は参照されてはいかがでしょうか。

## 基調講演 2

### 『Asakusa.rb vs. the World』 ([発表資料](https://speakerdeck.com/a_matsuda/asakusa-dot-rb-vs-the-world))

#### [@a_matsuda](https://twitter.com/a_matsuda)
: ![8564724310_fa86fbd143.jpg](http://farm9.staticflickr.com/8107/8564724310_fa86fbd143.jpg)

[@a_matsuda](https://twitter.com/a_matsuda) さんによる、Asakusa.rb という「地の利」を生かして世界に打って出よう、というお話でした。Asakusa.rb には Ruby コミッターが参加することも多く、ここでしか聞くことのできない情報もあります。これは世界でも特異な環境であるから、この「位置エネルギー」を利用しようとのことでした。また「日本人である」ということはコミュニティに対して多様性を提供することができる、というメリットもあるそうです。

またオープンソースのコミュニティには日本人がまだまだ少なく、海外のカンファレンスでも日本人スピーカーは引く手あまたとのことで、世界に胸を張れるプロダクトをお持ちの方は、ぜひ海外のカンファレンスでの発表にチャレンジして欲しいとのことでした。

## Ninja Talks 3

### 『Diversity is Good. RailsGirls Tokyoの取り組みと、そしてあなたがいつか得られるもの』 ([発表資料](https://speakerdeck.com/yotii23/diversity-is-good-railsgirls-tokyofalsequ-rizu-mito-sositeanatagaitukade-rarerumofalse))

#### [@yotii23](https://twitter.com/yotii23)

![8563622103_2eee0136a3.jpg](http://farm9.staticflickr.com/8110/8563622103_2eee0136a3.jpg)

[@yotii23](https://twitter.com/yotii23) さんによる、[Rails Girls Tokyo](http://railsgirls.com/tokyo) というイベントについてのお話でした。[Rails Girls](http://railsgirls.com/) は 2010 年から始まった「女性に Ruby on Rails の技術を伝える」というイベントで、ヨーロッパ、アジア、北米、南米など世界中で開催されているそうです。[@yotii23](https://twitter.com/yotii23) さんは第二回の Rails Girls Tokyo の主催者でもあり、女性だけでなく今まで技術が届かなかった「普通の人たち」の手に技術を伝えたい、そのために Rails Girls というイベントのフレームワークを活用してほしいとのことでした。 Rails Girls はイベントのマニュアルが GitHub に公開されていますので、同様のイベントを開催したいという方は参考にされてはいかがでしょうか。

### 『From 0 to 1: How to Get Involved in "Open Source"』 ([発表資料](https://speakerdeck.com/yuki24/from-0-to-1-how-to-get-involved-in-open-source))

#### [@yuki24](https://twitter.com/yuki24)
: ![8564725856_e996d4a059.jpg](http://farm9.staticflickr.com/8516/8564725856_e996d4a059.jpg)

[@yuki24](https://twitter.com/yuki24) さんによる、今までオープンソースに貢献したことのない人を対象とした「貢献のしかた」についてのお話でした。オープンソースへの貢献のしかた自体がひとつのスキルのようなものとのことで、良いバグレポートの書き方、良いバグ修正パッチの書き方を解説されていました。また心構えとしては、コードリーディングのスキルを高める、英語を学ぶなども必要とのことです。オープンソースのソフトウェアを利用していて不具合に遭遇したら、そのソフトウェアに何らかの貢献をすることで、そのソフトウェアを利用している他の人の問題解決にもつながるので、ぜひ「貢献する人」になってみてはいかがでしょうか。

### 『Rubyを始点としてもう一つのエンタープライズ開発を続けたあるSIerの事例』 ([発表資料](https://speakerdeck.com/takesinoda/rubywoshi-dian-tositemou-tufalseentapuraizukai-fa-wosok-ketaarusierfalseshi-li-oedo-rubykaigi-03-edition))

#### [@takeshinoda](https://twitter.com/takeshinoda)

![8564726866_047d47ff13.jpg](http://farm9.staticflickr.com/8381/8564726866_047d47ff13.jpg)

[@takeshinoda](https://twitter.com/takeshinoda) さんによる、Ruby を利用してタクシー会社向けの業務システム開発をされた事例のお話でした。よくある業務システム開発の「最初に仕様を決めてから開発をする」ではなく、顧客の要望を聞きながら徐々にソフトウェアを作り上げていく開発手法を取ったために、「動いているソフトウェアに手をつけない」という発想からの転換が大変だったそうです。そのために開発メンバーが Ruby のカンファレンスに参加するなどして Ruby コミュニティに触れていくことで Ruby の文化を学び、今までとは違う常識を身につけていったとのことでした。

## 招待講演 2

### 『桐島、Rubyやめるってよ』 ([発表資料](http://www.slideshare.net/authorNari/ruby-17269278))

#### [@nari3](https://twitter.com/nari3)
: ![8564726104_00031778bb.jpg](http://farm9.staticflickr.com/8231/8564726104_00031778bb.jpg)

[@nari3](https://twitter.com/nari3) さんによる、プログラミングへの向きあい方についてのお話でした。プログラミングは楽しいけれど、すごいプロダクトは誰もが作れるわけでもなく、またスター級のプログラマと比較してしまうと、どうしても見劣りしてしまいます。そんな劣等感に苛まれないようにするためには、すごいプロダクトを作ろうと意気込むのではなく、プログラミング自体を楽しむようにすると良いとのことでした。またプログラミング自体を楽しむものとして「プログラミングコンテスト」の紹介をされていましたので、興味のある方はチャレンジしてみてはいかがでしょうか。

## 懇親会

![1.JPG]({{base}}{{site.baseurl}}/images/0042-OoedoRubyKaigi03Report/1.JPG)
懇親会は深川めしで有名な大正 13 年創業の老舗「割烹 みや古」で行われました。「古き良き下町の宴会場」という雰囲気の店内であったため席の移動もしやすく、参加者は Ruby の話題で大いに盛り上がりました。こうした懇親会では発表者の方々と交流することができるのもまた嬉しいところですね。

## 写真の提供

[@koichiroo](https://twitter.com/koichiroo) さん 撮影 [http://www.flickr.com/photos/koichiroo/sets/72157633010817089/](http://www.flickr.com/photos/koichiroo/sets/72157633010817089/)

[@kakutani](https://twitter.com/kakutani) さん 撮影 [http://www.flickr.com/photos/kakutani/sets/72157633016122230/](http://www.flickr.com/photos/kakutani/sets/72157633016122230/)

[@hsbt](https://twitter.com/hsbt) さん 撮影 [http://www.flickr.com/photos/hsbt/sets/72157633013243016/](http://www.flickr.com/photos/hsbt/sets/72157633013243016/)

## 書いた人たち

### [@gunjisatoshi](https://twitter.com/gunjisatoshi) (Asakusa.rb)

前回の大江戸 Ruby 会議 01 に引き続き、レポート班として参加しました。Asakusa.rb は怖くないので、大江戸 Ruby 会議 03 に参加して興味を持たれた方は、普段の meetup にも是非顔を出してみてください。

### [@joker1007](https://twitter.com/joker1007) (Asakusa.rb)

昨年末に引っ越して浅草在住になり、Asakusa.rb に参加するようになりました。浅草は食事処が沢山あって気に入ってます。今回、大江戸 Ruby 会議にスタッフとして参加できた事を嬉しく思っています。

### [@hokkai7go](https://twitter.com/hokkai7go) (Asakusa.rb)

おうちからは会場まで徒歩 5 分で付きました。というのも前回の大江戸 Ruby 会議で清澄白河・門前仲町あたりの魅力について教えてもらったからなのでした。

----

[^1]: 笹田注: しました。ご参考 -> [[https://bugs.ruby-lang.org/issues/8339]]
