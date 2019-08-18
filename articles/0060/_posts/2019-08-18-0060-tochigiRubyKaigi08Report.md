---
layout: post
title: RegionalRubyKaigi レポート (75) とちぎ Ruby 会議 08
short_title: RegionalRubyKaigi レポート (75) とちぎ Ruby 会議 08
tags: 0060 tochigiRubyKaigi08Report regionalRubyKaigi
post_author: saku35
created_on: 2019-08-18
---
{% include base.html %}
## とちぎRuby会議08レポート

### 書いた人
Saku35(github)

### はじめに
* 日時 :2019/06/29(土) 11:00 ～ 20:00
* 会場 : 那須野が原ハーモニーホール
* 主催 : とちぎRubyの勉強会（toRuby)
* 後援 : 日本Rubyの会
* 参加者 : 約50名

### ランチセッション
![johtani.jpg]({{base}}{{site.baseurl}}/images/0060-tochigiRubyKaigi08Report/johtani.jpeg)

　検索エンジンを開発しているElastic Searchから、@johtaniさんがご講演くださり、
Elastic Stackによる、デモサイトのデバッグ作業をライブしていただきました。
ウェブアプリケーションに疎い私にこのデバッグ作業がどれほど有用なのかわかったなんて口が裂けても言えませんが、ログの検索やらアクセスポイントの可視化やら、@johtaniさんが機能を紹介するたびに、「え、これ便利」と近くから声が聞こえてきたので、そんな風にこの機能の便利さを実感したいなーなんて思いました。

講演内容はこちら👉[アプリケーション（パフォーマンス）監視入門 - Elastic編](https://noti.st/johtani/eJPLbZ/elastic)

### 招待講演１
![sumim.jpeg]({{base}}{{site.baseurl}}/images/0060-tochigiRubyKaigi08Report/sumim.jpeg)

　北海道よりはるばる@sumimさんがオブジェクト指向とSmalltalkのお話をしに来てくださいました。
オブジェクト指向プログラミングの歴史から、Smalltalkの誕生など、いきなり大学の講義みたいな発表でびっくりしました。いろんなプログラミング言語があるけれど、それらに派生する前の中心部分にSmalltalkが存在するような、まだ漠然としてますが、そんなイメージを持つことができる講演でした。
@m_sekiさんが20年前に作ったSmalltalk処女作も公開していただいて、講演を通して「歴史」を実感しました。

講演内容はこちら👉[オブジェクト指向とは何ですか？](https://www.slideshare.net/sumim/ss-152523149)

### 招待講演２
![yhara.jpeg]({{base}}{{site.baseurl}}/images/0060-tochigiRubyKaigi08Report/yhara.jpeg)

　@yharaさんが作ったzanzouというGemについてお話してくださいました。
Ovtoでアプリを作るときにapp.stateを破壊的に変更したくないということがモチベーションで作ったそう。必要は発明の母ですね。
ネーミングも@yharaさんのセンスが光っていて、破壊的操作をしたように見えて…していない、バトルマンガの「やったか…？やってない…」というところにインスピレーションを受けzanzou（残像）にしました。というトークには会場も笑いが起こっていました。

講演内容はこちら👉[それは残像だ](https://yhara.jp/2019/07/10/jun-2019-tork)

### 招待講演３
![sugamasao.jpeg]({{base}}{{site.baseurl}}/images/0060-tochigiRubyKaigi08Report/sugamasao.jpeg)

　Rubyを説明するのは難しい。と題し、@sugamasaoさんが自著「かんたんRuby」を製作していたときの体験談をご紹介くださいました。
puts “Hello World”を説明するだけでも、いろいろ考えてしまいますよね？という会場への問いかけ、クラスの説明に入った途端に情報量がいっきに増えることなど、初心者にRubyを教える時の大変さを会場と共感しながら進めていく講演内容に、聞き入っていました。
質問タイムでは、会場から「私はこういうの風にした」とか「私がプログラミングで楽しいと感じたのはこんな時」など積極的な意見・質問が出て、会場みんなが初心者にRubyを教えることに思いを馳せながら講演に参加できたのではないかと思います。

講演内容はこちら👉[Rubyを説明するのは難しい(仮)](https://speakerdeck.com/sugamasao/ruby-is-difficult)

### 一般講演１
![ken_c_lo.jpeg]({{base}}{{site.baseurl}}/images/0060-tochigiRubyKaigi08Report/ken_c_lo.jpeg)

　esaの@ken_c_loさんがesaについてる機能のひとつであるWIP(Work in Progress)について語ってくださいました。
WIPは、「これからまだ良くなりますけど、とりあえずここまでやりました」ということを前面に押し出すサインで、
WIPがやり始めのハードルをさげたり、読み手を優しくしたりすることで、自分のやったことが相手の役に立ちやすくなる。
という、WIPの素敵さを伝えてくれる講演でした。

講演内容はこちら👉[esaのWIPの話 2019](https://speakerdeck.com/ken_c_lo/wip-2019)

### 一般講演２
![youchan.jpeg]({{base}}{{site.baseurl}}/images/0060-tochigiRubyKaigi08Report/youchan.jpeg)

　@youchanさんがConway’s Game of Lifeをワンライナーで書いてきてくれました。
日本語ではライフゲームと呼ばれるもので、ワンライナー以外にライフゲームで描くデジタル時計など、ライフゲームの面白さの一端に触れさせてくれる貴重な講演だったと感じました。
Ruby会議で興味を持ったConway’s Game of Lifeをワンライナーで描くことによって、日々の好奇心や創造力を大事にすることも説いてくださったすてきな講演でした。

講演内容はこちら👉[ワンライナーで書く「Game of Life」](http://youchan.org/slides/toruby_20190629/)

### 一般講演３
![kakutani.jpeg]({{base}}{{site.baseurl}}/images/0060-tochigiRubyKaigi08Report/kakutani.jpeg)

　高橋、RubyKaigiやめるってよ　と題しまして、@kakutaniさんが講演してくださいました。
高橋さんがRuby会議をやめると言ったとき、周りの人がどうRuby会議のことを考えて、どういう気持ちをこめてリブートしたのかということを熱く語ってくださいました。
最近Ruby界隈に関わり始めた人にとっては、Rubyコミュニティの概観を把握するのにはもってこいの講演で、かつ@kakutaniファンにとっては久しぶりの@kakutani節を見られたということで、新参者から古参まで幅広く楽しめる、満足感の高い講演だったと思います。

講演内容はこちら👉[The Kaigi Thing 高橋、RubyKaigiやめるってよ](https://speakerdeck.com/kakutani/the-kaigi-thing)

### 基調講演とハンズオン
![m_seki.jpeg]({{base}}{{site.baseurl}}/images/0060-tochigiRubyKaigi08Report/m_seki.jpeg)

　@m_sekiさんが、分散オブジェクトとはあれですか？と題しましてdRubyについて講演してくださいました。
5分でおわる基調講演。残りの55分はdRubyを使ってしりとりをしました。
ネットワークを介して他人のオブジェクトにさわるという、かつてない触れ合い体験によって、dRubyの不思議さ・すごさに魅了された人も多いでしょう。

講演内容はこちら👉[分散オブジェクトとはあれですか？](https://speakerdeck.com/m_seki/tochigi-ruby-kaigi-08-keynote)

### 特別LT
![june29.jpg]({{base}}{{site.baseurl}}/images/0060-tochigiRubyKaigi08Report/june29.jpeg)

　この日、お誕生日を迎える@june29さんにLT時間6分29秒という特別LTを依頼し、
「令和元年版　大和田家を支える技術」と題しまして、@june29、@mamipeko夫妻にLTしていただきました。
円満な環境をテクノロジーによって構築した実例の数々。
Slack, Scrapbox, M5Stack, スマートロックなどなど、大和田家に合わせたオリジナルのライフハックをご紹介いただきました。
明日我が家でも使いたくなる、ライフハックへのヒントやモチベーションをもらえるLTだったと思います。
6分29秒という異色のLT時間を抜群のタイムキーピング力によって乗りこなした夫妻には、大きな拍手が送られました。

講演内容はこちら👉[大和田家を支える技術 令和元年版](https://speakerdeck.com/june29/our-life-supported-by-technologies-and-skills)

### 2分間LT
 　立食形式のパーティと並行して、2分間LTが開催されました。用意された2時間というたっぷりの時間は、とちぎRuby会議08の参加者全員が発表するのに十分な時間で、実に40名ほどが各々自分の好きなこと・関心のあることについて発表しました。
　筆者としてはこの「2分間」というのは絶妙で、最悪うまくいかなくてもたった2分だ・・・と思えば、かなり参加ハードルが下がって初LTを乗り越えることができたのでした。
　発表内容も面白いものばかりでしたが、40題目以上をここに書ききるわけにはいかないのが残念です。あえて筆者が個人的に印象に残ったものをあげるなら・・・@yharaさんのSumotalkですね。