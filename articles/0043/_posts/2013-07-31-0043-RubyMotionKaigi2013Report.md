---
layout: post
title: RubyMotion Kaigi 2013 レポート
short_title: RubyMotion Kaigi 2013 レポート
tags: 0043 RubyMotionKaigi2013Report
---


## RubyMotion Kaigi 2013 レポート

書いた人 : 海老沢 聡 ([@satococoa](https://twitter.com/satococoa))

### はじめに

この記事は [RubyKaigi 2013](http://rubykaigi.org/2013) 前日の 5/29(水) に開催された [RubyMotion Kaigi 2013](http://connpass.com/event/2095/) のレポート記事です。

RubyMotion Kaigi 2013 は日本では初めて開催された RubyMotion のカンファレンスです。

Usteam 上で [動画](http://www.ustream.tv/channel/rubymotion-kaigi-2013) が公開されています。そちらも合わせてご覧頂けると幸いです。

### 開催概要

開催日
:  2013 年 5 月 29 日 (水)

開催場所
:  株式会社ミクシィ 様

主催
:  [RubyMotion JP](http://rubymotion.jp)

公式ページ
:  [RubyMotion Kaigi 2013](http://connpass.com/event/2095/)

### 開催までの流れ

日本の RubyMotion ユーザのコミュニティである [RubyMotion JP](http://rubymotion.jp) では月に 1 回 "RubyMotion もくもく会" と称し、RubyMotion に関することを自由に実践する勉強会を開催しています。

そのもくもく会の最中に、「もし (RubyMotion 開発者の) Laurent さんが RubyKaigi で日本にいらっしゃるのなら、それに合わせて日本でもカンファレンスをやってみたらどうか？」という案が挙がりました。

2013 年 3 月にベルギーで世界規模のカンファレンスである [#inspect 2013 - RubyMotion Conference](http://www.rubymotion.com/conference/) が開催された直後であるため、日本における RubyMotion の現状や Objective-C 経験者に RubyMotion の印象を話してもらうなどの独自コンテンツがある方が楽しいのではないかなどと議論し、今回のような形での開催となりました。

企画・準備・当日の運営までもくもく会の常連メンバーが中心となって進めてゆきました。

また、以前から RubyMotion に関するイベントを開催されている福岡のコミュニティとも協力したいと思い Ruby Business Commons 最首さんにも声をかけさせていただき、とても快くご協力いただきました。

### 当日の様子

平日の夕方 18:30 という比較的早い時間からの開催ではありましたが、多くの方に集まっていただき RubyMotion への関心の高さが感じられました。

##### 基調講演: Laurent Sansonetti (@lrz) さん

なんと、冒頭は日本語で自己紹介をしてくれました。その様子はぜひ USTREAM で公開されている[録画](http://www.ustream.tv/recorded/33482193)をご覧頂ければ幸いです。

自己紹介の後は RubyMotion を支える HipByte 社のチームの紹介があり、それに続いて 2013 年 5 月にリリースされた RubyMotion 2.0 の新機能や今後のロードマップについての説明をしていただきました。

実際に RubyMotion を用いて開発をしている人にとっては紹介されたそのどの機能も魅力的でありみなさんとても真剣に聴き入っていました。

ロードマップによると今後 RubyMotion では iOS、OS X に加えてもう一つのプラットフォームのサポートを予定しているそうです。どのプラットフォームになるのかは現時点では明らかにされていませんので、続報を待ちたいと思います。

質疑応答では以下の 2 つが出ました。

Q. CRuby 2.0 の機能 (Refinements, Keyword Arguments, ..etc.) は RubyMotion でもサポートする予定はあるのか？
: A. その予定はあるけれども、すぐに出来るとは限らない。特に Keyword Arguments は文法的に Objective-C のメソッドのシグネチャとバッティングしてしまうところがあり、扱いが難しい。

Q. Objective-C 由来のメソッド等はなぜ (ruby の慣習に沿ったスネークケースではなく) キャメルケースなのか？
: A. 全部スネークケースにするのは可能ではあるが、内部的にとても複雑になってしまうため Objective-C 由来のオブジェクトはキャメルケースのままにすることにした。

##### 日本における RubyMotion の現状: Ruby Business Commons 最首さん

RubyMotion のみに関わらず、mruby, mobiruby, Unity など、組み込みやスマートフォンという大きな括りで昨今 Ruby が注目を浴びているというお話をしていただきました。

やはり東京と比較しても福岡では特に組み込みの盛り上がりが大きいらしいという印象を持ちました。

最首さんご自身でも RubyMotion を使って iOS アプリケーションを開発してみたそうで、その生産性に好印象を持ったそうです。

##### RubyMotion 2.0: @watson1978 さん

[RubyMotion 2.0](https://speakerdeck.com/watson/rubymotion-2-dot-0)

@watson1978 さんは MacRuby の主要なコミッターであり、かつ HipByte 社のメンバーとして日本からリモートで RubyMotion の開発に携わっていらっしゃいます。

まずは MacRuby との出会いやそのコミッターになる _契約_ を交わしたエピソードが公開されました。

その後は RubyMotion の仕組みや特徴についてのお話、RubyMotion 2.0 で搭載された以下の新機能の詳しい紹介をしていただきました。

_OS X Support_

OS X 用のアプリケーションが作れるようになりました。以下の点で MacRuby と比べて以下のような特徴があります。

* 事前にネイティブにフルコンパイルしているからパフォーマンスが良い
* スタティックライブラリーが使える
* require, eval, 標準ライブラリーは使えない


_Project Template_

ユーザーが独自のテンプレートを作れる機能です。よく使う gem をあらかじめ Gemfile に書いておいたり、app_delegate.rb で `@window` をインスタンス化するようなお決まりのコードをテンプレート化しておけます。

_Command-Line Plugin_

ユーザー独自のサブコマンドを `motion` コマンドに追加できる機能です。@watson1978 さんがサンプルで作った [motion-doc](https://github.com/Watson1978/motion-doc) コマンドの紹介がありました。

_Common Build Directory_

一度コンパイルした gem を他のアプリでも使い回せるようにし、ビルド時間を短縮する機能です。特に [BubbleWrap](http://bubblewrap.io) や [sugarcube](https://github.com/rubymotion/sugarcube) のような大きなライブラリを使うときに大きな効果が期待できそうです。

_Weak Reference_

弱参照をサポートする機能です。RubyMotion には ARC 同様のリファレンスカウンタによる GC が実装されています。オブジェクトを代入する際には自動的にリファレンスカウンタが上がるようになっているのですが、この `WeakRef` を使用することで、リファレンスカウンタを上げずにオブジェクトを参照することが出来ます。

##### 実践 RubyMotion: @naoya_ito さん

[実践 RubyMotion](https://speakerdeck.com/naoya/shi-jian-rubymotion)

アプリケーション実装者の視点から見た RubyMotion について発表していただきました。

まずは RubyMotion の特徴と簡単なコード例を示し、Objective-C の知識が無くても RubyMotion でアプリケーションを開発することは可能だが iOS の知識は必要である、という点について説明をしていただきました。

つまり Objective-C の代わりに言語を Ruby を使用しているだけであって、フレームワークは Cocoa Touch を使用しているのでフレームワークについての知識は必要になる (学ぶ必要がある) とのことです。

続いて、RubyMotion における `Object` クラスは `NSObject` クラスを継承している作りとなっているため、Cocoa (Touch) の API がそのまま呼べることについての説明がありました。

次に並列処理についてですが、GCD を使うことによって以下のコード例のように Ruby らしく書くことが出来ます。

{% highlight text %}
{% raw %}
 Dispatch::Queue.concurrent.async do
   image = UIImage.alloc.initWithData(
     # String#nsurl は sugarcube の機能
     NSData.dataWithContentsOfURL(url.nsurl)
   )

   Dispatch::Queue.main.sync do
     @imageView.image = image
   end
 end
{% endraw %}
{% endhighlight %}


RubyMotion のメモリ管理についての説明もありました。

RubyMotion についての説明はここまでで、あとは実際に RubyMotion で開発する上での Tips や、定番のライブラリの紹介等がありました。

##### That Objective-C guy think about RubyMotion: @mfks17 さん

[That Objective-C guy think about RubyMotion](https://speakerdeck.com/mfks17/that-objective-c-guy-think-about-rubymotion)

@mfks17 さんには「Objective-C 経験者から見た RubyMotion」という観点からお話ししていただきました。

RubyMotion でアプリケーションの開発を行うことの利点の一つとして「Xcode を使わずに済む」という点を挙げられていました。
特にビルドの設定に関してはわかりにくい GUI での操作ではなく、Rakefile にコードを書くというテキストベースの方法で完結できるのが良いとのことでした。

デバッグに関しては gdb を使ってコマンドラインでのデバッグも可能ですが、RubyMotion にも対応した IDE の [RubyMine](http://www.jetbrains.com/ruby/) を利用することにより、GUI でもデバッグ可能だそうです。

他にも RubyMotion での開発を助ける以下のツールの紹介もありました。

最後にテストツールやフレームワークについての紹介していただきました。
Objective-C で開発する際は OCUnit(SenTestingKit)、Kiwi、GHUnit などが広く使われているそうですが、RubyMotion では MacBacon、motion-calabash などが使えるとのことです。
そしてテストを日々のワークフローの中に組み込んで習慣化することが大切であるという心がけのお話もありました。

@mfks17 さんは今後 iOS のアプリケーション開発に関する勉強会の立ち上げを考えているとのことです。

##### LT1 / #inspect 2013 - RubyMotion Conrefence の感想: 井上さん

[#inspect 2013 - RubyMotion Conrefence](http://www.rubymotion.com/conference/) に参加した日本人全 4 名のうちの一人、井上さんによる発表でした。カンファレンスに参加した経緯やカンファレンスでの印象に残った発表などについてお話しいただきました。

##### LT2 / Dive into Joybox: @yonekawa さん

[Dive into Joybox](https://speakerdeck.com/yonekawa/dive-into-joybox)

RubyMotion でゲーム開発をするというテーマで発表していただきました。

[Joybox](https://github.com/rubymotion/Joybox) という [Cocos2D](http://www.cocos2d-iphone.org) と [Box2D](http://box2d.org) のラッパーの紹介と、それを使って作った実際に動作するデモがありました。

[Joybox](https://github.com/rubymotion/Joybox) は [#inspect 2013 - RubyMotion Conrefence](http://www.rubymotion.com/conference/) で発表されたライブラリで、@yonekawa さんは Joybox の最初のコントリビュータとして精力的に開発に関わっていらっしゃいます。

まだまだ仕事で使用するには機能が不足しているとのことですが、今後の開発に期待したいところです。

##### LT3 / RubyMotionについて本気出して考えてみました: @ainame さん

[RubyMotionについて本気出して考えてみました](https://speakerdeck.com/ainame/rubymotionnituiteben-qi-chu-sitekao-etemimasita)

Emacs 用の RubyMotion の拡張である [motion-mode.el](https://github.com/ainame/motion-mode) を開発された「[神](http://d.hatena.ne.jp/naoya/20130322/1363921458)」こと @ainame さんの発表です。

本気で業務で RubyMotion を使うためにはどうしたらいいのか考えてみたというテーマでした。

まず最初に業務で RubyMotion を使おうとした際のハードルとして、以下の 3 点が挙げられていました。

1. 覚えることが多い
1. 初心者が入門しづらい
1. 本当に業務で使えるか不安


しかし、以下の観点から考えると、Web アプリケーションの経験がある人にとっては、新規に Objective-C で iOS の開発を覚えるよりはむしろ RubyMotion の方が始めやすいのではというお話でした。

* 開発スタイルが Web に近い: 使い慣れたエディタ、RSpec like なテスト、コマンドライン中心の開発スタイル、サーバー / クライアント双方を Ruby で書ける
* サポートの返答が速い: iOS の新しいバージョンへの対応も問い合わせへの対応も速い
* Ruby の力を信じる: rake、 gem などの便利なツールがあり、メタプログラミングが強力、そして書いていて __楽しい__


@ainame さんは最近 [RubyMotionTokyo](http://rubymotion-tokyo.doorkeeper.jp) というコミュニティを立ち上げられました。都内で隔週で meetup を開催されているので RubyMotion に関心のある方はぜひ参加されてはいかがでしょうか。

##### LT4 / RubyMotion meets IRC: @ninjinkun さん

[RubyMotion meets IRC](https://speakerdeck.com/ninjinkun/rubymotion-meets-irc)

@ninjinkun さんは最近 [NJKWebViewProgress](https://github.com/ninjinkun/NJKWebViewProgress) というライブラリを作られて、世界でも注目されている開発者の一人です。

今回は RubyMotion で IRC クライアントアプリをつくってみたというお話ですが、RubyMotion では Ruby の文法でメタプログラミングができ、正規表現が使えるという特徴からテキストベースのプロトコルを扱うのに向いているのではないかということがモチベーションになっているそうです。

プロトコルパーサを実装する際には node.js で書かれたコードを Ruby のコードに翻訳したらそのまま動作したり、CRuby で実装されたコードをコピー &amp; ペーストしたらそのまま動いたといった経験をお話ししてくださいました。

ソケットの実装には [motion-cocoapods](https://github.com/HipByte/motion-cocoapods) 経由で [GCDAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket) を使うことで比較的容易に実装できたそうです。

View は小さな HTML テンプレートエンジンを実装し、UIWebView 上にクライアントサイドの HTML テンプレートを描画することで実装しているそうで、これも実際に動作しているところをデモしていただきました。

##### Laurent さんへの Q&amp;A コーナー

最後に 20 分ほど Laurent さんへの質問を受け付けるコーナーを設けました。

Q. 現在 C++ で実装されたライブラリは RubyMotion からは直接扱えないが、将来的にサポートする予定は？
: A. サポートする予定はない。Objective-C でラッパーを作って RubyMotion から呼ぶようにしてほしい。

Q. RubyMotion で static library を作ることができるそうだが、その方法についてのドキュメントはあるのか？
: A. 現在は forum に投稿したメールやブログのエントリしかドキュメントと呼べる物は無いが、チュートリアルを現在準備中である。

Q. RubyMotion ではなぜ ARC を使わずにメモリ管理を独自に実装しているのか？
: A. ARC は Objective-C のコンパイラの機能であり、そもそも RubyMotion では使えない。またコンパイル時ではなく実行時にメモリ管理をすることによって、例えば循環参照を検出するなどの面白いことができると思う。

Q. iOS がバージョンアップしたときに RubyMotion ではどのような対応をするのか？
: A. RubyMotion を iOS のバージョンアップに対応させることは容易であり、iOS の新しいバージョンが出た当日に対応するようにしている。

Q. RubyMotion のユーザはどのくらいいるのか？
: A. アクティブユーザの正確な数はわからないが、数千人くらいである。今年いっぱいで 1 万ユーザに達すると思われる。また RubyMotion で作られたアプリケーションがどのくらいストアでリリースされているのかという点についても正確には把握していないが、週に 1 つくらいの頻度ではリリースされているようだ。

Q. 円安により RubyMotion が手に入りにくくなってしまったが、今後割引などは予定されているか？
: A. RubyKaigi 割引で RubyKaigi 期間中は 15% 引きにする。

### 参加レポートなどのまとめ

* [ツイートまとめ (Togetter)](http://togetter.com/li/510492)
* [Ustream](http://www.ustream.tv/channel/rubymotion-kaigi-2013)
* ブログ記事 (ありがとうございます！)
  * [RubyMotion Kaigi 2013 と簡単に Objective-C を実行する方法 - Watson's Blog](http://watson1978.github.io/blog/2013/06/03/rubymotion-kaigi-2013/)
  * [RubyMotion KaigiでLTしてすべりました #rubymotionjp | ましましブログ](http://blog.ainam.me/2013/05/30/rubymotion-kaigi-misawa-suberu/)
  * [RubyMotion Kaigi 2013でLTをしてきました - mog2tech](http://mog2dev.hatenablog.com/entry/2013/05/31/014938)
  * [RubyMotion Kaigi 2013でしゃべってきました - mfks17's diary](http://d.hatena.ne.jp/mfks17/20130530/1369878790)
  * [RubyMotion Kaigi 2013に参加してきました - rochefort's blog](http://rochefort.hatenablog.com/entry/2013/05/30/004541)


### その後の RubyMotion コミュニティの盛り上がり

継続的に開催されている RubyMotion 関連のコミュニティ / 勉強会は従来は [RubyMotion もくもく会](http://connpass.com/series/130/) しかありませんでしたが、この RubyMotion Kaigi 2013 の後に 2 つのコミュニティが立ち上がりました。

* [RubyMotion もくもく会 in Osaka](http://connpass.com/event/2731/) (リンク先は第 2 回) は大阪で開催されているもくもく会です。
* [RubyMotionTokyo](http://rubymotion-tokyo.doorkeeper.jp) は都内で隔週で meetup を実施しているコミュニティです。


また、業務で RubyMotion を使っている人も徐々に増えて来ているらしく、会場の参加者のみなさんに「RubyMotion で仕事をしている人はいますか？」と問いかけたところ、5&#12316;6 人の方が手を挙げていらっしゃいました。

コミュニティの盛り上がりと共に開発環境やライブラリが充実し、RubyMotion を使ってたくさんの素晴らしいアプリケーションが開発されることを望みます。

最後に、発表や当日スタッフをしていただいた皆様をはじめ RubyMotion Kaigi 2013 にご協力いただいた全ての皆様、そして参加者の皆様に感謝の言葉を述べることで本レポートのまとめとしたいと思います。

ありがとうございました。

### 著者について

海老沢 聡 ([@satococoa](https://twitter.com/satococoa))

[株式会社イグニス](http://1923.co.jp) 所属。

[P4D デザイナー向けプログラム部](http://prog4designer.github.io) や [RubyMotion JP](http://rubymotion.jp) をやっています。


