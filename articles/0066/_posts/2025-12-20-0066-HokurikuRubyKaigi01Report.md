---  
layout: post
title: RegionalRubyKaigi レポート (91) 北陸 Ruby 会議 01 レポート
short_title: RegionalRubyKaigi レポート (91) 北陸 Ruby 会議 01 レポート
tags: 0066 regionalRubyKaigi
post_author: noboru-i(toyama.rb), cotton(kanazawa.rb), taiju(fukui.rb)
created_on: 2025-12-20
---  
{% include base.html %}

## はじめに

北陸 3 県合同の Regional RubyKaigi である北陸 Ruby 会議 01 が、2025 年 12 月に開催されました。  
本記事はその開催レポートです。

なお登壇者名の表記は公式サイトに則っています。

## 開催概要

### テーマ

みんなの Ruby の使い方

### 開催日

2025-12-06 (土) 11:00 - 16:45

### 会場

[石川県立図書館](https://www.library.pref.ishikawa.lg.jp/) 研修室


![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/venue_01.webp)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/venue_02.webp)

### 主催

北陸 3 県で活動する 3 つの Ruby コミュニティが合同で主催・運営を行っています。  
※都道府県コード順

* 富山: [Toyama.rb](https://toyamarb.github.io/)  
* 石川: [Kanazawa.rb](https://kzrb.org/)  
* 福井: [fukui.rb](https://fukuirb.connpass.com/)

### 参加者

69 名

### 公式サイト

[https://regional.rubykaigi.org/hokuriku01/](https://regional.rubykaigi.org/hokuriku01/)

### 公式タグ

[#hokurikurk01](https://twitter.com/search?q=%23hokurikurk01)

### ツイート/写真まとめ

* [北陸 Ruby 会議 01 - posfie](https://posfie.com/@kanazawarb/p/chI0xQ6)  
* [北陸 Ruby 会議 01 - SUZURI アルバム](https://30d.jp/kzrb/148)

## オープニングセッション

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/opening.webp)

まずは、実行委員長の 1 人である [kunitoo](https://github.com/kunitoo) (Toyama.rb) のオープニングトーク。

## 日本 Ruby の会の構造と実行とあと何か

* 発表者：高橋征義 (Masayoshi Takahashi)  
* 資料：[日本 Ruby の会の構造と実行とあと何か](https://speakerdeck.com/takahashim/hokurikurk01)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/Masayoshi_Takahashi.webp)

1 つ目のセッションは、日本 Ruby の会の高橋征義さんによるキーノート。  
今回の北陸 Ruby 会議 01 が、ちょうど 100 回目の Regional RubyKaigi だそうです！　  
日本 Ruby の会の成り立ちや背景、役割などを紹介いただきました。  
今回のテーマは「みんなの Ruby の使い方」でしたが、「みんなの Ruby の会の使い方」も募集中とのことでした。

## Ruby で作る大規模イベントネットワーク構築・運用支援システム TTDB

* 発表者：高嶋健人  
* 資料：[Ruby で作る大規模イベントネットワーク構築・運用支援システム TTDB](https://speakerdeck.com/taketo1113/ruby-dezuo-ruda-gui-mo-ibentonetutowakugou-zhu-yun-yong-zhi-yuan-sisutemu-ttdb)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/taketo1113.webp)

fukui.rb の方から、今回の実行委員長の 1 人でもある高嶋健人さん。  
Interop Tokyo で構築される ShowNet というネットワークの構築を支える TTDB (トラブルチケットデータベース) というシステムは、2006 年から Ruby on Rails を利用して開発・運用が続けられているそうです。  
また、その中でどのように Ruby が利用されているかも紹介されてました。

## 計算機科学を Ruby と歩む 〜DFA 型正規表現エンジンをつくる～

* 発表者：ydah  
* 資料：[計算機科学を Ruby と歩む 〜DFA 型正規表現エンジンをつくる～](https://speakerdeck.com/ydah/build-dfa-regex-engine-in-ruby-b97a5909-5b37-42bc-96ea-83f205303287)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/ydah.webp)

SmartHR/関西 Ruby 会議/関ヶ原 Ruby 会議の方から、ydah さん。  
正直、正規表現自体の話は「なるほど？」という感じでしたが、「Ruby が学習に最適」と聞いてから改めてスライドの Ruby コードを見ると、Ruby だから読める気がしてきました。

## スポンサーセッション

### 株式会社あしたのチーム

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/ashita-team.webp)

最初のスポンサーセッションは、人事評価周りの構築や SaaS などを提供されている株式会社あしたのチーム様。

### 株式会社永和システムマネジメント

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/esm.webp)

2 つ目のスポンサーセッションセッションは、Regional RubyKaigi に来る人はほとんど知ってる株式会社永和システムマネジメント様。

### 株式会社クルウィット

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/clwit.webp)

スポンサーセッション最後は、実行委員長の 1 人でもある [kiyohara](https://github.com/kiyohara) さんより、株式会社クルウィット様。

## Ruby DSL で Minecraft を改造できるようにする 〜パパの Ruby、娘の Minecraft〜

* 発表者：東 大樹

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/taiju.webp)

fukui.rb のオーガナイザーの東 大樹さん  
Minecraft を Ruby DSL で改造して Minecraft 内にプレゼンツールを作成し、デモしながら追加したアイテム DSL とコマンド DSL について紹介していただきました。おれは Rubyist だー！

## Ruby で鍛える仕組み化プロヂュース力

* 発表者：無量井 健  
* 資料：[Ruby で鍛える仕組み化プロヂュース力](https://speakerdeck.com/muryoimpl/rubydeduan-erushi-zu-mihua-purodiyusuli)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/muryoimpl.webp)

kzlt-ruby の創造主の無量井 健さん  
仕組み化は暗黙知から形式知にできる。みんな困り事は気がついている、あとはやるだけ。法則を見いだせたらもう勝ち、あとはやるだけ。仕組み化のコツなどを紹介していただきました。

## Ruby で作る静的サイト

* 発表者：おおくらまさふみ  
* 資料：[Ruby で作る静的サイト](https://speakerdeck.com/okuramasafumi/developing-static-sites-with-ruby)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/okuramasafumi.webp)

Kaigi on Rails の発起人・チーフオーガナイザーのおおくらまさふみさん  
必要なものだけで済む静的サイトはいいぞ。Ruby にはたくさんの SSG があり、サイト構築におけるちょっとしたロジックを書くのに Ruby は最適など静的サイトについて紹介していただきました。

## Kaigi on Rails 2025 における subscreen の実装について

* 発表者：うなすけ  
* 資料：[Kaigi on Rails 2025 における subscreen の実装について](https://slide.rabbit-shocker.org/authors/unasuke/hokurikurk01/)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/unasuke.webp)

Kaigi on Rails のいちオーガナイザーのうなすけさん  
同時通訳と字幕の仕組みを実装した話です。AI と壁打ちして方針決め、Vibe coding。色々なトラブルがありながら Kaigi on Rails 2025 を乗り切った実体験を紹介していただきました。

## Ruby 受託事業マネジメントの 10 年

* 発表者：平田守幸  
* 資料：[Ruby 受託事業マネジメントの 10 年](https://speakerdeck.com/mhirata/a-decade-of-managing-ruby-contract-development)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/mhirata.webp)

Software Design 2025 年 4 月号にご寄稿されました平田守幸さん  
Ruby 受託事業マネジメントの 10 年、受託開発 20 年でおきた課題や問題に対する実際の対策と今後の展望について紹介して頂きました。

## LT

LT にも多くの方に登壇していただきました。 身の回りの不便を解決した話から、仕事での活用法、あるいは Ruby の書き方そのものの話まで。 まさに「みんなの Ruby の使い方」をそれぞれ聞くことができ、とても面白い時間でした。

### 「Ruby で守るわが家の安心：IoT センサーネットワーク『ゆきそっく』の実践」

* 発表者：井澤ゆきみつ  
* 資料：[Ruby で守る我が家の安心: IoT センサ ーネットワーク『ゆきそっく』の実践](https://speakerdeck.com/izawa/rubydeshou-ruwo-gajia-noan-xin-iotsensa-netutowaku-yukisotuku-noshi-jian)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/izawa.webp)

### 猫の健康を見守りたい！　実践 Raspberry Pi + Ruby

* 発表者：beta_chelsea  
* 資料：[猫の健康を見守りたい！　実践 Raspberry Pi + Ruby](https://speakerdeck.com/betachelsea/mao-nojian-kang-wojian-shou-ritai-shi-jian-raspberry-pi-plus-ruby)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/betachelsea.webp)

### 与信管理を形にする：Ruby の柔軟性が支える高速データ収集・自動化基盤

* 発表者：5hun  
* 資料：[与信管理を形にする： Ruby の柔軟性が支える高速データ収集・自動化基盤](https://speakerdeck.com/5hun/yu-xin-guan-li-woxing-nisuru-ruby-norou-ruan-xing-gazhi-erugao-su-detashou-ji-zi-dong-hua-ji-pan)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/5hun.webp)

### rack-attack gem によるリクエスト制限の失敗と学び

* 発表者：なっちゃん
* 資料：[rack-attack gem によるリクエスト制限の失敗と学び](https://speakerdeck.com/pndcat/rack-attack-rate-limiting-lessons-learned)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/pndcat.webp)

### Ruby で楽してタスクを書きたい！

* 発表者：ahogappa  
* 資料：[Ruby で楽して タスクを書きたい！　](https://speakerdeck.com/ahogappa/rubydele-site-tasukuwoshu-kitai)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/ahogappa.webp)

### STYLE

* 発表者：Koichi ITO  
* 資料：[STYLE](https://speakerdeck.com/koic/style)

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/koic.webp)

## 30 歳を迎えた Ruby の魅力と僕たちの今、そしてこれから

* 発表者：wtnabe

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/wtnabe.webp)

最後は Kanazawa.rb の発起人である wtnabe さんの基調講演。 まるで当時にタイムスリップしたような歴史の振り返りには、深い懐かしさを感じました。一方で、今の Ruby を取り巻く状況解説には確かな納得感も。

「ファーストタイムスピーカーを増やしたい」という言葉には、もっとカジュアルに発表してほしいという温かい思いが込められており、まだ一歩を踏み出せていない人へのエールとなりました。 久しぶりの「wtnabe 節」に会場からも喜びの声が上がっていました。

## クロージングセッション

![]({{base}}{{site.baseurl}}/images/0066-HokurikuRubyKaigi01Report/closing.webp)

最後は実行委員会 taketo さんのクロージングです。 開催への感謝とともに、「これからも北陸 Ruby 会議を続けていきたい」という力強い意気込みが語られ、イベントは盛況のうちに幕を閉じました。

## スポンサー

* [株式会社あしたのチーム](https://www.ashita-team.com/)  
* [株式会社永和システムマネジメント](https://agile.esm.co.jp/)  
* [株式会社クルウィット](https://www.clwit.co.jp/)  
* [フィヨルドブートキャンプ](https://bootcamp.fjord.jp/)  
* [15VISION](https://15vision.jp/) (ロゴ制作)

## 運営

### [Toyama.rb](https://toyamarb.github.io/) について

富山県とその周辺地域の Rubyist のためのコミュニティです。  
富山市内を中心に活動しています。

### [Kanazawa.rb](https://meetup.kzrb.org/) について

金沢市および周辺地域在住あるいは Ruby やその他技術に興味のあるすべての人を対象にした小さな地域 Ruby コミュニティです。

### [fukui.rb](https://fukuirb.connpass.com/) について

福井にゆかりのある人たちで集まる Ruby コミュニティです。毎月 1 回は主にオンラインで集まって何かをしています。もくもく会のほか、RubyKaigi や Kaigi on Rails のイベントなどの後にはそれらのイベントの感想戦なども開催しています。

## 著者について

### 石倉 昇 ([@noboru_i](https://x.com/noboru_i))

北陸 Ruby 会議 01 の写真係 兼 レポート係。  
フルリモート会社員。  
オープニングからスポンサーセッションのレポートを担当しました。

### cotton ([@cotton_desu](https://x.com/cotton_desu))

北陸 Ruby 会議 01 のスピーカーサポーター 兼 レポート係。    
ときどき出社するリモート会社員。  
「Ruby DSL で Minecraft を改造できるようにする 〜パパの Ruby、娘の Minecraft〜」  
から「Ruby 受託事業マネジメントの 10 年」のレポートを担当しました。

### 東　大樹 ([@taiju](https://x.com/taiju))  

北陸 Ruby 会議 01 のスタッフ。今回のイベントでは Ruby コミュニティイベントでの初登壇もさせていただきました。  
LT ～クロージングまでのレポートを担当しました。
