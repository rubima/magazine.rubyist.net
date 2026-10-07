---
layout: post
title: RegionalRubyKaigi レポート (NUM) 関ケ原 Ruby 会議 01
short_title: RegionalRubyKaigi レポート (NUM) 関ケ原 Ruby 会議 01
tags: 0066 SekigaharaRubyKaigi01Report regionalRubyKaigi
post_author: うさみ
created_on: 2026-09-15
---
{% include base.html %}

## はじめに

時に令和八年<ruby><rb>皐月</rb><rp>(</rp><rt>さつき</rt><rp>)</rp></ruby>三十日、日辰は<ruby><rb>甲辰</rb><rp>(</rp><rt>きのえたつ</rt><rp>)</rp></ruby>。  
天下分け目の古戦場たる<ruby><rb>濃州</rb><rp>(</rp><rt>のうしゅう</rt><rp>)</rp></ruby>関ケ原の地において、『関ケ原 Ruby 会議零一』の陣ぞ敷かれける。  
某、此度の戦に馳せ参じたる顛末をば、<ruby><rb>茲</rb><rp>(</rp><rt>ここ</rt><rp>)</rp></ruby>に<ruby><rb>言上</rb><rp>(</rp><rt>ごんじょう</rt><rp>)</rp></ruby><ruby><rb>仕</rb><rp>(</rp><rt>つかまつ</rt><rp>)</rp></ruby>らん。

これより先は、令和の世の言葉にてお目通し願うこと、平にご容赦願い奉る。

*(2026 年 5 月 30 日土曜日に岐阜県関ケ原町で開催された『関ケ原 Ruby 会議 01』の参加者レポートをお届けいたします。以後は現代語で失礼いたします)*

### 概要

開催日
: <time datetime="2026-05-30">2026 年 5 月 30 日 (土)</time>

会場
: 岐阜県不破郡関ケ原町 / 関ケ原ふれあいセンター

公式サイト
: <https://regional.rubykaigi.org/sekigahara01/>

公式ハッシュタグ
: `#sekigahara01`

主催者
: 関ケ原 Ruby 会議チーム

### 関ケ原 Ruby 会議 01 とは

[関ケ原 Ruby 会議 01](https://regional.rubykaigi.org/sekigahara01/) 公式サイトでは以下のように説明されています。

> **天下分け目の地域 Ruby 会議**  
> 関ケ原 Ruby 会議 01 は、天下分け目の地「関ケ原」で開催される地域 Ruby 会議です。  
> 歴史ある古戦場で、新たな Ruby の歴史を刻みましょう。

地域 Ruby 会議は各地の Ruby コミュニティ主導で開催されることが基本ですが、このイベントは関西 Ruby 会議の ydah さん、東京 Ruby 会議 12 の osyoyu さん、nagara.rb の corocn さんらのチームによる変則的な運営チームによって企画されました。

> 関西 Ruby 会議 08 のオフィシャルパーティにて、osyoyu さんと話をしていたときのことでした。「関西と関東の地域 Ruby コミュニティ間の交流ができる場があったら面白いよね。というか東西戦やろう！！」という話になりました。
>
> *([関ケ原 Ruby 会議 01 の開催に寄せて](https://note.com/sekigahara01/n/nb2a18bc713eb) より引用)*

そのほかオーガナイザー陣の思いは、インタビューでも語られています。

 - [関ケ原 Ruby 会議 01 運営インタビュー ── 【前編】 Ruby の衆、何ゆえ“天下分け目の地”へ馳せ参ずるや - SmartHR Tech Blog](https://tech.smarthr.jp/entry/2026/05/14/153000)
 - [関ケ原 Ruby 会議 01 運営インタビュー ── 【後編】 RubyKaja、東西の武将、合戦、そして宴へ - SmartHR Tech Blog](https://tech.smarthr.jp/entry/2026/05/21/153000)

関ケ原 Ruby 会議の開催直後から実施されていた「大将総選挙」によって推挙された笹田耕一さんと前田修吾さん (両名とも Ruby コミッタ) を東西両軍の総大将として戴き、発表者募集の段階から東軍と西軍のどちらに属するかを決める仕組みになっていました。

ここまでお読みいただいた方はお気付きのことと思いますが、イベントの各種用語や公式発表は通称「武将語」と呼ばれる独特な言葉遣いで徹底されていました (もちろん現代語でのアナウンスももれなくありました)。オーガナイザー (運営) は「**奉行衆**」、発表者は「**武将**」、参加チケットは「**参陣手形**」、パーティ (懇親会) は「**宴**」といった具合です。

公式サイトには日本語と武将語の多言語切り替え機能が実装されており、切り替えると冒頭の文章は以下のように表示されるようになります。

> **天下分け目の地域 Ruby 会議に候**  
> 関ケ原 Ruby 会議 01 は、天下分け目の地「関ケ原」に本陣を構え、Ruby を語らう諸将参集の場に候。  
> いにしえの兵どもが夢の跡にて、いざ新たなる Ruby の軍記を刻まん。

筆者はここ数年久しく Ruby を書いていなかったのですが、昨年の『[北陸 Ruby 会議 01](/articles/0066/0066-HokurikuRubyKaigi01Report.html)』の場でイベントのコンセプトを聞いて、直ちに参加を決めました。

## 合戦本陣

### 諸将参陣

当日の関ケ原は快晴でした。関ケ原ふれあいセンターは絶好の合戦日和です ⚔️

参陣した参加者 (大名・家臣) は受付で東軍・西軍・中央のいずれかの名札を選択して記名する仕組みになっていました。東西

![ホワイトボードに貼られた日本地図に「お主、いずこから参られた？」「付札に御名をしたため、張り付けてくだされ」と書かれています]({{base}}{{site.baseurl}}/images/0066-SekigaharaRubyKaigi01Report/map.jpg){:width="600px"}

会場には日本地図が掲示されており、

### 本陣 開戦の儀 (オープニング)

オープニングでは奉行によって会についての案内があったあと、両軍の武将 (発表者) が入場しました。

![東軍と西軍の武将たちが対峙して、刀を構えて一触即発の状態です]({{base}}{{site.baseurl}}/images/0066-SekigaharaRubyKaigi01Report/busho.jpg){:width="600px"}

両軍の武将が対峙した後は Ruby 作者のまつもとゆきひろさん (Matz) からの開戦の儀がありました。

![まつもとゆきひろさん (Matz) が拳を突き上げて、背景に「開戦」の文字が映し出されています]({{base}}{{site.baseurl}}/images/0066-SekigaharaRubyKaigi01Report/matz_kaisen.jpg){:width="600px"}

## 先鋒戦

先鋒は両陣営とも、「型」に関するテーマについて取り扱われていました。Ruby での開発において型や静的開発をどう扱うかということは未だ議論の多く、エコシステムが Ruby 公式の RBS と、Shopify 社が開発を主導している RBI に二分されており、緒戦から天下を二分する論題です。

### [東軍 先鋒] Sorbet の型が Rails の MVC 全てを貫通するまで

発表者 (武将)
: kazzix14 (源村田信濃掾構幾寿郎一真)

資料
: [Sorbet の型が Rails の MVC 全てを貫通するまで - Speaker Deck](https://speakerdeck.com/kazzix/sorbetnoxing-garailsnomvcquan-tewoguan-tong-surumade)

kazzix14 さんはこれまで、[Type on Rails - Rails アプリケーションの安全性と開発体験を型で革新する]、[mangrove_gem を使って Ruby で静的型ともっと仲良くする]といった発表をされてきましたが、それらを締めくくるような内容になっています。

Ruby on Rails においてモデルの定義によって規定されるメソッドは Sorbet では Tapioca で RBI 型定義ファイルを生成することで補われますが、コントローラや ERB テンプレートなど現状では型が付かない領域をどのように静的解析可能にするかが紹介されました。さらにはブラウザ上で実行されるフロントエンドアプリケーションまでも Ruby で実装・実行することで型を一気通貫させる離れ技まで披露されています。

[Type on Rails - Rails アプリケーションの安全性と開発体験を型で革新する]: https://speakerdeck.com/kazzix/type-on-rails-railsapurikesiyonnoan-quan-xing-tokai-fa-ti-yan-woxing-dege-xin-suru
[mangrove_gem を使って Ruby で静的型ともっと仲良くする]: https://speakerdeck.com/kazzix/mangrove-gemwoshi-tuterubytejing-de-xing-tomotutozhong-liang-kusuru

### [西軍 先鋒] 拙者、『型は欲しいが型は書きたくない』者たちとの和睦を結び、るびぃにおける型の領地安堵を実現せんと欲す者也

発表者 (武将)
: 森塚三矢大阪守真年 (大江森塚三矢大坂守少輔次郎真年)

資料
: [拙者、『型は欲しいが型は書きたくない』者たちとの和睦を結び、るびぃにおける型の領地安堵を実現せんと欲す者也 #sekigahara01/sekigahara01 - Speaker Deck](https://speakerdeck.com/sanfrecce_osaka/sekigahara01)

東軍先鋒の発表は Sorbet を活用して Rails アプリケーションの全体に型をつけるという試みでしたが、森塚さんの発表はそれ以前の Ruby における「型が欲しい／不要」とはどのようなメンタルモデルか、そもそも漠然と『型』と呼ばれているものが何を指しているのかということから、『型シグネチャ』『型推論』『型検査』に要素分解して整理しています。

Ruby コミュニティで最も議論を呼ぶのは『型シグネチャ』つまり、Ruby 作者のまつもとゆきひろ氏が「型宣言は嫌い」と述べているように、コーディングをするために「わざわざ型を明記したくない」 vs 「メンテナンス性のために型を明記すべきである」といった対立でしょう。一方で、『型推論』によって型を明記しなくても状態が絞り込まれたり、『型検査』によってコードの不整合が検出されるのは、検査時間や偽陽性に足を引っ張られさえしなけば無闇に反対する人は多くないはずです。

この発表においては 2026 年前半現在の Ruby における、さまざまな型関連のアプローチや動向、問題点とこれからの展望についても総括されています。

## 次鋒戦

Ruby といえばテキストベースのような印象が強い言語ですが、次鋒戦においてはインタラクティブなアートやゲームといった領域での戦いが繰り広げられました。

### [東軍 次鋒] 気づいたら Ruby で 100 作品 ー クリエイティブコーディングが生活の一部になるまで

発表者 (武将)
: chobishiba (橘小芝内匠頭緒美三幸)

資料
: [気づいたら Ruby で 100 作品 ー クリエイティブコーディングが生活の一部になるまで / 100 Ruby Sketches Later: How Creative Coding Became Part of My Life - Speaker Deck](https://speakerdeck.com/chobishiba/100-ruby-sketches-later-how-creative-coding-became-part-of-my-life)

chobishiba さんはクリエイティブコーディング、つまりソースコードによってインタラクティブなビジュアルアート作品を作る営みについて語りました。

このようなビジュアルアートのための言語／ソフトウェアとしては Processing や、その JavaScript 実装である p5.js が知られていますが、この領域においては [rbCanvas/p5](https://rbcanvas.net/p5/#) や [p5rb](https://github.com/ongaeshi/p5rb/) といった先駆者によって Ruby でも Web ブラウザで表示可能なクリエイティブコーディングを作ることが十分に可能になっています。

この発表では chobishiba さんがとクリエイティブコーディングの出会いから、どのようなことに取り組んで、どのように生活の一部になったかが語られました。

### [西軍 次鋒] Termfront: Ruby 標準ライブラリだけで作る FPS

発表者 (武将)
: S.H. (平毛利石見守八郎秀穎)

資料
: [Termfront: Ruby 標準ライブラリだけで作る FPS - Speaker Deck](https://speakerdeck.com/gamelinks007/termfront-rubybiao-zhun-raiburaridakedezuo-rufps)

S.H. さんは隙間時間にプレイしていた FPS ゲームを、自分のニーズに合うような周回が短いものを Ruby で自作しているという試みについて発表しました。

東軍先鋒の発表では Ruby でのビジュアル表現を p5.js とブラウザで実現していたのに対し、S.H. さんの発表においては Ruby 標準ライブラリとターミナル、つまり文字ベースの端末だけで擬似 3D の FPS を実現しています。文字端末という限定された環境下の要件から擬似 3D エンジンを設計し、一人プレイだけでなくオンライン対戦可能なゲームとして RubyGems で公開、壇上での参加者との対戦も成功させていました。

### ピクニック

![青空の下、前田修吾さんが演説をしている横で東軍大将の笹田耕一さん、奉行衆の osyoyu さんを始めとする多くの兵どもが弁当を食べています]({{base}}{{site.baseurl}}/images/0066-SekigaharaRubyKaigi01Report/picnic.jpg){:width="600px"}

### スポンサー LT

### RubyKaja

### [東軍 中堅] Play Music on Ruby ── PicoRuby で作る MIDI オーケストレーションツール

発表者 (武将)
: Toshio Maki (源牧雅楽頭ミュージ郎俊男)

資料
: [Play Music on Ruby - Picoruby で作る MIDI オーケストレーションツール - \| ドクセル](https://www.docswell.com/s/kirika/5GNQ4D-2026-05-31-085807)

### [西軍 中堅] New "Type" system on PicoRuby

発表者 (武将)
: Masataka Pocke Kuwabara (藤原桒原備中守歩通鍵仁雄)

資料
: [New "Type" system on PicoRuby - Speaker Deck](https://speakerdeck.com/pocke/new-type-system-on-picoruby)



### [東軍 副将] Job 戦国時代

発表者 (武将)
: kinoppyd (紅玉宿禰木下赤羽守 ppyd 翔央)

資料
: [Job 戦国時代 \| ドクセル](https://www.docswell.com/s/kinoppyd/ZX24J3-job-sengoku-jidai)

### [西軍 副将] PicoRuby に於ける Refinements の再解釈

発表者 (武将)
: hasumikin (橘羽角前下総守情操指南匠均之助)

資料
: [PicoRuby に於ける Refinements の再解釈 - HASUMI Hitoshi - Rabbit Slide Show](https://slide.rabbit-shocker.org/authors/hasumikin/SekigaharaRubyKaigi01/)

### 合戦

## 著者について

うさみ
: tadsan。実はるびま編集部員ですが 15 年くらい寝てました。最近は PHP と Emacs Lisp を書きながら Rigor という静的解析ツールを作ってます。
