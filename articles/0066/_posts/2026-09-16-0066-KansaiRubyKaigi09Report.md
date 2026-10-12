---
layout: post
title: RegionalRubyKaigi レポート (NUM) 関西 Ruby 会議 09
short_title: RegionalRubyKaigi レポート (NUM) 関西 Ruby 会議 09
post_author: 関西 Ruby 会議 09 実行委員会
tags: 0066 KansaiRubyKaigi09Report regionalRubyKaigi
created_on: 2026-09-16
---
{% include base.html %}

## {% post_title articles/0066/2026-09-16-0066-KansaiRubyKaigi09Report %}

## はじめに

2026 年 7 月 18 日に開催された関西 Ruby 会議 09 のレポートです。
筆者は実行委員として当日は主に裏方を担当しており、すべてのセッションを聴講できたわけではありません。
網羅的なレポートというより、会場のあちこちから見た一日の記録として読んでいただければ幸いです。
資料が公開されているセッションについては、あわせてリンクを添えています。

## 開催概要

* 日時：2026 年 7 月 18 日 (土) 10:00〜18:20 (受付開始 9:00)
* 場所：[大津市伝統芸能会館](https://www.otsu-dengei.jp/)
* 主催：関西 Ruby 会議 09 実行委員会 ([About](https://regional.rubykaigi.org/kansai09/about))
* サポーター：[一般社団法人 日本 Ruby の会](https://ruby-no-kai.org/)・[和歌山県立桐蔭高等学校](https://www.toin-h.wakayama-c.ed.jp/)
* 公式サイト：[関西 Ruby 会議 09](https://regional.rubykaigi.org/kansai09/)
* 公式ハッシュタグ：[#kanrk09](https://x.com/hashtag/kanrk09)
* オフィシャルグッズ：[関西 Ruby 会議 09 Official Goods](https://suzuri.jp/kyobashirb/sections/35030)
* 参加者数：162 名 (運営スタッフ・登壇者含む)

![関西 Ruby 会議 09 バナー]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/kanrk09-banner.webp)

## 関西 Ruby 会議とは

関西 Ruby 会議は [2008 年](https://magazine.rubyist.net/articles/0025/0025-KansaiRubyKaigi01Report.html)にはじまった技術カンファレンスで、関西圏を中心に Rubyist が集まり、Ruby に関する知見を共有する場です。

今回は AKASHI.rb や Kyoto.rb、Ruby 関西、Wakayama.rb など、関西の 12 の地域 Ruby コミュニティが主催として名を連ねました。

## セッション

今回のテーマは「照」です。[チーフオーガナイザーの ydah さんによるタイムテーブルの解説](https://tech.smarthr.jp/entry/2026/07/10/170000)によれば、「見えない構造を明らかにする」意味と、Ruby と出会って新しい道が照らされる意味を込めた一文字とのことです。

実際に並んだのは、ネットワーク、舞台照明、正規表現エンジン、モジュラモノリス、AI から部屋の照明を操る話、自転車のセンサー、占い、ガベージコレクション、8bit ゲーム機でした。題材はばらばらですが、発表者のみなさんがそれぞれの解釈でテーマを持ち寄ってくれた結果だと ydah さんは話されています。

![00_opening.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/00_opening.webp)

### Keynote: 令和の net/http

* 発表者：成瀬 ゆい 氏 ([@nurse](https://x.com/nurse))

HTTP/2 や HTTP/3、QUIC の登場、そして IPv4 と IPv6 のデュアルスタック環境と、いまや「つなぎにいく方法」の選択肢は増え続けています。その現状を整理したうえで、`net/http` で Happy Eyeballs Version 3 への対応が進められていることを紹介されていました。

`Net::HTTP` を使う側はふだんまったく意識することのない層の話で、開幕から一気に足元を照らされたような心地でした。

![01_nurse.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/01_nurse.webp)

### 「照らす技術」を Ruby で照らす

* 発表者：Shunsuke Michii 氏 ([@harukasan](https://x.com/harukasan))
* 資料：[「照らす技術」をRubyで照らす](https://harukasan.dev/posts/diary/20260720-illuminating-the-technology-of-illumination-using-ruby)

PicoRuby で動かす自作のマイコンボード Harucom から、RS485 上の DMX512 プロトコルで舞台照明を制御する、というお話でした。
音と光を同時に扱うシーケンサー「序破急」で照明と音のパターンを記述し、会場のムービングライトを音楽に合わせて動かすデモを披露されました。

能舞台の上で Ruby がライトを振り回す絵は、テーマの「照」をそのまま体現していました。

![02_harukasan.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/02_harukasan.webp)

### Project Naraku 外伝 —— レールロード図で照らす Onigmo のバグ

* 発表者：shimokawa 氏 ([@aim2bpg](https://x.com/aim2bpg))
* 資料：[Project Naraku 外伝 —— レールロード図で照らす Onigmo のバグ](https://speakerdeck.com/aim2bpg/project-naraku-wai-chuan-rerurodotu-dezhao-rasuonigmonobagu)

Onigmo の置き換えを目指す次世代正規表現エンジン Project Naraku の「外伝」として、レールロード図で正規表現を可視化し、Onigmo のバグをあぶり出すお話でした。
具体例として挙げられていたのが、ドイツ語の ß をめぐるケースフォールディングの非対称性です。`/[s]s/i` は "ß" にマッチするのに、`/s[s]/i` はマッチしません。

正規表現エディタ [Rubree](https://aim2bpg.github.io/rubree/) を作るところから、だんだんと正規表現の深みにはまり込んでいった経緯そのものが面白く、引き込まれる発表でした。
犬夜叉のコスプレでの登壇だったこともあり、何が始まるのかと戸惑った人も多かったのではないでしょうか。

![03_aim2bpg.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/03_aim2bpg.webp)

### torikago - Ruby::Box で照らすモジュラモノリスの実行境界

* 発表者：nori 氏 ([@se4weed_dev](https://x.com/se4weed_dev))
* 資料：[torikago - Ruby::Box で照らすモジュラモノリスの実行境界](https://speakerdeck.com/se4weed/torikago-ruby-boxdezhao-rasumoziyuramonorisunoshi-xing-jing-jie)

モジュラモノリスにおける「構造上の境界」と「実行時の境界」の不一致を出発点に、Ruby 4 の実験的機能である `Ruby::Box` でモジュール間の参照ルールを YAML で定義する [torikago](https://github.com/se4weed/torikago) gem を紹介されていました。

Rails の起動時間が 6.2 倍になるなど、現時点での課題も具体的な数値とともに示されていました。

![04_se4weed.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/04_se4weed.webp)

### ひとつの指示で、部屋にあかりを。

* 発表者：しげる。 氏 ([@4geru](https://x.com/4geru))
* 資料：[Rails で Remote MCP サーバーを作った話](https://speakerdeck.com/4geru/rails-de-remote-mcp-sabawozuo-tutahua-266db767-a8d7-4d27-8fe3-0a31ff3956c2)

Rails で Remote MCP サーバーを実装し、「琵琶湖の夕焼けみたいな色にして？」といった自然言語の指示で、部屋の Philips Hue の色が変わるまでをデモされていました。まず自力で実装し、そのうえで gem に置き換えるという構成です。

自前の実装にはトークンの平文保存や PKCE 未実装といった穴が残る、「Gem が消すのは行数より「抜け漏れ」」という話でした。

![05_4geru.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/05_4geru.webp)

### チャリンコ・オブザーバビリティ

* 発表者：kinoppyd 氏 ([@kinoppyd](https://x.com/kinoppyd))
* 資料：[チャリンコオブザーバビリティ](https://www.docswell.com/s/kinoppyd/5Q2EG3-charinko-observability)

ロードバイクにオブザーバビリティの考え方を持ち込む発表でした。
速度・ケイデンス・心拍にとどまらず、ギアの位置やブレーキレバーの引き量まで計測対象にしていて、標準の BLE プロファイルはあえて使わず、BLE UART の独自プロトコルに統一したうえで Raspberry Pi Pico 2 W と PicoRuby でセンサーを自作されていました。

趣味でロードバイクに乗る身としては、「現代のロードバイク理論として、筋肉を使うより肺を使うほうがいい」という一節がとても刺さりました。

![06_kinoppyd.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/06_kinoppyd.webp)

### Ruby で未来を照らす 〜占いを実装する技術〜

* 発表者：Kotomi Inoue 氏 ([@ikoto_me](https://x.com/ikoto_me))

四柱推命を [meiri gem](https://github.com/ikotome/meiri) として実装するまでのお話でした。
占いという曖昧な対象をどうソフトウェアとして扱うか。生年月日時が決まれば命式が一意に決まる、つまり関数として捉え直すところから gem になっていく流れが、きれいに整理されていました。

![07_ikotome.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/07_ikotome.webp)

### Can you see? I'm GC

* 発表者：yhara 氏 ([@yhara](https://x.com/yhara))
* 資料：[Can you see? I'm GC](https://docs.google.com/presentation/d/1BGr4KyT6_dThL6mADHRIh4GgVplvQ2XicVu1mJMANdA/preview)

Ruby 3.4 の Modular GC を使って、自作の Mark & Sweep GC [imgc](https://github.com/yhara/imgc) を実装し、その動きを raylib で可視化する発表でした。
この GC は Claude Code に実装させたもので、「勉強用なので、性能よりもわかりやすさを優先してください」と指示した結果、1635 行 (コメント等含む) に収まったとのことです。

普段まったく意識せずに享受しているメモリの解放を、文字どおり目に見えるようにしてくれるセッションでした。

![08_yhara.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/08_yhara.webp)

### VM と AOT コンパイラ開発で照らす 8Bit 機の世界

* 発表者：Yuji Yokoo 氏 ([@yujiyokoo](https://x.com/yujiyokoo))

「ゲーム機で Ruby を動かす」取り組みの続編として、8bit CPU である Z80 を対象にした mruby の VM と AOT コンパイラのお話でした。
VM はご自身の手で実装し、AOT コンパイラのほうはコーディングエージェントに開発してもらっているとのことで、この対照的な進め方が興味深いところでした。
[mrubyz](https://github.com/yujiyokoo/mrubyz) は現在 Sega Master System で動作しています。

レトロゲーム機の開発を知らない人間にも、メモリや CPU の制約がどういうものかが伝わってくる発表でした。

![09_yujiyokoo.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/09_yujiyokoo.webp)

### 関西 LT 保安協会

関西の地域.rb から推薦されたスピーカーによる LT セッションです。
滋賀といえば「イナズマ」、Lightning Talk の「ライトニング」、そして会議のテーマである「照」。この三つをかけ、登壇者にスポットを当てて照らす枠です。名前は関西でおなじみのあの CM の一般財団法人をもじっています。

![10_kansai_lt.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/10_kansai_lt.webp)

#### 滋賀県観光保安協会だより

* 発表者：haruguchi 氏 (株式会社永和システムマネジメント)

全国から滋賀を訪れる Rubyist の安全と観光満足度を守るべく、琵琶湖のほとりから厳選した滋賀情報をお届けする 5 分間。枠名にふさわしい幕開けです。

![11_haruguchi.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/11_haruguchi.webp)

#### 発見！Ruby 9

* 発表者：rokuosan 氏 ([@rokuosan_dev](https://x.com/rokuosan_dev))
* 資料：[発見！Ruby 9](https://speakerdeck.com/rokuosan/kanrk09)

存在しないはずの Ruby 9 を探しにいく発表です。
「Ruby 4」をグッと睨むと 9 に見えてくる。CRuby では `4` の `object_id` が `(4 << 1) + 1` で 9 になる。Ruby 1.9 は実質 Ruby 9。ルビーのモース硬度は 9。全方位から Ruby 9 を発見してみせました。

![12_rokuosan.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/12_rokuosan.webp)

#### 数百円から始める Ruby 電子工作

* 発表者：たろサ 氏 (tarosay / Wakayama.rb)
* 資料：[数百円から始める Ruby 電子工作](https://speakerdeck.com/tarosay/shu-bai-yuan-karashi-merurubydian-zi-gong-zuo)

290 円の UIAPduino ボード (CH32V003) 上で Ruby を動かす UIAPruby の紹介でした。
[ブラウザ上のエディタ](https://tarosay.github.io/uiap-hid-web/uiapruby.html)だけで Ruby を書いてバイトコードに変換し、WebHID でそのまま転送できるとのことです。PicoRubyKaigi 2026 Assemble への応募を条件に、懇親会の会場で 15 台が配られていました。

![13_tarosay.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/13_tarosay.webp)

#### 学生がプログラミング言語処理系に向き合って良かったこと！ Ruby 編！

* 発表者：しおまち 氏 (shiomachi)
* 資料：[学生がプログラミング言語処理系に向き合って良かったこと！ Ruby 編！](https://docs.google.com/presentation/d/1LDShiPkbxwJziCdkGtUNacmPltkWQnISFry2uUATuQM/preview)

C++ で拡張 BNF から構文解析表を生成するツールを書いていた学生さんによる登壇です。
kyobashi.rb に参加したことをきっかけに Ruby を駆け足で習得し、この日の登壇までたどり着いたそうです。

本題は、言語処理系の知識が現代の開発にどう効くかという話でした。
自作のマルチテナントなファイルサーバーで、テナントの絞り込み漏れを RuboCop の AST 走査によって検出し、GitHub Actions に組み込んでいるとのこと。
生成 AI に書かせた実装の安全性を、自前の lint ルールで担保するという発想です。

パーサを自分で実装できること、言語の構文がなぜそうなっているのかを考えられること、技術書の用語をひとつずつ紐解けること。この 3 つを楽しさとして挙げたうえで、構文解析や構文木の力を大学でも広めたいと締めくくられました。学生のうちからここまで踏み込んでいるのが印象的でした。

![14_shiomachi.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/14_shiomachi.webp)

#### Aurora MySQL 8.4 リリース！ Rubyist が備えること

* 発表者：ふくま 氏 ([@fkm_y](https://x.com/fkm_y))
* 資料：[Aurora MySQL 8.4 リリース！ Rubyist が備えること](https://speakerdeck.com/fkmy/what-rubyist-should-prepare-for-aurora-mysql-8-4)

Aurora MySQL v8.4 での TLS と認証プラグインのデフォルト変更に、Rails 側でどう備えるかという実務的な LT でした。
`mysql_native_password` から `caching_sha2_password` への移行を、trilogy と mysql2 それぞれの挙動の違いまで踏み込んで解説されていました。

のちに懇親会での会話がきっかけで、trilogy へ Pull Request を 2 本 ([#300](https://github.com/trilogy-libraries/trilogy/pull/300)、[#301](https://github.com/trilogy-libraries/trilogy/pull/301)) 送り、いずれもマージされたそうです。

![15_fkmy.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/15_fkmy.webp)

#### 『測定できないものは、管理できない』らしいので集中力測定アプリを作った

* 発表者：ryotana 氏
* リポジトリ：[ryotana424/matatakuma](https://github.com/ryotana424/matatakuma)

自分の集中力を測るアプリ matatakuma の紹介です。
Web カメラの映像から、画面への視線・頭の安定・まばたき・セッションの継続・顔の検出率の 5 つを重みづけして 0〜100 のスコアを算出し、タスクごとに記録して一日単位で振り返れるようになっています。

映像の解析は MediaPipe でブラウザの中だけで完結させ、サーバーへ送るのは集計後の数値のみ。サーバー自体も 127.0.0.1 にしかバインドしないという徹底ぶりでした。
集中力という曖昧なものを測りにいきつつ、そのために覗き込んだ映像は一切外に出さない、という設計が気持ちよかったです。

![16_ryotana.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/16_ryotana.webp)

#### 琵琶湖の水は止められても、Net::HTTP のリトライは止められない

* 発表者：luccafort 氏 ([@luccafort](https://x.com/luccafort))
* 資料：[琵琶湖の水は止められても Net::HTTP のリトライは止められない](https://speakerdeck.com/luccafort/you-might-be-able-to-stop-the-water-flow-of-lake-biwa-but-you-cant-stop-net-http-retries)

筆者の発表です。滋賀と Ruby で何か話せないか、というところから始めました。
`Net::HTTP` は GET など冪等なリクエストがタイムアウトすると、黙ってもう一度だけ投げ直します。`timeout` は 1 回あたりの値なので、1 秒のつもりが呼び出し側から見た待ち時間は約 2 秒になる。しかもリトライは `Net::HTTP` の内側で完結するため、APM 上は「1 回のリクエストがなぜか遅い」としか見えません。タイトルはそこからきています。
Ruby 2.5 以降は `max_retries` を 0 にすれば止められますし、現在の Faraday はすでに対処済みです。登壇後に [@osyoyu](https://x.com/osyoyu) さんから、仕様を変える Pull Request か Issue を出してみてはと声をかけていただきました。

![17_luccafort.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/17_luccafort.webp)

#### Google Apps Script で Ruby を動かす

* 発表者：川原 翔吾 氏 (ooharabucyou)
* 資料：[Google Apps Script で Ruby を動かす](https://speakerdeck.com/kawahara/google-apps-script-de-ruby-wodong-kasu)

手元のライブラリが Ruby なので GAS でも Ruby を書きたい、という動機から、PicoRuby を WebAssembly にコンパイルして GAS の V8 ランタイム上で動かした話です。
1.3MB の wasm を Base64 にして GAS のプロジェクトに直接埋め込み、Clasp と Rollup でビルドするという構成です。

「GAS で Ruby は動く」ことはデモで実証されたものの、スクリプトサイズの上限や `UrlFetchApp` の 1 日あたりの回数制限といった壁があることも正直に話されていました。
動かしたい、から始めてここまで持っていく力に感心しました。

![18_ooharabucyou.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/18_ooharabucyou.webp)

### スポンサーセッション: 大規模開発とチームを支える Ruby の好きなところ！

* 発表者：御園 信大 氏 (虎の穴ラボ株式会社)

能舞台に出囃子つきで登場するという、この会場ならではの一幕でした。

[虎の穴ラボの参加レポート](https://toranoana-lab.hatenablog.com/entry/2026/07/23/100000)によれば、御園さんは「各所に仕込んだネタが滑らずに盛り上がって良かった」とホッとされていたそうです。おかげで会場は大いに沸きました。

![19_sponsor.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/19_sponsor.webp)

### Keynote: Ruby を余すところなく愛する人のための「オートマトンと形式言語理論」入門

* 発表者：はすじょい 氏 ([@hsjoihs](https://x.com/hsjoihs))
* 資料：[Ruby を余すところなく愛する人のための「オートマトンと形式言語理論」入門](https://docs.google.com/presentation/d/1ZfueAQyVJsC2pmUYgIGdb_fmnFExYaCRnr9vcCf5uNk/preview)

形式言語理論とオートマトンを、Ruby の実装と地続きのものとして語るクロージングキーノートでした。
Ruby の言語仕様を「そういうものだ」と受け入れて使うのではなく、なぜそうなっているのかを考えるための視点を渡してくれる内容でした。

情報の密度と速度がすさまじく、追いかけるだけで精一杯だったという声が会場のあちこちから聞こえてきました。
技術尽くしの一日を締めくくるにふさわしいセッションでした。

![20_hsjoihs.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/20_hsjoihs.webp)

## 会場のようす

### 檜の能舞台と出囃子

今回の会場は、大津市伝統芸能会館の能楽ホールです。
ソフトウェアエンジニアが檜の能舞台に立つ機会は、そうそうあるものではありません。

関西 Ruby 会議には、08 から続く「出囃子」という文化があります。運営から登壇者に流したい曲を伺い、ご本人に指定していただく方式です。名前が呼ばれると音楽が流れ、発表者が能舞台へ上がっていく。スポンサーセッションの登壇もこの形式で行われました。
前回から受け継いだこの仕掛けが、今回は檜の能舞台と噛み合いました。複数の参加レポートでも、この会場の珍しさに触れられていました。
当日流した出囃子は[プレイリストとして公開しています](https://music.apple.com/jp/playlist/%E9%96%A2%E8%A5%BFruby%E4%BC%9A%E8%AD%B009-%E5%87%BA%E5%9B%83%E5%AD%90-%CE%B1/pl.u-xKK2hp3bqYE)ので、あの日の空気を思い出したい方はぜひ聴いてみてください。

![21_venue.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/21_venue.webp)

### 通路がひとつしかない会場

能楽ホールは決して大きくはなく、通路もひとつだけでした。
そのぶん人の動線が自然に一本に集まり、廊下でのコミュニケーションがとても活発でした。
小さな会場には小さな会場なりの楽しみ方があります。今回はそれを存分に味わっていただけたのではないでしょうか。

各セッションのあとには、聞いたばかりの感想を 1 分で登壇者に届けられる「1 分間フィードバック」の時間を設けました。
他のカンファレンスで根づいている取り組みに影響を受けて取り入れたもので、集まったフィードバックは後日、チーフオーガナイザーの ydah さんから登壇者のみなさんへお届けしました。

![22_corridor.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/22_corridor.webp)

残念ながら午後に入ってから雨が降り出し、夕方にはかなり強くなっていましたが、会場にはそれを感じさせない熱気がこもっていました。幸い、閉会の頃には雨も上がっていました。
午後の休憩に配ったくず餅アイスは、ちょうどよいクールダウンになったようです。

当日は「滋賀在住で、近くでイベントが開催されているので来た」という方にも何人かお会いしました。
まさに地域 Ruby 会議ならではの声で、これが聞けただけでも滋賀でやった甲斐がありました。

### 懇親会

本編終了後は、大津駅前の [THE CALENDAR](https://the-calendar.jp/) に会場を移して Official Party を開催しました。
滋賀の地酒と地元のクラフトビール、そして参加者のみなさんには記念のカップをお渡ししています。

一日の熱が冷めないうちに、登壇者と参加者がそのまま話し込める場になっていました。
ここでの何気ない会話から OSS へのコントリビュートが生まれたのも、この場ならではです。

![23_party.webp]({{base}}{{site.baseurl}}/images/0066-KansaiRubyKaigi09Report/23_party.webp)

## ご協賛頂いた企業様

関西 Ruby 会議 09 は、以下の企業各社のご協賛により開催することができました。ありがとうございました。

### Biwa Sponsor

* [虎の穴ラボ株式会社](https://toranoana-lab.co.jp/)

### Gold Sponsor

* [エースチャイルド株式会社](https://www.as-child.com/)
* [ポノス株式会社](https://www.ponos.jp/)
* [株式会社Gaji-Labo](https://www.gaji.jp/)
* [株式会社IVRy](https://ivry.jp/)
* [株式会社Leaner Technologies](https://leaner.co.jp/)
* [株式会社Ruby開発](https://www.ruby-dev.jp/)
* [株式会社アジャイルウェア](https://agileware.jp/)
* [株式会社インゲージ](https://ingage.co.jp/)
* [株式会社ネットプロテクションズ](https://corp.netprotections.com/)
* [株式会社永和システムマネジメント](https://esm.co.jp/)

### Silver Sponsor

* [株式会社SmartHR](https://smarthr.co.jp/)
* [株式会社ネットワーク応用通信研究所](https://www.netlab.jp/)

### Tool Sponsor

* [合同会社esa](https://esa.io/)

## おわりに

檜の能舞台という、Ruby のカンファレンスではまず立つことのない場所を借りて、一日を終えることができました。登壇者のみなさん、ご協賛いただいた企業各社、そして雨のなか大津まで足を運んでくださったみなさんに、あらためて御礼申し上げます。

関西 Ruby 会議は、関西の 12 の地域 Ruby コミュニティが持ち回りで支えることで続いています。次回の[関西 Ruby 会議 10](https://rubykansai.github.io/kansai10/) は 2027 年 6 月 19 日 (土)、神戸のクラブ月世界での開催を予定しています。十度目の節目を、またみなさんとご一緒できればうれしいです。

## 著者について

### [@luccafort](https://x.com/luccafort)

Kyoto.rb オーガナイザー。
関西 Ruby 会議 09 ではスポンサー周りの対応を担当していました。
Kyoto.go のファウンダー、Go Conference の実行委員、Gophers Japan の共同理事でもあります。
マネーフォワード京都開発拠点所属のエンジニア。

### Special Thanks

本記事の執筆にあたり、[なかにしゆう](https://x.com/youcune) さんに写真を提供いただきました。ありがとうございました。

## 参考にさせていただいた記事

本稿の執筆にあたり、参加されたみなさんのレポートを参考にさせていただきました。ありがとうございました。

[関西Ruby会議09に行ってきました](https://sugiwe.hatenablog.jp/entry/kanrk09)
[関西Ruby会議09に参加しました #kanrk09](https://blog.n-z.jp/blog/2026-07-18-kansairubykaigi09.html)
[関西Ruby会議09参加レポート ~セッションとコミュニティの熱狂を浴びて~](https://itojum.dev/blogs/fq7v36l0n)
[関西 Ruby 会議 09 参加レポート](https://zenn.dev/socialplus/articles/f3bb6ef06b56ca)
[関西Ruby会議09と大吉祥寺.pm 2026に参加した](https://d.s01.ninja/entry/20260727/1785143286)
[関西Ruby会議09レポート —— 前夜祭、本編、Official Party](https://tech.smarthr.jp/entry/2026/07/30/120000)
[関西Ruby会議09にGoldスポンサーとして参加しました](https://note.com/eityans/n/nc8907290e902)
[関西Ruby会議09でLT登壇してきました 〜Aurora MySQL 8.4リリース！ Rubyistが備えること〜](https://fkmy.hatenablog.com/entry/2026/07/25/100000)
[関西Ruby会議09に永和システムマネジメントからharuguchiがLT登壇します](https://blog.agile.esm.co.jp/entry/kanrk09)
[関西Ruby会議09よかった](https://www.youtube.com/watch?v=MXcS_A42vtI)
[関西Ruby会議の再開に寄せて](https://note.com/kanrk/n/n777c24568894)
