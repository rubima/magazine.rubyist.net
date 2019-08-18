---
layout: post
title: RegionalRubyKaigi レポート (34) 福岡 Ruby 会議 01
short_title: RegionalRubyKaigi レポート (34) 福岡 Ruby 会議 01
tags: 0042 FukuokaRubyKaigi01Report regionalRubyKaigi
---
{% include base.html %}


## RegionalRubyKaigi レポート 福岡 Ruby 会議 01

### はじめに

福岡でほぼ隔週で開催されている [Fukuoka.rb](http://www.facebook.com/groups/fukuokarb/) のメンバーの [@Spring_MT](https://twitter.com/Spring_MT) が中心となって、福岡での Ruby 会議が開催されました。
福岡では 2008 年に「九州 Ruby 会議 01」が開催されていますが、それ以来 4 年ぶりの開催となりました。
![001s.jpg]({{base}}{{site.baseurl}}/images/0042-FukuokaRubyKaigi01Report/001s.jpg)

開催日
:  2012 年 12 月 1 日 14:00 〜 18:00

開催場所
:  GuildCafe Costa

主催
:   [@Spring_MT](https://twitter.com/Spring_MT)

![logo-300.jpg]({{base}}{{site.baseurl}}/images/0042-FukuokaRubyKaigi01Report/logo-300.jpg)
:  
<br />
: <br />

後援
:  [日本Rubyの会](http://ruby-no-kai.org/)、[GaiaX](http://www.gaiax.co.jp/jp/)、[10xlab](https://www.facebook.com/10xlab)

公式タグ・ Twitter
:   #fukuokark01 

[福岡Ruby会議のtweetまとめ](http://togetter.com/li/416276)
: 

### DCI: Let the code do the talking (招待講演)
![002s.jpg]({{base}}{{site.baseurl}}/images/0042-FukuokaRubyKaigi01Report/002s.jpg)

* 発表者
  * [@kakutani](https://twitter.com/kakutani)
* 資料
  * [https://speakerdeck.com/kakutani/dci-let-the-code-do-the-talking](https://speakerdeck.com/kakutani/dci-let-the-code-do-the-talking)


&##35;RubyFriends の紹介に始まり、福岡ではなかなか聞くことが出来ない Ruby 界隈の最新事情を話していただきました。

ソフトウェアはどこにあるのか、という哲学的な問題提起に対し、「ソフトウェアは頭の中にあり、ソフトウェア開発とは、エンドユーザーのメンタルモデルをソースコードとして表現すること」と定義し、2012 年後半に Rails 界隈を賑わせた DCI についてお話しいただきました。

「Rails のほう向いて仕事しちゃいけせんよ、ユーザのほう向いてください」という言葉はとても心に響きました。

### Enumerator::Lazy の使いかた
: ![003](http://f367.oreoka.com/photos/269/medium.jpg)

* 発表者
  * [@nagachika](https://twitter.com/nagachika)
* 資料
  * [https://speakerdeck.com/nagachika/dai-duo-narubyisthefalsedao-enumerator-lazy-falseshi-ikata-at-fu-gang-rubyhui-yi-01](https://speakerdeck.com/nagachika/dai-duo-narubyisthefalsedao-enumerator-lazy-falseshi-ikata-at-fu-gang-rubyhui-yi-01)


Ruby 2.0 の新機能紹介を [PB memo](http://d.hatena.ne.jp/nagachika/) の著者の [@nagachika](https://twitter.com/nagachika) さんに行っていただきました。
Yokohama.rb で一度発表された内容に一部追加した内容の発表となりました。
会議当日はまだ Ruby 2.0 はリリース前で、Module#prepend や消えるかもしれなかった Refinements についても説明していただきました。
メインの Enumerator::Lazy に関してはライブコーディング形式で解説していただきました。

### 初心者エンジニアのシステム構築失敗談
: ![004](http://f367.oreoka.com/photos/275/medium.jpg)

* 発表者
  * [@Spring_MT](https://twitter.com/Spring_MT)
* 資料
  * [http://www.slideshare.net/blueskyblue/ss-15438284](http://www.slideshare.net/blueskyblue/ss-15438284)


__この部分は [@Spring_MT](https://twitter.com/Spring_MT) が書いています。__

今やっているプロジェクトのアプリ構成の遷移のお話をしました。
これがベストではないとおもっていますが、チームの中で考えた今のベターな構成だと思ってます。
今回はユーザーの入力値の validation を行う場所として controller を選びましたが、ユーザーの入力値の validation が controller の責務かというとちょっと違うかなあとも思います。
じゃあどこがベストなのと突っ込まれると答えられないですが。。。。
懇親会で、controller で validation するというよりは、ユーザーの入力値の validation を ActiveRecord とは別に行い、validation を行う場所として controller を選んだというほうが良さそうとインプット頂き、確かにそうだなあと思いました。

### Sencha Touch の本を書いたよ
: ![005](http://f367.oreoka.com/photos/278/medium.jpg)

* 発表者
  * [@kis](https://twitter.com/kis)
* 資料
  * 発表資料はないですが、参考資料はこちら[Sencha Touch でのクロスドメインな JSONP 通信](http://d.hatena.ne.jp/nowokay/20121203#1354560806)


[@kis](https://twitter.com/kis) さんは会議直前に本を出版された [Sencha Touch](http://www.sencha.com/products/touch) について。
スライドは事前に用意せず、その場でスライドを作っていく斬新なスタイルでした！
[Sencha Touch](http://www.sencha.com/products/touch) でクロスドメイン通信をする話をしていただきました。

### Ruby 2.0 の Bitmap Marking GC って美味しいの？
: ![006](http://f367.oreoka.com/photos/281/medium.jpg)

* 発表者
  * [@wats](https://twitter.com/wats)
* 資料
  * [http://www.slideshare.net/atsushiwada/bitmap-marking-gc](http://www.slideshare.net/atsushiwada/bitmap-marking-gc)


[@wats](https://twitter.com/wats) さんも [@nagachika](https://twitter.com/nagachika) さん同様に、Ruby 2.0 で導入された Bitmap Marking GC についてお話いただきました。
シンプルな Mark &amp; Sweep 方式から Bitmap Marking GC へと変更されることで [Unicorn](http://unicorn.bogomips.org/) のメモリ消費量減少が見込まれることなどをお話しいただきました。

### LT

その後以下の 8 名の方にライトニングトークをしていただきました。

1. [Hiroto Imoto](https://twitter.com/adarapata) - 新卒研修で初めて Rails 開発をしたときに感じた事
  * 資料 : [https://docs.google.com/presentation/pub?id=1JNSSZk4LlV8pHPQLtYVGNcFE-4LSqCzjZ4SDADSTsvU#slide=id.p](https://docs.google.com/presentation/pub?id=1JNSSZk4LlV8pHPQLtYVGNcFE-4LSqCzjZ4SDADSTsvU#slide=id.p)
1. [Koichi Saito](https://twitter.com/koichi222) - Rails 高速化〜 isucon を題材にして〜
  * 資料 : [https://docs.google.com/presentation/pub?id=1UC83Ja9T5Q_Y103GiiQamD6UILfqu290wj8T0CovJUQ#slide=id.p](https://docs.google.com/presentation/pub?id=1UC83Ja9T5Q_Y103GiiQamD6UILfqu290wj8T0CovJUQ#slide=id.p)
1. [Manabu Matsuzaki](https://twitter.com/matsumana) - 仕事で Ruby を使う為にやった事あれこれ
  * 資料 : [http://www.slideshare.net/matsumana0101/ruby01-20121201-lt](http://www.slideshare.net/matsumana0101/ruby01-20121201-lt)
1. [@ayato_p](https://twitter.com/ayato_p) - Java プログラマが Ruby に惚れたら
  * 資料 : [https://speakerdeck.com/ayato0211/javapuroguramagarubynibu-retara](https://speakerdeck.com/ayato0211/javapuroguramagarubynibu-retara)
1. [Shigeichiro Yamasaki](http://www.joho.fuk.kindai.ac.jp/faculty/yamasaki.html) - Ruby で フィジカル・コンピューティング
  * 資料 : [http://www.slideshare.net/11ro_yamasaki/fukuoka-rubykaigi01-yamasaki-lt](http://www.slideshare.net/11ro_yamasaki/fukuoka-rubykaigi01-yamasaki-lt)
1. [@kiwanami](https://twitter.com/kiwanami) - 非 Web 系会社での Ruby 適用事例いろいろ
  * 資料 : [http://www.slideshare.net/MasashiSakurai/webruby](http://www.slideshare.net/MasashiSakurai/webruby)
1. [@yotii23](https://twitter.com/yotii23) - RailsGirls と手榴弾とわたし
  * 資料 : [https://speakerdeck.com/yotii23/railsgirlstoshou-liu-dan-towatasi](https://speakerdeck.com/yotii23/railsgirlstoshou-liu-dan-towatasi)
1. [@kazuph](https://twitter.com/kazuph) - みんなで ProjectEuler in Ruby
  * 資料 : [http://kazuph.github.com/presentation/fukuoka_ruby_kaigi/#/](http://kazuph.github.com/presentation/fukuoka_ruby_kaigi/#/)


様々な分野からの発表があり、盛りだくさんの内容となりました。<br />
普段 Web 系の人から Rails の話を聞くことが多かったので、フィジカル コンピューティングや JRuby の話は新鮮に感じられました。<br />
特に山崎先生 (Shigeichiro Yamasaki) が発表された Ruby を使ったフィジカル コンピューティングの事例はエキサイティングな内容でした。mruby ではなく、MRI を使っているのは驚きでした。GC のタイミングをずらすなど、かなりパフォーマンスチューニングもされており、Ruby の違った側面が見られてとても参考になりました。

### さいごに

福岡の人の発表が多く、また様々な分野の方に発表して頂けたこともあり、色々な Ruby の使い方が紹介されました。[Fukuoka.rb](http://www.facebook.com/groups/fukuokarb/) では Rails の話題が多く出ていたこともあり、Rails の発表がかなり多くなるのではと思っていたのですが、いい意味で予想が裏切られた形になり、福岡ならではの RegionalRubyKaigi になったのではないかと思います。

本当にさいごですが、福岡 Ruby 会議 01 の参加者の皆様に百万の感謝を <br />
Thanks a million for all Fukuoka Regional RubyKaigi participants !

## Fukuoka.rbとは

修羅の国でだいたい毎週木曜日に Ruby を触ってるのんべえの集まり。どんな言語をやっていても歓迎です！
[https://www.facebook.com/groups/fukuokarb/](https://www.facebook.com/groups/fukuokarb/)

### 書いた人たち

__[@morygonzalez](https://twitter.com/morygonzalez) ＆ [@Spring_MT](https://twitter.com/Spring_MT)__


