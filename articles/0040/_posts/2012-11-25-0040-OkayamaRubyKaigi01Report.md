---
layout: post
title: RegionalRubyKaigi レポート (30) 岡山 Ruby 会議 01
short_title: RegionalRubyKaigi レポート (30) 岡山 Ruby 会議 01
tags: 0040 OkayamaRubyKaigi01Report
---
{% include base.html %}


## RegionalRubyKaigiレポート岡山 Ruby 会議 01

### 開催概要
: ![top.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/top.jpg)

開催日
:  2012 年 07 月 07 日 (土) 13:00 〜 17:30

開催場所
: 岡山国際交流センター 7F 多目的ホール

主催
: 岡山 Ruby 会議 01 実行委員会

後援
: 日本 Ruby の会, 岡山 Ruby / Ruby on Rails 勉強会

公式ページ
: [http://regional.rubykaigi.org/okayama01](http://regional.rubykaigi.org/okayama01)

公式ハッシュタグ
: #okark01

### はじめに

岡山初の地域 Ruby 会議となる岡山 Ruby 会議 01 が開催となりました。当初の予想を大きく上回り、岡山だけでなく県外からもご参加いただき、会の告知後早々に定員がいっぱいになってしまいました。参加出来なかった方も、この記事で当日の雰囲気を掴んでいただければと思います。

## 招待講演

### 良い場所に、良い名前で - Good Names in the Right Places on Rails

#### 大場寧子(@nay3)
: ![ooba.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/ooba.jpg)

まずはじめのセッションは、招待講演ということで株式会社万葉の大場寧子さんにお話いただきました。タスク管理が出来る Web アプリケーションを、簡単な仕様の説明のあとに、ライブコーディングで作成しつつ使ったコマンドや、Rails のコマンドにより自動生成されたファイルの説明をするという形でした。時間の関係で全ての機能をその場で実装することは出来ませんでしたが、すでに出来上がっているものを見せていただきソースコードも github に公開されています。

ライブコーディングは、「良い場所に、良い名前で」のテーマにそってお話でした。Rails には、この処理を書くにはこの場所というのがあり、Rails 開発でありがちなコントローラーにコードがあふれた場合の対処法、ビューにロジックは書くべきか？、モデルに表示レイヤの処理はさせないべきか？、変数やメソッドにはどんな風に名前を付けるべきかについて説明していただきました。

Rails をはじめて MVC について知識が付いてきて、そしていざ開発をやってみるとなってしまう、陥ってしまう例が多く、具体的にどのようにすべきか、どのように考えれば良いかが聞けるセッションでした。

[発表資料](http://www.slideshare.net/nay/good-names-in-right-places-on-rails)

[発表資料(ソース)](https://github.com/nay/mit)

## 一般講演

### RSpec でテストを書いてみよう

#### 山本 和久(@kazuhisa1976)
: ![kazu_green.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/kazu_green.jpg)

なぜテストを書くのか？　というお話から、実際に RSpec を使ってテストが通るまでのデモをしていただきました。

* 修正時に手動での再テストが不要
* テストコードにより仕様が明確になる
* 安心感


という3つの項目で、テストコードが必要で、書くことのメリットを挙げられていました。

またテストを回し続けていくことで、 Red → Green → Refactoring → Red ...というサイクルを繰り返し汚くて動かないコード→汚くて動くコード→綺麗で動くコードへ持って行き最初から綺麗なコードを書くだけが道ではないということを教えていただきました。

テストコードを書いてグリーンへ持っていくでもでは、RSpec でテストコードを書き、ファイルの更新を検出して、自動でテストが実行される環境で、コードを書いていく過程で徐々にテストが通ってレッドからグリーンへ持っていく様子を見ることが出来ました。

最後にテストが全て通ったときに、「では、私も緑になります」と、それまで着ていた赤い T シャツ[^1]を脱ぎ捨て下に着ていた緑の T シャツになるパフォーマンスで会場を沸かせていました。

### ところで Ruby ってどうやって勉強するの

#### 吉田和弘(moriq)
: ![moriq.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/moriq.jpg)

Ruby の勉強について、学習者ではなく教育者目線での Ruby 勉強法についてのお話でした。教育の難しい点として、Ruby を実践するにあたって、まずは Ruby の文化と理論を勉強する人になんとか伝えないといけない。理論については色々と資料があるからまだいいが、文化となると伝えるのが難しいそうです。文化は Ruby に慣れている人にとっては自明のことなので、誰も言及しない。それをどうにかしたいと悩んでいるとのことでした。

また、教育している経験から初学者や他の言語の経験者がどのようなところで躓きやすいかの話をされていました。つまずくポイントは 4 点で、下記のようになっています。

* 変数スコープ
  * Ruby の変数は名前によってスコープが違うという話をちゃんと説明しないといけない。PHP から来た人が、全部グローバル変数にするという例があったそうです。
* ブロック構文
  * do って何だ？　と言ったところから、処理を渡すという概念など特に初心者が混乱するようです。
* オブジェクト参照
  * 代入などの時に、メモリーがコピーされているのかどうか等が分り辛いとのことです。
* MS Windows
  * Windows で Ruby をやろうとすると、つまずくことが多いようです。


既に理解している人、理解にあまり苦労しなかった人は初学者のこういった躓きポイントが分からないので、これから誰かに Ruby を教える必要がある方には非常に参考になる話だなと思いました。

### Rubyist Magazine - るびま の紹介

#### 小西 雅也(@ore_public)
: ![rubima.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/rubima.jpg)

るびまの紹介をしていただきました。るびまとは有志により作られている Web 雑誌です。岡山の Rubyist の方も記事を書かれているとのことで、

* [Rubyイメージソングコンテスト]({% post_url articles/0033/2011-04-05-0033-ImagesongContest %})
* [Jeweler で作る Rails 用 RubyGems パッケージとそのテストについて]({% post_url articles/0037/2012-02-05-0037-CreateRailsPlugin %})


の 2 つがその記事です。

岡山で記事を書いてくれる人を募集してたり、声をかけたりしていっているとのことです。

[発表資料](http://www.slideshare.net/mkonishi1981/rubyist-magazine-13577572)

### 大学の研究室における Ruby 活用事例紹介

#### 木村 有祐 @stpsnp

#### 吉井 英人 @hide_yoshii

#### 福田 大志 @fukuda_h
: ![uni.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/uni.jpg)

研究室で Rails を用いての開発事例のお話でした。研究室では、グループウェア、仕事の途中状態を保存、再現するツール、タスク管理機能を持つカレンダーなどを開発しているとのことで、2 週間に一度の開発打ち合わせ、Redmine を使ってのチケット管理、2 ヶ月に一度のリリースを行うなど研究での活用というよりは、実際の開発現場での事例という印象でした。

また、研究室での開発は先輩から引き継がれて行われているそうで、新人研修まで行われているとのことです。今回発表された 3 人の新人研修課題での感想として、Rails は scaffold までは簡単だがそれ以降は覚えることが多い、Rails のバージョンを追いかけるのが大変、Ruby はとっつきやすいが Rails は難しいと感じたとのことです。
また難しいという印象だけでなく、なんとなく書いて動くところが良いという感想も出ていました。そして、この先輩から引き継がれて行われている開発のなかで「べからず集」というものが作られており、その内容が Rails での開発を行う上で注意するべき点がよくまとめられていました。

[発表資料](http://www.slideshare.net/nomlab/nomuralaboratoryslide)

[べからず集](http://www.slideshare.net/nomlab/nomlabokayamarubysubslide)

### Ruby で楽々サーバー管理

#### 小西 雅也(@ore_public)
: ![konishi.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/konishi.jpg)

Ruby の構成管理ツールである Chef の紹介です。Ruby を使ってサーバー管理を楽にしようというテーマで、Chef でどんな事が出来るかや、Chef を使う上で理解しておくといい知識として、構成例、用語の解説、インストールでのつまりどころの解説をされていました。

特に chef-server 側のインストールは Debian で実行するのが一番楽で、現場管理しているサーバーに Debian が無かったとしても Chef 用に一台用意したほうがいいとのことでした。他の OS ではインストールに苦労し、本来行いたいサーバー管理以外の部分で時間が掛かっては本末転倒になってしまうからとのことです。

用語の理解とインストールがうまく行って動くようになれば、公式のドキュメントを参考に色々と設定が出来るようになるので、そこに行くまでにはなるべくつまずきにくいやり方を真似るのが良いようです。

[発表資料](http://www.slideshare.net/mkonishi1981/ruby-13577557)

### Ruboto でアプリ開発を試みた

#### 尾古 豊明(@patorash)
: ![pato.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/pato.jpg)

当初予定していた Ruboto の発表者の方がこれなくなってしまい、急遽 @patorash さんに同じ Ruboto をテーマに発表していただきました。会議の 1 週間前に突然のお願いをしたにもかかわらず面白い発表を用意してくださいました。

Ruboto は Android アプリを Ruby を使って作れるというもので、メリットとして

* Ruby で書ける
* gem が使える
* Java で書く時と比べると getter, setter から開放される


ことがあげられるそうです。

しかしデメリットとして

* アプリの起動が遅い
* 日本語の情報やサンプルが少ない
* 同志が少ない


とのことで開発ノウハウを知るのが大変なようです。

ひと通りアプリケーションを作っていく流れを説明していき、最後にまとめとして、デバッグが大変、現時点で実用するのは難しいという感想を話されていました。ただやはり Ruby で書けるところに魅力を感じるとのことで、これからが楽しみなプロダクトとのことです。

[発表資料](http://www.slideshare.net/chariderpato/ruboto)

## LT大会　＆　懇親会

### LT 大会昼の部

LT 大会昼の部ということで、一般講演の終了後に LT を開きました。

* 柴田博志(@hsbt)さん
* ursmさん([発表資料](http://ursm.github.com/okark01-rails-with-postgres/))
* 仲光信吾さん([発表資料](http://www.slideshare.net/naka0517/ork01-13600583))
* @zephiransasさん
* 三輪さん
* 中本さん
* 中野さん
* 逸見さん([発表資料](http://www.slideshare.net/mako_wis/rhodes-13594596))


以上の方々に発表していただきました。

![lt1.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/lt1.jpg)
![lt2.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/lt2.jpg)
![lt3.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/lt3.jpg)
![lt5.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/lt5.jpg)
![lt6.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/lt6.jpg)
![lt7.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/lt7.jpg)
![lt8.jpg]({{site.baseurl}}/images/0040-OkayamaRubyKaigi01Report/lt8.jpg)

### LT 大会夜の部

また、LT 応募者が多かったことと、岡山では勉強会後の懇親会でも LT を行うという文化 (？) があるということで
プロジェクタの設備がある懇親会会場の [Ryoutei 座スタジアム](http://www.233-3959.com/ryoutei/index.html) で懇親会を行いながら、当日飛び入り参加 OK の LT 大会（夜の部）を開催しました。

* つじたさとみさん
* 高橋さん([発表資料](http://www.slideshare.net/takahashim/okark2012))
* アジャイルウエア川端さん
* 万波さん
* 山本和久さん
* 英吉さん
* 三輪さん
* 佐藤竜之介(@tricknotes)さん([発表資料](http://www.slideshare.net/tricknotes/capybara-introduction))


事前に応募のあった以上の方々以外にも、その場で飛び入りで会場から参加していただきとても盛り上がった懇親会となりました。

### 最後に

#### 岡山 Ruby 会議 01　実行委員長　山口真央（@gutch_jp）

思えば昨年の年末に開催宣言をしてから、あっという間に本番を迎えた気がします。山本さん（@kazuhisa1976）から最初に岡山 Ruby 会議構想を聞いた時には、まさかここまでの規模の会議が出来るとは思っていませんでした。

しかし、開催へ向けたスタッフのキックオフミーティングでは多くのメンバーが集結し、開催へ向けての申込では開催まで 2 ヶ月以上残して満員御礼となる逆に驚きの展開となりました。このことは、岡山という地での Ruby に対する熱い想いを改めて感じる良い機会にもなりました。

当日は、60 名を超える岡山 Ruby コミュニティでは今まで経験したことのない規模のイベントとなり、色々と不手際な面などもありましたが、大きなトラブルもなく実施できたことを嬉しく思っております。

テーマは「Ruby の世界に入ってみよう」ということですので、このイベントをきっかけに少しでも Ruby への興味が増したり、Ruby に触ってみたいと思ってくれる方がいらっしゃれば幸いです。

最後になりましたが、講演してくださった大場寧子さん（@nay3）を筆頭とした発表者の方々、イベントを陰ながら支えてくれたスタッフのみんな、そして参加して下さった皆さまに心より感謝しつつ、この熱意を是非、次の時代（次回）へと繋げていけたらいいな、という想いを添えつつあいさつとさせていただけたらと思います。

本当にありがとうございました。
----

[^1]: スタッフ T シャツです
