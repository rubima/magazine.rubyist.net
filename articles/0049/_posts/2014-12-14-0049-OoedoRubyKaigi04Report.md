---
layout: post
title: RegionalRubyKaigi レポート (45) 大江戸 Ruby 会議 04
short_title: RegionalRubyKaigi レポート (45) 大江戸 Ruby 会議 04
tags: 0049 OoedoRubyKaigi04Report
---
{% include base.html %}


書いた人 : ヨシオリ ([@yoshiori](https://twitter.com/yoshiori/))

## [WIP]RegionalRubyKaigi レポート (45) 大江戸 Ruby 会議 04
: ![13924209506_a54612d9b8.jpg](http://farm8.staticflickr.com/7395/13924209506_a54612d9b8.jpg)

開催日
: 2014-04-19(土) 9:30 - 19:00

開催場所
: [江戸東京博物館](http://www.edo-tokyo-museum.or.jp/access/guide/index.html)

主催
: [Asakusa.rb](http://asakusa.rubyist.net/)

参加者
: およそ 230 名

公式ハッシュタグ
: [#oedo04](http://twitter.com/search?q=%23oedo04)

大江戸 Ruby 会議 04 ツイートまとめ
: [http://togetter.com/li/657366](http://togetter.com/li/657366)

動画
: [YouTube](https://www.youtube.com/playlist?list=PLkcX6PjCRhhoh8e9mctY5FgUAfyzwlsTY)

## はじめに

![13919624222_eb7b8c022c.jpg](http://farm4.staticflickr.com/3674/13919624222_eb7b8c022c.jpg)
2014 年 4 月 19 日に Asakusa.rb の 256 回の meetup を記念して「大江戸 Ruby 会議 04」が開催されましたのでその様子について、レポートします。

前回の[大江戸 Ruby 会議 03](http://magazine.rubyist.net/?0042-OoedoRubyKaigi03Report) から約一年ということで、毎年順調に開催を重ねている地域 Ruby 会議になっています。

また、毎回登壇者が地域 Ruby 会議の中でも豪華で有名な本会議ですが、今回も海外からのゲスト多数、そして総勢 8 人もの Ruby コミッターという豪華なスピーカーを迎えての開催になりました。

そのため、時間も 10 時開催から終了時間は少し伸びて 19 時半終了、発表も 16 件と盛りだくさんな内容でした。

## From ‘Legacy’ to ‘Edge’ 2014 edition, @hsbt
: ![13942732175_7f4147df4f.jpg](http://farm8.staticflickr.com/7361/13942732175_7f4147df4f.jpg)

[資料](https://speakerdeck.com/hsbt/from-legacy-to-edge-2014-edition)

まずトップバッターは[GMO ペパボ株式会社](http://pepabo.com/)の技術基盤チームの @hsbt さんのレガシー退治の発表です。

2007 年から続いている「[30daysAlbum](http://30d.jp/)」での Ruby と Rails のバージョンアップのお話です。
そもそもなんでアップデートするのかという話で Ruby のバージョンをあげるだけで 25% の速度改善などの Twitter の発言を引用しつつ、「でも Rails はバージョンアップするたびに速度遅くなって……」と笑いを取りながらそれでもアップデートの大切さを説明し、具体的にどのように進めていったかの説明でした。

アップデート時には「Ruby の壁と Rails の壁」というものが存在し、例えば Ruby1.8.6 では Rails2.0/2.1 までしか動かないなどのお互いのサポート状況を把握しながら進めていくということでした。

やっていることは普通に修正しマージしながらアップデートしていき、ダウンタイム無しでデプロイしていくのですが、そこで [kage](https://github.com/cookpad/kage) を使いつつ問題なければ本番に適用しながらすすめていくという形でした。

まずは Ruby1.8.7 にあげ、そのまま Rails2.3 まで持っていく、その後、Rails3.2 に行くために  Rails2.3 を Rails3 ぽくしつつ修正していくという形で 3.2 まで持って行ったそうです。そこからまた Ruby のバージョンアップをし、Rails4 に移行……という長い道のりのお話でした。

やはり溜めずにバージョンアップするとバージョンアップコストも減るのでちゃんと溜めずにバージョンアップしていくのが大事という事と、アプリケーションも gem も Rails も Ruby もドンドン直しながら進んでいこうというまとめでした。

## Infrataster - Infra Testing Framework, @ryot_a_rai

![13943184864_bfb16eecb8.jpg](http://farm4.staticflickr.com/3772/13943184864_bfb16eecb8.jpg)
[資料](https://speakerdeck.com/ryotarai/infrataster-infra-behavior-testing-framework-number-oedo04)

つづいて @ryot_a_rai さんの発表です。まずは生活発表として自分の作ったものの発表として [GitHub Trends RSS](http://github-trends.ryotarai.info/) と [git-commit-autouser](http://ryotarai.github.io/git-commit-autouser/) の紹介を軽くし、本題の [infrataster](http://infrataster.net/) の発表でした。

最近のサーバ構築は chef や puppet で自動化でき、さらに Serverspec で振る舞いを記述したりも出来ます。
ただ、実際には chef-cookbook 出来た！！　→動かない！！ (iptables の設定漏れで外からは見えなかった) などが稀に良くあります。

そういったものを無くそうと思い infrataster はインフラの味見をしてくれるような感覚で作成したそうです。 

RSpec で記述でき、MySQL にクエリを投げたりも出来るため簡単で色々なテストが出来るようです。

## Winston Teo "Random Ruby Tips, @winstonyw
: ![13919636806_e1fd484eb7.jpg](https://farm4.staticflickr.com/3807/13919636806_e1fd484eb7.jpg)

[資料](https://speakerdeck.com/winston/random-ruby-and-rails-tips)

次はシンガポールから来日した [RedDotRubyConf](http://www.reddotrubyconf.com/) のオーガナイザー @winstonyw こと Winston Teo さんの発表です。

最初に日本語で挨拶をされていました。日本大好きだそうです。

まずは自己紹介を兼ねて [RedDotRubyConf](http://www.reddotrubyconf.com/) にみんなも来てほしいというということと、[Singapore Ruby Group](http://www.meetup.com/Singapore-Ruby-Group/) の紹介をされていました。

Singapore Ruby Group は小さいけど活動は活発に行っているようで、今回はそこで発表された Ruby と Rails の tips の中から 30 個の tips を発表されていました。どれも知っていれば RubyLife が更に良くなるような tips ばかりですので是非資料をみていただければと思います。

## Nobody Knows Nobu, @_zzak

![13919642432_479f1d3ca5.jpg](http://farm3.staticflickr.com/2938/13919642432_479f1d3ca5.jpg)
[資料](https://speakerdeck.com/zzak/oedo04-nobody-knows-nobu)

続いてアメリカから来日中の Ruby コミッター @_zzak の発表です。

一年ほど日本語を勉強しているとの事で日本語で挨拶されていました。

発表は同じく[Ruby コミッターとして著名な中田伸悦さん](http://magazine.rubyist.net/?0009-Hotlinks)の生い立ち (？) を紙芝居形式で紹介しつつその Ruby に対する貢献を褒め称え、本当に尊敬するしみんな中田さんのように一生懸命がんばりましょうという内容をたくさんの笑いを交えて紹介していました。

その後「質問などは中田さんにしてね。中田さんステージに来て！」と、実際に中田さんを壇上に呼びみんなからの質問を受け付けていました。

中田さんはお酒とバグ修正の話をしつつ、先ほど @winstonyw さんの発表で出てきた OpenURI の tips をもっと気軽に扱えるパッチを書いていたという手の早さで会場を沸かせていました。

## 私は如何にして異国でエンジニアとして生き抜いてきたか, @lchin
: ![13919635761_ffb4f6acb8.jpg](http://farm3.staticflickr.com/2905/13919635761_ffb4f6acb8.jpg)

[資料](https://speakerdeck.com/lchin/how-to-survive-and-thrive-as-an-engineer-in-a-foreign-land)

ランチ後の発表は @lchin の発表です。

海外で働きたいっていうのにやらない人多いのはなんで？　ということでオーストラリアから日本に来て 11 年の生き方を話していました。

まずは普通に日本語の勉強の仕方と仕事の探し方を説明した後、もっと大事なのは「文化」を学ぶことだと自身も日本のエンジニアの文化を学ぶために「ジョジョの奇妙な冒険」を全巻揃えた話などを交えつつ説明していました。

また、海外のネット文化をリアルに体験できる場所として reddit を紹介していました。

## 画像を壊すこと、OSS 活動をすること、その他, @makimoto

![13943203614_b52f8c267e.jpg](http://farm8.staticflickr.com/7353/13943203614_b52f8c267e.jpg)
[資料](https://speakerdeck.com/makimoto/glitch-oss-activities-and-so-on-oedo-rubykaigi-04-number-oedo04)

次は @makimoto の発表です。

グリッチ好きが好きで、理由としては実用的なものとか哲学的な意味のあることじゃないのもやりたいということから最初は画像のことを理解しないで壊してたけど、最近は逆にちゃんと学びたくなったようです。

また、OSS 活動も「使う → 直す → 公開する」とやっているうちに色々あって盛んになっていったようです。

最後に OSS 活動というと気構えてしまいがちだが、最初は自分が好きなモノ作って公開したり、壊れたり中途半端なもの直す「グッタリ駆動開発」で何度かやると抵抗なくなるという話で締めました。

## RubyVM 読んでみた, Kawamoto

[資料](http://sssslide.com/speakerdeck.com/ocha/rubyvmdu-ndemita)

[有志による Ruby Hacking Guide の英訳プロジェクト](https://github.com/ruby-hacking-guide/ruby-hacking-guide.github.com) に最も多くコミットされている Kawamoto さんの発表です。

Ruby 処理系のソースコードをどうやって読み進んでいったか最初はバイトコードの状態が気になり、そこから RHG に従いデータ構造を調べつつ読んでいったようです。

また、mruby のコードと同時に見て比較しつつ読むと理解しやすいなど話し、引き続き GC 周りなども調べていきたいと語っていました。

## Ruby beyond the language, @ebiltwin, @tenderlove

![13942815773_9a972583f5.jpg](http://farm8.staticflickr.com/7295/13942815773_9a972583f5.jpg)

次は Ebi (@ebiltwin) &amp; Aaron Patterson (@tenderlove) の発表です。
Aaron は Ruby と Rails 両方のコミッタとしてご存じの方や発表を聞いたことのある方も多いと思いますが、その奥様である Ebi ちゃんの発表を聞いたことがある人は居ないのではないでしょうか？

Ebi ちゃんは日本人であり、プログラマではなく「プログラマの奥様」です。

今まで は Aaron の付き添いばかりで自身の登壇経験は無かったそうでが、そんな Ebi ちゃんの話を是非聞きたいと思い「基調講演」のオファーをしたそうです。

前半は Ebi が発表しました。

こんなふうに発表することは二度と無いだろうと思い発表することにしたそうです。Aaron のためにカメラマンになったりダンスしたりしてるし、RubyConf2008 以降、50 以上 10 カ国以上のカンファレンスに行っているそうです。

閃きや楽しみがあるので旅をすること自体も楽しいし、やはり顔を合わせるのが良い、特にオンラインで喧嘩したことが有るなら生きてるうちに実際に会いに行くのが良いそうです。

そして Aaron は Rails4.2 で入る予定の AdequateRecord の説明をしていました。

簡単に言うと ActiveRecord の SQL 生成部分をキャッシュし使いまわすことによって find 系の処理が 2 倍早くなるということでした。

## 1 年かけて 1 つの Gem を作りました, @kunitoo
: ![13919610006_b61efdaed8.jpg](http://farm8.staticflickr.com/7272/13919610006_b61efdaed8.jpg)

[資料](https://speakerdeck.com/kunitoo/1nian-kaketegemwo1tuzuo-rimasita)

ドアマンから Asakusa.rb に参加するようになった @kunitoo の発表です。

せっかくなので、社内でやっている Asakusa.rb で自己紹介するときに紹介できる gem が欲しくて作った rgitlog を作るまでのお話でした。

その後、実際に rgitlog をライブコーディングで作り、1 年かかってたものが Asakusa.rb に通い続けると 20 分で出来る様になるという話で締めました。

## "[https://rubygems.org/gems/RFC7159](https://rubygems.org/gems/RFC7159)", @shyouhei

![13943215734_968cd99985.jpg](http://farm4.staticflickr.com/3795/13943215734_968cd99985.jpg)
[資料](https://speakerdeck.com/shyouhei/deeper-look-at-rfc7159-the-json)

@shyouhei は先月位 (開催日から見て) に新しく発表された JSON の仕様の話の話と、それに対応した Gem を作った話をしました。

この Gem の特徴としては、実装よりもテストデータのほうが大事で言語に依存せず新しい仕様に準拠しているかをチェックできるようにしたことを強調していました。

ただ、既に存在しているライブラリを置き換えるつもりはなく、このライブラリは厳密に動くのですが、動作が遅いので実用にはならないそうです。

ただ、遅い原因は["\uD800"]のようなバックスラッシュシーケンスの文字表現が原因なのでそういう文字が存在する前提で動いてしまうと世の中が不幸になるのでみなさんはそういった JSON を吐かないようにしましょうねというお話でした。

## A History of Fetching Specs, @hone02
: ![13919655501_8ae3a99126.jpg](http://farm4.staticflickr.com/3790/13919655501_8ae3a99126.jpg)

[資料](https://speakerdeck.com/hone/a-history-of-fetching-specs)

みなさんお世話になっている Bundler コミッタの @hone02 もアメリカから来てくれました。発表はもちろん Bundler についてです。

次のバージョンの Bundler の速度改善の話を Bundler と Rubygems の内部的な説明も交えつつしていました。

特に Bundler のコードだけの解決だけではなく Rubygems の方で CDN 使うなどの改善方法は  Bundler がただのコマンドラインツールではないことを改めて考えさせられました。

結論として次の Bundler での目玉機能は速度だという話で締めくくりました。

## Object Bouquet ～ 幸せの花束・RValue のきらめきを添えて ～, @_ko1 &amp; @yotii23

![13943221324_b0365edb8f.jpg](http://farm8.staticflickr.com/7115/13943221324_b0365edb8f.jpg)
去年 9 月に結婚した @_ko1 &amp; @yotii23 のノロケトークですので是非動画でご確認下さい。

結婚すると gem が出来るということで夫婦ペアプロで作成した Object-Bouquet の紹介からオブジェクトの関連などの内部的を説明していくという形で話されました。

実際のデモも見せつつ特異クラスなどがどのように関連しているかの説明をしつつ、やはりノロケるという形で終わりました。

ちなみに Object-Bouquet まだリリースされてないような気がします……。

## Another language you should learn, @knsmr
: ![13919618082_5b6b9401c0.jpg](http://farm8.staticflickr.com/7313/13919618082_5b6b9401c0.jpg)

TechCrunch Japan の編集長であり、今では TOEIC 990点満点の男、 @knsmr が 30 から英語を学んだ話をしました。

ジャーナリストという職業上、自分で英語でちゃんとインタビューしたいので学び始めたようです。

言語学校に通ったり色々勉強してそれなりに自信があったけど、結局アメリカに行ったら根本的に英語を知らないなということに気がついたそうです。(自分で英語勉強用の [Rails アプリも作った](http://knsmr.github.io/reijiro/)そうです！)

実際にアメリカで、図書館で文法の本読んだりテレビ見たりして毎日のようにドンドンマシになっていった実感はあったそうです。

おかげで今は英語でインタビューは出来るようになったので次は英語で商業文章を書いてみたいそうです。

## mruby hacking guide, @_ksss_

![13919602771_be66915056.jpg](http://farm8.staticflickr.com/7426/13919602771_be66915056.jpg)
[資料](https://speakerdeck.com/ksss/mruby-hacking-guide)
@_ksss_ はイベント全体でも何度も名前の出てきた RHG(Ruby Hacking Guide) をもじって mruby hacking guide というタイトルで発表しました。

今日も発表をしている @_zzak のスピーチに感動して Ruby にハマり gem を量産していったそうです。

そこから mruby にも興味が出てきて色々コミットしているものを紹介していきました。

やはりデータ構造が大事なのでそこを読み進めつつ、CRuby のコードも参考にしつつドンドン取り込んでいっているお話でした。

## Hacking Home, @a_matsuda
: ![13919613646_b66fe01455.jpg](http://farm8.staticflickr.com/7012/13919613646_b66fe01455.jpg)

[資料](https://speakerdeck.com/a_matsuda/hacking-home)

続いて Asakusa.rb 主催者の @a_matsuda の発表はテクニカルな話はしないよって事で資産運用と実際に家を建てた時の話でした。

実際の資産運用の金額も入った内容から、コード書いていたら実社会での信用もできた話や、家を立てるときに API を色々組み込みたくなる話などプログラマならではの内容でした。

特に pattern language など建築からシステム開発へ何かを取り入れたり例え話をするなどの話はよくあります
が、逆の視点で建築をシステム開発風に見立てるのはあまりないのでいつもとは逆な少し奇妙な気持ちで楽しめました。
最後は「みんなもおうちを建てて毎日の暮らしをハックしよう」という話で締めました。

## Ruby 会議で SQL の話をするのは間違っているだろうか,  @mineroaoki

![13919609142_31ee8bc76a.jpg](http://farm4.staticflickr.com/3786/13919609142_31ee8bc76a.jpg)
[資料](http://www.slideshare.net/mineroaoki/20140420-oedo-ruby-conference-04-rubysql)

トリを務めるのは今日のイベントでも何度も出てきた RHG こと 「Ruby ソースコード完全解説」の著者でもある @mineroaoki の発表です。

「25 分でわかるビッグデータ分析」と題して 100TB くらいのデータを分析する時に考えることを話しました。

分散処理 → 並列 RDB → MapReduce とそれぞれ説明し、並列 RDB、MapReduce の利点を上げつつ段々両方の利点を持ったものになっていくとのことでした。

また、特に並列 RDB などはまだまだエンタープライズよりに偏っていますが、良いものは良いのでどんどん取り入れていこうと話を締めくくりました。

## まとめ
: ![13947376093_2e910b8015.jpg](http://farm4.staticflickr.com/3801/13947376093_2e910b8015.jpg)

一日の中に豪華な発表者のそれぞれ濃い話が集中しており、どれも貴重な話でした。

そんな背景もあり、この記事では概要だけの説明になってしまっていますが、ほとんどの発表は資料も動画も公開されていますので興味のある発表は是非そちらを身ていただければと思います。

また、今イベントを開催した Asakusa.rb も毎週火曜日に開催されており、頻繁に豪華なゲストも参加していますので興味をもった方は参加していただけると Asakusa.rb の幽霊部員な僕も嬉しく思います。

## 写真の提供

@igaiga さん 撮影 [https://www.flickr.com/photos/igaiga/sets/72157644163563563/](https://www.flickr.com/photos/igaiga/sets/72157644163563563/)

@hsbt さん 撮影 [https://www.flickr.com/photos/hsbt/sets/72157644118433822/](https://www.flickr.com/photos/hsbt/sets/72157644118433822/)

## 著者について

### ヨシオリ ([@yoshiori](https://twitter.com/yoshiori/))

Asakusa.rb の中では結構古参だけど、幽霊部員。すいません＞＜


