---
layout: post
title: RegionalRubyKaigi レポート (66) ながらRuby会議01
short_title: RegionalRubyKaigi レポート (66) ながらRuby会議01
tags: 0066 regionalRubyKaigi NagaraRubyKaigi01Report
post_author: ながらRuby会議 実行委員会
created_on: <!-- リリース予定日 yyyy-mm-dd -->
---
{% include base.html %}

## RegionalRubyKaigi レポート (66) ながらRuby会議01

- 開催日：2025年9月6日
- 開催場所：うかいミュージアム 四阿（あずまや）
- 主催：nagara.rb 実行委員会
- 後援・会計協力：一般社団法人 日本Rubyの会
- 公式サイト：<https://regional.rubykaigi.org/nagara01/>
- 公式ハッシュタグ：#nagara01

---

書いた人：ながらRuby会議01 実行委員会

2025年9月6日、岐阜県岐阜市の長良川うかいミュージアムにて、ながらRuby会議01を開催しました。岐阜市で毎月開催されている[nagara.rb](https://nagara-rb.connpass.com/)としては初めての地域Ruby会議で、当日は約40名の参加者（スタッフ含め約60名弱）が集まりました。

会場の長良川うかいミュージアムは、1300年以上続く長良川鵜飼の文化を伝える施設です。「四阿（あずまや）」と呼ばれる会場からは長良川を望むことができ、参加者からも「こんな場所でRubyの話ができるなんて」と好評でした。

このレポートでは、当日のセッションの様子、懇親会、そしてアフターイベントの鵜飼観覧まで、ながらRuby会議01の一日をお届けします。

## OPENING

![]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image01.jpg)

主催者の一人である[ころちゃん（@corocn）](https://x.com/corocn)のオープニングトークで、ながらRuby会議01が幕を開けました。

nagara.rb は清流・長良川のほとりで、言語を問わずもくもくとコーディングを楽しむコミュニティです。月1回のもくもく会を続けてきて、このながらRuby会議01をもって **100回目**の節目を迎えました。「nagara.rbが今回で100回目を迎えました！」という発表があると、会場から大きな拍手が湧き起こりました。

## refinementsのメソッド定義を4000倍速くした話

- 発表者：alpaca-tcさん  
- 資料：[refinementsのメソッド定義を4000倍速くした話](https://speakerdeck.com/alpacatc/refinementsnomesotudoding-yi-wo4000bei-su-kusitahua)

![]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image02.jpg)

業務でRubyをバージョンアップしたところアプリの起動が極端に遅くなり、その原因を突き止めてRuby本体を修正するまでの道のりが語られました。

### 異変に気づく

Ruby3.2から3.3へアップデートした後、Railsアプリケーションの起動に数十秒もかかるようになったそうです。プロファイラ [vernier](https://github.com/jhawthorn/vernier) で調べてみると`Module#refine`の呼び出し箇所で処理時間が約 4000 倍に膨れ上がっていることがわかりました。

`Module#refine` はRuby2.0で導入された機能で、モンキーパッチの影響範囲を`using`を宣言したスコープ内に限定できる仕組みです。

### 原因を探る

調査を進めると、Ruby3.3で追加された`rb_clear_all_refinement_method_cache()`という処理が原因だと判明しました。これはrefineに関連するメソッドキャッシュをクリアする処理で、バグ修正のために導入されたものでしたが、結果としてパフォーマンスが大きく低下していました。

alpaca-tcさんの環境ではObjectSpaceに約70億ものオブジェクトが存在しており、キャッシュが無効化されるたびに膨大な探索コストが発生していたのです。

### Rubyを直す

refine専用のキャッシュ領域を設ける方針で改善に着手しました。RubyはC言語で実装されているため慣れない部分も多かったそうですが、ChatGPTや[rubyhackchallenge](https://github.com/ko1/rubyhackchallenge)を頼りに実装を進め、最終的に[プルリクエスト](https://github.com/ruby/ruby/pull/13077)がマージされました。

### 発表から得た学び

- パフォーマンス改善の基本は「計測→再現→改善」
- AIやコミュニティの力を借りれば、普段アプリケーションを書いているエンジニアでもRuby本体に貢献できる
- 過去のRubyKaigiで聞いたGCやセグメンテーションフォールトの話が、実際の問題解決に役立った

## 知っているようで知らないrails newの世界

- 発表者：luccafortさん  
- 資料：[知っているようで知らないrails newの世界](https://speakerdeck.com/luccafort/the-world-of-rails-new-you-think-you-know-but-dont)

![]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image03.jpg)

Railsを使ったことがあれば誰もが実行する`rails new`。でも、その裏で何が起きているかを説明できる人は少ないのではないでしょうか。このトークでは、コマンドの内部構造を丁寧に解き明かしていきました。

### なぜこのテーマを選んだか

luccafortさんは[関西Ruby会議 08](https://regional.rubykaigi.org/kansai08/)のオーガナイザーを務めた経験から、「個人開発以外にも技術者として成長する道があるはず」と考えるようになったそうです。普段何気なく使っているコマンドの中身を理解することも、その一つの方法だと気づいたといいます。

### コマンドの流れを追う

`rails new` は大まかに次の順で処理が進みます。

1. コマンドの解析
2. ジェネレータの初期化
3. オプションの処理
4. ディレクトリの作成
5. ファイルの生成
6. `bundle install` の実行

実行すると、まず`Rails::Command`が引数を解析し、`Rails::Command::ApplicationCommand` を呼び出します。その後`Rails::Generators::AppGenerator.start`で各種ファイルが生成され、最後に`bundle install`が走る——という流れです。

### 仕組みを知る意味

「仕組みを知らなくてもRailsは動く。でも、中身を理解すると新しい発想が生まれる」という主張には説得力がありました。自作のジェネレータを作りたい人、テンプレートをカスタマイズしたい人にとって、最初の一歩を踏み出すきっかけになる発表でした。

## Ruby × iOSアプリ開発：共に歩んだエコシステムの物語

- 発表者：Tomoki Kobayashiさん  
- 資料：[Ruby × iOSアプリ開発](https://speakerdeck.com/temoki/rubyxiosapurikai-fa-gong-nibu-ndaekosisutemunowu-yu)

![]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image04.jpg)

普段はiOSエンジニアとして活動されているKobayashiさんが、iOS開発とRubyの意外なつながりについて歴史をたどりながら紹介してくれました。

### かつてのiOS開発

2010年頃のiOS開発では、サードパーティライブラリの導入が大きな悩みの種でした。ライブラリごとにインストール方法が異なり、Xcode のビルド設定もAppleの非公開仕様に依存していたため、管理が非常に煩雑だったそうです。

### CocoaPodsがもたらした変化

この問題を解決するために登場したのが[CocoaPods](https://cocoapods.org/)です。依存関係の解決からダウンロード、Xcodeプロジェクトへの統合までを自動化してくれるパッケージマネージャーで、RubyGemsやBundlerを手本に設計されました。実装言語もRubyです。

[nomad-cli](https://nomad-cli.com/)や[fastlane](https://fastlane.tools/)など、その後に登場したツールも Rubyの影響を強く受けています。当時のiOS ツール開発者にはRubyやRailsの経験者が多かったことが背景にあるようです。

### Rubyへの恩返し

CocoaPods で使われていた依存関係リゾルバ [Molinillo](https://github.com/CocoaPods/Molinillo) は、後にBundlerやRubyGemsにも取り込まれました。iOSコミュニティからRubyコミュニティへの貢献です。

### 変わりゆく関係

2014年にSwiftが登場し、Appleが公式のパッケージマネージャーを提供するようになると、iOS開発におけるRubyの役割は徐々に小さくなっていきました。Bundler2.4ではMolinilloも引退しています。

二つのエコシステムが互いに影響を与え合いながら成長してきた歴史を知ることができる、貴重な発表でした。

## Ruby Mini Language 作成記 〜ハンズオンで学ぶインタプリタの世界〜

- 発表者：haruguchiさん  

![]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image05.jpg)

Rubyでインタプリタを自作した経験をもとに、字句解析・構文解析・評価といった処理の流れを解説してくれました。

### 作ろうと思ったきっかけ

RubyKaigi2025に参加したとき、言語処理系のセッションがさっぱりわからなかったそうです。「周りの人も『わからない』と言っていたけれど、自分の『わからない』とは次元が違う気がした」——この率直な言葉に、会場からは共感の笑いが起きました。

そこで、理解を深めるために自分でインタプリタを作ってみることにしたといいます。

### 少しずつ育てる

目標は「FizzBuzzが動くこと」。まずは単純な二項演算から始め、機能を追加するたびにレキサーや構文解析の仕組みを拡張していきました。if文の条件式を `< >` で囲むようにするなど、オリジナルの文法を取り入れて楽しみながら進めたそうです。約5ヶ月でFizzBuzzが動くところまで到達しました。

### ライブデモ

発表中にはその場でコードを動かすデモがありました。最初はTypoで動かず会場がざわつきましたが、参加者と一緒に一行ずつ確認しながら修正し、FizzBuzzが正しく出力されると大きな拍手が起こりました。

今後は配列やハッシュも実装してみたいとのこと。言語処理の世界への入り口を見せてくれる発表でした。

## 💡Ruby（ひかるびー） 川辺で灯すPicoRubyからの光

- 発表者：bashさん  
- 資料：[💡Ruby（ひかるびー） 川辺で灯すPicoRubyからの光](https://speakerdeck.com/bash0c7/ruby-chuan-bian-dedeng-supicorubykaranoguang)

![]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image06.jpg)

組み込み向けの軽量なRuby実装「PicoRuby」を使い、LEDを光らせるところから始めて、センサーや音声認識まで広げていく過程を紹介してくれました。

### なぜ「光」なのか

光を灯すという行為は、人類が太古から続けてきた営みです。Rubyコミュニティでも、カンファレンスで自作キーボードやマイコンのLEDが輝く光景を目にすることがあります。

bashさん自身、組み込み入門の定番「Lチカ（LEDを光らせる）」で一度挫折しかけた経験があるそうです。その経験を踏まえ、Lチカを出発点にして段階的に学べる道筋を提示したいと考えたといいます。

### 光らせる、動かす、応答する

最初に使った機材は「[ATOM Matrix](https://www.switch-science.com/products/6260)」という小さな開発ボードです。初期化後に無限ループを回し、その中でLEDを制御する「Super Loop Architecture」と呼ばれる構成で実装しました。

単純な点灯から始めて、ランダム点灯、加速度センサーとの連携、棒状LEDの制御、MIDIシンセサイザーとの接続、音声認識による応答へと発展していく様子がデモで示されました。ライトセーバーのように光る棒を振り回す場面では、会場から歓声が上がりました。

### Rubyで灯す喜び

「何かの役に立つ」だけがRubyの使い道ではない。暗闇に光を灯すという原始的な喜びを、Rubyで味わってほしい——そんなメッセージが伝わってくる発表でした。セッション後にはパーツの頒布もあり、すぐに試せる機会が用意されていました。

## 365日のOSS開発を続ける舞台裏

- 発表者：Koichi ITOさん  
- 資料：[365日のOSS開発を続ける舞台裏](https://speakerdeck.com/koic/write-code-every-day)

![]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image07.jpg)

RuboCopコミッターとして毎日OSSに関わり続けているKoichi ITOさんが、開発環境の整え方や継続のコツを共有してくれました。

### 仕事とOSSを地続きにする

テーマは「業務のコードとOSSのコードを同じように扱えるようにする」こと。リポジトリ管理には [ghq](https://github.com/x-motemen/ghq) を、gem のソースコードを手元に持ってくるには [gem-src](https://github.com/amatsuda/gem-src) を使っているそうです。

リポジトリが増えても素早く移動できるよう、[peco](https://github.com/peco/peco) や [fzf](https://github.com/junegunn/fzf) でインクリメンタル検索できる環境を整えているとのこと。

### git の流儀を統一する

興味深かったのは、Forkしたリポジトリを常に `origin` に設定し、Fork 元を `upstream` にするという運用です。こうしておけば、コミット権のあるリポジトリでもないリポジトリでも、`git push origin HEAD` という同じコマンドで済みます。

### 続けるための工夫

心構えとして挙げられたのが「ソーシャルコーディング」という考え方。コードだけでなく、発言やレビューも含めて恥ずかしくない振る舞いを心がけるというものです。また、OSS は地球規模の非同期開発であり、PR を出すときはコードだけでなく背景や意図を文章で伝えることが大切だと強調されていました。

ゲーミフィケーションの話も印象的でした。海外カンファレンスに参加した際、その土地のタイムゾーンでコミットして「ご当地タイムスタンプ」を集めているそうです。楽しみながら続ける仕組みづくりの一例として、会場の笑いを誘っていました。

## スポンサーセッション

### 株式会社スタメン

![]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image08.jpg)

最初のスポンサーセッションは、株式会社スタメン様。

### 株式会社SmartHR

![]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image09.jpg)

2つ目のスポンサーセッションは、株式会社SmartHR様。

### 株式会社Leaner Technologies

![]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image10.jpg)

最後のスポンサーセッションは、株式会社Leaner Technologies様。

## 日本Rubyの会の紹介

![]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image11.jpg)

日本Rubyの会の理事である島田さんによる、日本Rubyの会の紹介がありました。

## CLOSING

![CLOSING]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image12.jpg)

主催者の一人であるうたろうさんのクロージングトークです。

開催までの経緯、懇親会の案内がありました。

最後にスタッフ・参加者合わせて集合写真を撮りました。

![集合写真]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image13.jpg)

## 懇親会

![懇親会]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image14.jpg)

懇親会では、地元岐阜のお菓子と日本酒、各種ドリンク類で盛り上がりました。
小規模な地域Ruby会議ならではのアットホームな雰囲気の中、参加者同士の交流が活発に行われました。

## アフターイベント：鵜飼観覧

![鵜飼観覧1]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image15.jpg)
![鵜飼観覧2]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image16.jpg)

懇親会の後には、アフターイベントとして[長良川鵜飼](https://www.ukai-gifucity.jp/)の観覧がありました。

## 会場の様子

![会場の様子]({{base}}{{site.baseurl}}/images/0066-NagaraRubyKaigi01Report/image17.jpg)

長良川うかいミュージアムは、長良川沿いに位置する素敵な施設でした。

会場内にはスポンサーノベルティや展示などもありました。自然と人々の生活が調和した場所で、Rubyについて語り合う—、そんな贅沢な時間を過ごすことができました。

## おわりに

ながらRuby会議01は、nagara.rb 100回目の節目を飾る記念すべきイベントとなりました。

ご参加いただいた皆さま、スポンサーの皆さま、そして日本Rubyの会の皆さま、本当にありがとうございました！

## 著者紹介

- **HANDLE1**
  - ながらRuby会議01 運営。
  - GitHub: GITHUB_URL1

- **HANDLE2**
  - ながらRuby会議01 運営。
  - GitHub: GITHUB_URL2
