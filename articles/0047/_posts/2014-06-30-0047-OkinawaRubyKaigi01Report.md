---
layout: post
title: RegionalRubyKaigi レポート (44) 沖縄 Ruby 会議 01
short_title: RegionalRubyKaigi レポート (44) 沖縄 Ruby 会議 01
created_on: 2014-06-30
tags: 0047 OkinawaRubyKaigi01Report regionalRubyKaigi
---
{% include base.html %}


## RegionalRubyKaigi レポート (44) 沖縄 Ruby 会議 01

書いた人: [@cota2n](https://twitter.com/cota2n), [@hanachin_](https://github.com/hanachin), [@kimihito_](https://twitter.com/kimihito_)

### はじめに

Okinawa.rb の発起人である[@yasulab](https://twitter.com/yasulab)さんが中心となって、沖縄初の「沖縄Ruby会議01」が開催されました。

### 開催概要
: ![okrk-all.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/okrk-all.jpg)

開催日
: 2014-03-01(土) 13:00 - 18:00

開催場所
: 琉球大学 工学部１号館 大教室 322 (本会場) &amp; 321 (サテライト会場)

主催
: [Okinawa.rb](https://www.facebook.com/groups/okinawarb/) Ryudai.rb [Ryukyu.rb](https://www.facebook.com/groups/ruby.okinawa/)

参加者
: およそ 100 名

資料
: [公式ページ](http://regional.rubykaigi.org/okrk01)

公式タグ
: [okrk01](http://b.hatena.ne.jp/search/tag?q=okrk01&users=1)

公式ハッシュタグ
: [#okrk01](http://twitter.com/search?q=%23okrk01)

沖縄 Ruby 会議 01 ツイートまとめ
: [http://togetter.com/li/636273](http://togetter.com/li/636273)

## ゲスト講演1

### 『Change Your World』([動画(12:33頃から)](http://www.ustream.tv/recorded/44345761))

#### [@yukihiro_matz](https://twitter.com/yukihiro_matz)

![matz.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/matz.jpg)

初沖縄のまつもとさん、首里城がプリントされたTシャツを着て登壇されました。発表前には沖縄にある炭酸飲料、ルートビアの話をなさったりと、沖縄を満喫されたようでした。会場は満員で立ち見が出るほどでした。

前夜祭のときから、「すごくエモい話をしようと思っている」とおっしゃっていましたが、本当に大変エモい話でした。

まず「世界はソフトウェアで動いている」と、まつもとさんから見た世界の話をされていました。

そこから「ガリレオ温度計のように、みんな固有の魂の浮力をもっている」、「魂の浮力がちょうどいいところにいるときに幸せになれる」といった話にはじまり、
スーツで出社する会社にジーンズで出社したら誰も何も言わなかったこと、自らがロシア語の関数名やコメントで困った経験から、日本語のドキュメントを英語でも書いたことなど、まつもとさんが自ら自分の世界を変えてきた話をされていました。

最後には「あなたはあなたの世界を変えることができる」、「勝手にルールを変えることで幸せになる」とおっしゃり、僕たちが変えられないと思っている世界は意外と変えられるよ、というメッセージが伝わってきました。

上記の動画のリンクは、途中までしか録画されていません。

当日話を聞けなかった方は、来場者のブログからまつもとさんの話のエモさが伝わってくるかもしれませんね。

* [沖縄Ruby会議01に参加しました](http://little-braver.com/366/)
* [「沖縄Ruby会議０１」に参加してきたよ？ - uranariのブログ](http://uranari.hatenablog.com/entry/2014/03/02/030546)


## ゲスト講演2

### 『Rubyを使って3人/日でアプリをリリースしよう』([動画1](http://www.ustream.tv/recorded/44347244)[動画2](http://www.ustream.tv/recorded/44347759))

#### [@masuidrive](https://twitter.com/masuidrive)
: ![masuidrive.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/masuidrive.jpg)

風呂グラマーとして有名な@masuidriveさん。[wri.pe](https://wri.pe/)を作る過程、ローンチ後の運用部分などのお話を伺いました。「自分が普段使うものを作ろう」と、メモアプリであるwri.peの基本機能を3日で実装したそうです。プレスを打つ、運用、顧客対応などの広い範囲を経験できたことから、何か小さなものでもいいからプロダクトを作ってみることを薦めていました。

※沖縄Ruby会議実施後にwri.peのソースコードが公開されたようです。[wri.peのソースコードを公開しました。 | @masuidrive blog](http://blog.masuidrive.jp/2014/03/31/open-wri-pe/)

## Lightning Talks 1 + Sponsored Session ([動画](http://www.ustream.tv/recorded/44348324))

### 『Rubyによるバッチ業務のストリーム処理化の設計と実装』([資料](https://speakerdeck.com/bash0c7/design-and-implement-batch-stream-processing-application-for-ruby))

#### [@bash0C7](https://twitter.com/bash0C7)

![bash07.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/bash07.jpg)

ログ収集ツールとして注目される[fluentd](http://fluentd.org)を使い、バッチ業務をストリーム処理化する手法を紹介して頂きました。
通常はログ収集のみに使われることが多いfluentdですが、入出力のプラグインを自作することで進捗確認のツールとして使用することが出来るそうです。
プラグインは[RubyGems](https://www.ruby-lang.org/ja/libraries/)の形式で導入することが出来るため、手軽に機能を追加出来るとおっしゃっていました。

### 『Emacsの普通の使い方』([資料](http://kinjo.github.io/okrk01/#/title))

#### [@libkinjo](https://twitter.com/libkinjo)
: ![libkinjo.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/libkinjo.jpg)

Rubyではirbやpryを使って対話的にプログラムを記述することが出来ますが、@libkinjoさんはEmacsのscratchバッファでelispと対話するようにRubyとも対話したいと考えました。
comint.elとinf-ruby.elを使ってEmacsバッファ内でRubyのコードを実行し、結果を受け取るデモを実際に動かして頂きました。

「scratchバッファはEmacsと対話する聖域（サンクチュアリ）」や「Emacsはロマンの積み木」などカッコいい名言で会場を盛り上げて頂きました。

### 『RyukyuFrogsとLexues Academyの話』

#### 山崎暁 ([株式会社レキサス](http://lexues.co.jp))

![yamazaki.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/yamazaki.jpg)

沖縄Ruby会議のスポンサーをしていただいた[株式会社レキサス](http://www.lexues.co.jp/)の山崎さんから、沖縄県内の学生を育成するプロジェクト[RyukyuFrogs](http://www.ryukyu-frogs.com)と[Lexues Academy](http://academy.lexues.co.jp)をご紹介していただきました。後述する学生LT枠では2つの育成プロジェクトに参加した学生たちも登壇していました。

## 沖縄県内コミュニティの活動紹介([動画](http://www.ustream.tv/recorded/44349362))

沖縄のRubyコミュニティだけでなく、県内で活動するコミュニティ紹介のLTも行いました。
ものづくりのコミュニティから、エンジニアの集うシェアハウスまでの計5つのコミュニティの発表を行いました。
ここでは各コミュニティのリンク、当日の発表資料、発表者を紹介します。

* [Ryukyu Rubyist Rookies](https://www.facebook.com/groups/ruby.okinawa/) [資料](http://www.slideshare.net/repserc/ryukyu-rubyist-rookies)


* [Ryudai.rb](http://lingr.com/room/ryudairb)


* [Okinawa.rb](https://www.facebook.com/groups/okinawarb/)


* [ハッカーズチャンプルー](http://hackers-champloo.org/) [資料](http://www.slideshare.net/KoichiroNishijima/20140301lt)


* [ギークハウス沖縄](http://text.geeoki.com)


* [gFab](http://gfab-okinawa.github.io/)


## Lightning Talks 2 ([動画](http://www.ustream.tv/recorded/44350011))

### 『rcairoでものづくり』([資料](http://www.slideshare.net/mgwsuzuki/ruby-kaigi-rcairo))

#### [@mgwsuzuki](https://twitter.com/mgwsuzuki)
: ![rcairo.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/rcairo.jpg)

2Dグラフィックス用のCライブラリである[cairo](http://cairographics.org/)をRubyでバインディングした[rcairo](https://github.com/rcairo/rcairo)を使って、マイコンボードケースを自動設計を行うプログラムをRubyで作成し、実際にケースを作ってみたという発表でした。今後はGitHubに箱の自動設計のプログラム公開し、パラメータをPull Requestすることで簡単にマイコンボードなどのケースを作れるようにしたいとおっしゃっていました。

### 『Rubyに何かをしゃべらせる』

#### [Yoichi Kobayashi](http://www.linkedin.com/pub/yoichi-kobayashi/89/205/461)

![talk_ruby.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/talk_ruby.jpg)

[Twilio](http://www.twilio.com/)とRubyを使ってオヤジギャクを喋るプログラムを作成し、実際にオヤジギャクが流れる電話番号を取得、公開して聴衆の皆さんにかけてもらうデモを披露していただきました。今後は「電話口から流れるオヤジギャクが本当に面白いか」のアルゴリズムを考えたいとのことでした。発表の所々にオヤジギャクを散りばめつつ、何をもって面白いのかを真面目に考察、発表する姿に会場は大いに盛り上がりました。

### 『組み込みにもiOSにもrubyで幸せ（仮）』([資料](http://www.slideshare.net/shumach217/ruby01-31912722))

#### [@shumach217](https://twitter.com/shumach217)
: ![happy_ruby.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/happy_ruby.jpg)

組み込み開発で行われる実機テストを手作業・目視確認からRSpec + Turnipを使った自動化に変更したお話から、iOSの開発においても同様なアプローチができるのではないかと考え、turnipの記述でiOSのデバイスをリモート操作できるテストフレームワークを作成中とのことでした。

## Lightning Talks 2.5 + Sponsored Session

### 『きたのくにからこんにちぬー！』([資料](http://www.slideshare.net/AsamiImazu/okrk01-kitanokunikarakonnnichinu)) ([動画1](http://www.ustream.tv/recorded/44351500) [動画2](http://www.ustream.tv/recorded/44351537))

#### [@PUPRL](https://twitter.com/PUPRL)

![nuruby.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/nuruby.jpg)

北海道からお越しの[@PUPRL](https://twitter.com/PUPRL)さんは、「和室でぬるくRubyをもくもくする」[ぬRuby](http://nuruby.org/)の紹介と、地域Ruby会議に参加することの良さについて語ってくださいました。ぬRubyの魅力がしっかり伝わったようで、LT後はぬRubyに参加したいとの声が上がっていました。

### 『The Payment System by Ruby』([動画](http://www.ustream.tv/recorded/44351293))

#### [@sowawa](https://twitter.com/sowawa)
: ![webpay.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/webpay.jpg)

開発者向けクレジット決済サービス、[WebPay](https://webpay.jp/)を開発しているウェブペイ株式会社のスポンサーセッションでは、Rubyでセキュアなプログラミングを行う際の注意点を紹介していただきました。シンボルはGCされないので、ユーザー入力をto_symするとメモリリークが起きてしまう問題が起きてしまうという例を取り上げ、シンボルの扱いに注意するようにとのことでした。5分という短いセッションながらも内容が濃いお話でした。

沖縄Ruby会議後、[SymbolをGCするパッチがCRubyに取り込まれ](https://bugs.ruby-lang.org/issues/9634)、この問題は解決されたようです。

## Lightning Talks 学生枠 ([動画](http://www.ustream.tv/recorded/44351656))

学生を募集対象としたLT枠も設け、計6名学生が登壇しました。
ほとんどが作成したWebサービスの紹介であるため、サービス・発表資料のリンクと発表者の紹介のみを掲載します。

* 『[SharePla](http://sharepla.herokuapp.com)』(発表者:[@kanpe777](https://twitter.com/kanpe777) [@salvare234](https://twitter.com/salvare234))


* 『[琉大図書館にRuby本を！](http://www.slideshare.net/_siman/ruby-31905851)』(発表者:[@_simanman](https://twitter.com/_simanman))


* 『[Mac Friends](http://macfriends.net)』([資料](https://speakerdeck.com/enkw/number-macfriends-in-okinawa-ruby-kaigi) 発表者:[@enkw_](https://twitter.com/enkw_))


* 『[instag](http://instag.herokuapp.com)』(発表者:[@nanophate](https://twitter.com/nanophate))


* 『[Once-Tech](http://once-tech.net)』(発表者:[@motikan2010](https://twitter.com/motikan2010))


## Lightning Talks 3 ([動画](http://www.ustream.tv/recorded/44352072))

### 『RubyKaigiの話』([資料](https://speakerdeck.com/kakutani/all-about-ruby-no-kai-in-okinawa-rubykaigi-01))

#### [@kakutani](https://twitter.com/kakutani)

![kakutani.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/kakutani.jpg)

[日本Rubyの会](http://ruby-no-kai.org/)からお越しの[@kakutani](https://twitter.com/kakutani)さん。2014年9/18から9/20に行われる[RubyKaigi 2014](http://rubykaigi.org/2014)と、2015年4/9から4/11に行われる[RubyKaigi 2015](http://rubykaigi.org/2015)の告知をしてくださいました。

日本Rubyの会ではRubyistの活動を支援しており、[るびま](http://magazine.rubyist.net/)、[るりま](http://docs.ruby-lang.org/ja/)、[Regional RubyKaigi](http://regional.rubykaigi.org/)や[Rails Girls](http://railsgirls.jp/)などの開催の支援しているそうです。

最後に「大事なのは活動、みなさんがコミュニティだ」ということで、今後も沖縄でRubyistたちによる活動を続けていってほしいとのことでした。

### 『るびまの話』

#### [@gunjisatoshi](https://twitter.com/gunjisatoshi)
: ![gunjisatoshi.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/gunjisatoshi.jpg)

沖縄のRubyistもお世話になっている、[Rubyist Magazine](http://magazine.rubyist.net/)、略称「るびま」の話。
なんと今年の9月に10周年になるそうです。

* Rubyist Magazineの編集プロセス
* あなたにも出来る貢献


についてお話してくださいました。

進捗管理は[GitHub Issues](https://github.com/rubima/rubima/issues)をWatchすると編集部がどんなことをやっているか
見ることが出来るらしいです。筆者も早速Watchしました!

貢献方法としては、

* 記事を読んでフィードバックを送る
* 記事を投稿する
* 企画の提案をする
* システム(Hiki)の不具合を直す
* 編集者コミュニティへ参加する


などなどいろいろな貢献方法があるそうです。

### 『1 個の Pull Request の Diff を 200 行以下にしたら捗った話』([資料](https://speakerdeck.com/kbaba1001/pull-requestfalsediffwo200xing-yi-xia-nisitarabu-tutahua))

#### [@kbaba1001](https://twitter.com/kbaba1001)

![kbaba1001.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/kbaba1001.jpg)

[@kbaba1001](https://twitter.com/kbaba1001)さんの「小さいPull Request最高!!」話でした。
小さいPull Requestだと、「毎日PRが出すことができて楽しい、レビューの質があがる、マージが速い!」と楽しそうに語っていました。
部分的にPullRequestを出すコツを具体的に挙げられており、大変参考になりました。

### 『カスタムマッチャーを流行らせたい』([資料](https://speakerdeck.com/moro/suggestion-for-rspec-custom-matcher))

#### [@moro](https://twitter.com/moro)
: ![moro.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/moro.jpg)

RSpecのカスタムマッチャーで、アプリケーションロジックをテストするための語彙を作ると、アプリケーションロジックをテストしやすくなる!楽しくなる!という話でした。

真偽値を返す  match を書くだけで簡単にカスタムマッチャーが定義出来るので、積極的に使っていきたいですね。

### 『1,000,000yen Salesforce1 Platform Mobile Hack Challenge』

#### [@ayumin](https://twitter.com/ayumin)

![ayumin.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/ayumin.jpg)

るびま掲載時には応募締め切りが終了していますが、[Salesforce1 Platform モバイル開発チャレンジ](http://events.developerforce.com/ja/contests/challengejapan2014)の開催告知でした。

## ゲスト講演3 ([動画](http://www.ustream.tv/recorded/44352699))

### 『mrubyを使うポイント』

#### [田中 和明 准教授](http://www.kyutech.ac.jp/professors/iizuka/i4/i4-2/entry-714.html)
: ![mruby.jpg](https://raw.githubusercontent.com/kimihito/rubima/img-size500/articles/draft/regional_rubykaigi_report/okinawarubykaigi01_hiki/mruby.jpg)

オープンソースでの開発がすすむ軽量rubyこと[mruby](http://www.mruby.org/)を使うポイントについて講演していただきました。

組み込み開発では主にCが常用されていますが、生産性向上のためにRubyで開発したい！というのがmrubyが生まれた理由のひとつです。

RubyはCなどに比べると実行速度が遅いため組み込み開発には向かないとされていますが、実行速度が速ければいいというわけではなく、一定時間内に処理が完了することを保証するリアルタイム性が満たせていることが組み込み開発では重要です。

mrubyではRubyの強みであるGCによるメモリ管理を生かしつつ、リアルタイム性を両立するため、GCが一定時間以内に完了する「インクリメンタルGC」を採用しているとのことでした。

mrubyのコードはRiteBinaryと呼ばれるバイトコードに変換され、仮想マシン上でプログラムを実行します。
そのため書くハードウェア向けの仮想マシン作ってしまえば、mrubyプログラムをPC上でもマイコン上でも全く同じコードを動かすことが可能となります。

また田中先生が大学で行っている研究として、mrubyに特化したハードウェアの開発の紹介がありました。
研究の例としてmrubyのメソッド呼び出し時に頻繁に使われるハッシュ関数をLSIチップ上で実装し、文字列操作を行うプログラムの性能を20%上昇させることに成功したとのことでした。

実際にデモを交えながらの講演の様子は、上記の動画リンクでも見ることが可能です。


