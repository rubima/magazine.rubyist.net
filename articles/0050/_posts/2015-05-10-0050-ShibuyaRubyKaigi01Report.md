---
layout: post
title: RegionalRubyKaigi レポート (48) 渋谷 Ruby 会議 01
short_title: RegionalRubyKaigi レポート (48) 渋谷 Ruby 会議 01
tags: 0050 ShibuyaRubyKaigi01Report
---


## 開催概要

* 開催日:
  * 2014-11-1 (土)
* 開催場所
  * [シダックスカルチャーホール](http://www.shidax.co.jp/ssv/hall/culture_hall.html)
* 主催
  * [Shibuya.rb](https://shibuyarb.doorkeeper.jp/)
* 公式ハッシュタグ
  * #428rk01
* Togetter
  * [http://togetter.com/li/739728](http://togetter.com/li/739728)
* 公式ページ
  * [http://regional.rubykaigi.org/shibuya01/](http://regional.rubykaigi.org/shibuya01/)


## はじめに

2014 年 11 月 1 日に Shibuya.rb の初の地域 Ruby 会議である「渋谷 Ruby 会議 01」を開催しました。 余談ですが今回の開催が Shibuya.rb の記念すべき (無理矢理カウントを合わせたら) 40 回目の開催でした。
: ![tyabe.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/tyabe.jpg)

## Unconference ～ shibuyarb lunch

本編開始前に会場を開けて、早く来た人が雑談をしたり壇上から話したりできる時間を作りました。昼食の時間は shibuyarb lunch として、参加者でランダムにグループを作ってもらいソーシャルランチのようなことを行いました。
全体的になごやかな空気を作ることができたかなと思います。

## Keynote
: ![bash0C7.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/bash0C7.jpg)

[資料](https://speakerdeck.com/bash0c7/i-am-ruby-ecosystem)

キーノートは Shibuya.rb の立ち上げ人の @bash0C7 さんによる「I AM "Ruby Ecosystem"!」でした。
こしばさんがコミュニティ内や業務も含めて行っている様々な活動とそれを行うモチベーションについての話です。

Ruby のエコシステムを見ると圧倒的に作る側の数が少ないですが、その提供側に立つと苦労も多いが大変楽しいとのこと。そのために @bash0C7 さんが行ってきたことを紹介していただけました。

最後に今日出来る提供側に立つ手段として「セッションで質問をしてみる」という話があり、この後のセッションで質問しやすい空気になったように思います。

## Community Talks

## コミュニティトーク

Shibuya.rb のご近所さんのような存在で、今回は地域 Ruby コミュニティの Ginza.rb と Sendagaya.rb、2 つのコミュニティからゲストが来てくれました。

### Sendagaya.rb
: ![fukajun.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/fukajun.jpg)

まずは隔週月曜日に開催しているという Sendagaya.rb。主催の 1 人である @fukajun さんのやや緊張したトークで始まりました。「Ruby や Rails に興味のある仲間が気軽に来れる部室のような場所」を目指しているそう。初めて来た人にも「参加できてよかった！」と思ってもらえるようにして疎外感のないように工夫しているとのこと。後の LT でもありますが実際に参加して楽しいと感じる人もおり、雰囲気の良さを感じます。

2012 年 5 月から始め 2014 年 10 月で 90 回開催を達成と、深みのある地域 Ruby コミュニティとなっています。千駄ヶ谷で始まり新宿開催を経て、現在では渋谷周辺で開催していることが多いのだとか。これまでの活動を振り返ると、基本はもくもく会と相談会をメインにしていて、中には HerokuDevCenter 読書会や REST に詳しい人を呼び RESTfulMeetup を開催したり、vim や git の勉強会になったりと、多彩な活動を行っていました。

#### 役に立つかもしれないステータスコードの話 @tkawa さん
: ![tkawa.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/tkawa.jpg)

続いては Sendagaya.rb に参加したメンバーによる LT です。
Sendagaya.rb 共同主催の @tkawa さんによる、Web アプリケーションを開発していると意識しない訳にはいかない HTTP ステータスコードのお話がありました。その数あるステータスコードから「これ本当にあるの？」と役に立つかもしれないステータスコードの解説です。お話の中でも強い印象があるのはジョーク RFC である「418 I'm a teapot」でした。知っておくとどこかで役に立つかもしれないですね。

#### コマンドライン E2E @iR3 さん
: ![iR3.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/iR3.jpg)

2 番手は @iR3 さんによるコマンドラインで E2E テストを行うには、という内容の LT です。Capybara をコマンドラインからテストを実行するにはどうしたらよいか、という話。systemu を使うことで STDOUT、STDERR を配列で介してくれるため、テスト自動化には有用です。

#### API 担当者が知りたい iOS のこと @satococoa さん
: ![satococoa.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/satococoa.jpg)

3 番手は @satococoa さん。Sendagaya.rb ではずっと iOS アプリを書いていたそうで、iOS アプリで必要となるライブラリの管理や各種ライブラリ、認証や通知などのお話です。CocoaPods という管理システムを使うことで Gem と同じように管理できるというのは iOS アプリの開発者でなければ得られない知見でした。その他、iOS アプリを作るときに必要なアプリ内課金・ Push 通知・ OAuth2 の解説と使用ライブラリの紹介がありました。

#### Web 業界未経験から就職した時の話 @nomnel さん
: ![nomnel.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/nomnel.jpg)

Sendagaya.rb の最後は、初めての LT という @nomnel さんの Web 系に就職して学びがあったという話です。「ハッカーと画家」を読み退職。その後 komagata さんのツイートがきっかけでフィヨルドのリモートインターンに応募。チーム開発を体験したことやモダンな開発プロセスなど、初心者でかつ 1 人では得られない体験ができたということでした。フィヨルドで得られたことはそのまま今の職場でも新人教育に応用出来ていることで、 @fukajun さんも絶賛でした。

### Ginza.rb @netwillnet さん
: ![netwillnet.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/netwillnet.jpg)

Ginza.rb からは主催の 1 人である前島さんがスピーカーとして参加されました。パーフェクト Ruby on Rails の著者の一人で、epub 版がこの渋谷 Ruby 会議の前日に発売されました。Ginza.rb には 3 人の主催がおり (@netwillnet さん、@y-yagi さん、@ken1flan さん) 2013 年 6 月から始めて 1 年半ほど。月に一度、第 3 火曜日に銀座周辺の会場を使って開催しています。これまではリクルートライフスタイル、みんなのウェディングなどを使わせてもらっているけれども、毎回使えるわけではないため会場提供してくれる会社を募集中だそうです。

このコミュニティはテーマは毎回決めて開催しているという特徴があり、ありそうでなかなかできない推しポイントですね。テーマは毎回ミートアップの最後に決めているとのこと (Github でも議論にしているようです)。

これまでの開催を振り返ると、初期はソースコードリーディング。いきなりソースを読むのは辛いため最初は README.md、サンプルコード、それから余った時間でソースを読むというような順番でやっていたそうです。また、JSON ライブラリの比較なども行っており深くレビューをしているのであとから見ても有用な知見になっていました。

中期は知識のシェア。参加メンバーが使っている Gemfile を持ち寄ってノウハウを共有する、また RUBY WARRIOR をみんなでやってみたところ Ruby の初心者でもとっつきやすかったことから、なかなかウケは良かったようです。他のコミュニティでもやってみるといいかもしれません。

最近はコードリーディングと知識のシェアをミックスさせたようなテーマでを開催しているそうです。例えばみんなでコードレビューするというテーマでは、デザインビギナーズのサイト機能を作るというお題を決め、Pull Request を作ってみんなでレビューしていくということを行っています。この手のハンズオンは実際に手を動かすので、参加者は楽しめるのではないかと思います。

コミュニティの紹介が終わったところで、残りの時間は実際に Ginza.rb でどんな風に進めているのかを前島さんが 1 人で再現 (?) するということに。Rails4.2 のリリースノートを読みながらどんな機能があって、どういうことに使えるのか、ということを解説してコミュニティトークの時間が終わりました。

## Member Talks

### Grape による API 実装 in action: @kyanny
: ![kyanny.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/kyanny.jpg)

[資料](https://speakerdeck.com/kyanny/grape-niyoru-api-shi-zhuang-in-action)

REST に似た API を作成することができる Grape の話でした。

Grape の概要について話された後、Quipper での構成やエンティティの共有方法、理想とする[Netflix の構成](http://techblog.netflix.com/2012/07/embracing-differences-inside-netflix.html)について紹介していました。

Grape を Rails で使うには、Grape 単体で使わず Rails とセットで使うとよいそうです。

その方法として、Rails を土台として、Grape アプリケーションを mount するのがいいとのことでした。

Grape だけでは、外部連携まわりなどで辛くなることがあるので、Rails のちからを借りるか、自力で頑張る覚悟が必要と結論づけ、発表を終えられました。

### すこやか Rails: @onk
: ![onk.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/onk.jpg)

[資料](http://www.slideshare.net/takafumionaka/rails-41084470)

世界はクソ力に満ちあふれていて、サービスを運用していると必ず健康状態が悪化していきます。

ウェブアプリケーションをすこやかに保つにはどうしたら良いのかという話でした。

すこやかとは、健康が維持できていて、改善コストが下げられている状態だと定義していました。

計測すること、改善の手助けをすることが大事だとして、クソクエリを定量評価する gem や、改善を促すために作ったアプリケーションを紹介していました。

複数サービスを運用しているからこその視点と戦略であり、非常に興味深いお話でした。

### 開発フローの作り方: @yaotti
: ![yaotti.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/yaotti.jpg)

[資料](https://speakerdeck.com/yaotti/kai-fa-hurofalsezuo-rifang)

みなさんご存知の Qiita を作るためにどのような事を大切にしているか、どのような開発フローを作っているかという 「『Qiita の作り方』の作り方」のお話でした。

繰り返してやっていることは早めに自動化していくと属人性を排除できるだけでなく、その仕事のプロセスを洗練しやすくなるとのこと。その過程では自然に OSS 化もされていくそうです。
またこのような自分たちが大事だと思う文化を発信することで、似た人が集まり、より文化が強化・進化されているとのことでした。

このような開発や文化についての仕組み作りをすることはコストもかかるとは思うのですが、想像以上に早くペイする実感を得ているとのことでした。

ソフトウェア開発をより良いものにするという目標の元で、Qiita を使っている人の開発だけではなく、自分達の開発も常により良くしようとしているんだなと感じる発表でした。

### インターネットカラオケマンを支える技術: @joker1007
: ![joker1007.jpg]({{site.baseurl}}/images/0050-ShibuyaRubyKaigi01Report/joker1007.jpg)

趣味として作り続けている自分用インターネットカラオケシステムのお話と実演デモでした。

現在のインターネットカラオケシステムは HTML5 や WebRTC や WebAudioAPI などを用いて作られているそうですが、
最初からこの形だったわけではなく、設計思想の変化や技術の進歩などがあって何度かアプリケーションを作り直しているとのこと。
自分の趣味をハックすることにより好きなものが力になるという言葉が印象的でした。

システムを使っての熱唱はアンコールもあり非常に盛り上がりました。

## LT

いつも通りの「話したい人が話す」ライトニングトークコーナーでした  
当日募集したにも関わらず多くの方に発表いただけました。ありがとうございました！

* @sue445 さん
  * [Paraduct をエクストリームリリースします](http://www.slideshare.net/sue445/paraduct-428rk01)
* @igaiga555 さん
  * spicelife を支えるパーカー
* @tk0mya さん
  * [ドキュメントの話、しませんか?](http://www.slideshare.net/TakeshiKomiya/428rk01)
* @sugamasao さん
  * [スペースの位置とか議論したくない](https://speakerdeck.com/sugamasao/supesufalsewei-zhi-tokayi-lun-sitakunai)
* @machida さん
  * P4D の話とゆるデ部の話
* @hokkai7go さん
  * [Zero to One が何を教えてくれたか](https://speakerdeck.com/hokkai7go/shibuyarubykaigi01-explanation-of-zero-to-one)
* @fukajun さん
  * ページ単位の JS の実行
* @miyohide さん
  * Yokohama.rb などのご紹介
* @chezou さん
  * 神奈川 Ruby 会議 01 のお誘い


## Shibuya.rb について

毎月第 3 水曜日にやっている Rubyist の集まり (≠勉強会) です。  
開催連絡などは[Facebook](https://www.facebook.com/groups/shibuya.rb/)経由で行われますので興味がある方はぜひご参加ください。

## 開催メンバ

* @tyabe
* @tkawa
* @ryonext
* @cnosuke
* @chiastolite
* @bash0C7(アドバイザー)


## るびま班

### @hokkai7go

北海道から出てきた Rubyist です。Chef や Ansible を書くことが多いです

### @5704x3

渋谷でインフラエンジニアやっています。渋谷 Ruby 会議 01 では記録役として写真の撮影とビデオを回したりしていました。
最近は本当にスイッチやルーターと戯れる毎日です。

### @chiastolite

Shibuya.rb 参加当初から高円寺→新宿→恵比寿と流浪してようやく渋谷の Rubyist になりました。


