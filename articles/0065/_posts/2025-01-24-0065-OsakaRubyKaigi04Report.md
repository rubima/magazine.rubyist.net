---
layout: post
title: RegionalRubyKaigi レポート (89) 大阪 Ruby 会議 04
short_title: RegionalRubyKaigi レポート (89) 大阪 Ruby 会議 04
post_author: ydah
tags: OsakaRubyKaigi04Report regionalRubyKaigi
created_on: 2025-01-22
---
{% include base.html %}

## RegionalRubyKaigi レポート (89) 大阪 Ruby 会議 04

* 日時：2024 年 8 月 24 日 (土) 10:00〜20:50
* 場所：中之島フェスティバルタワーウエスト 4F 中之島会館ホール
* 主催：Kyobashi.rb (キョウバシアールビー)
* 後援：Ruby 関西 (ルビーカンサイ)、日本 Ruby の会
* Togetter まとめ： [https://togetter.com/li/2425167](https://togetter.com/li/2425167)
* 公式タグ・ Twitter：[#osrk04](https://twitter.com/hashtag/osrk04)
* オフィシャルグッズ：[https://suzuri.jp/kyobashirb](https://suzuri.jp/kyobashirb)

![00_all.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/00_all.jpg)

## 大阪 Ruby 会議とは

2018 年 7 月 21 日 (土) に大阪 Ruby 会議 01 がはじめて開催されました。以前までは関西 Ruby 会議という名前で開催していましたが、より地域に密接した Ruby 会議にしようというということになり、ローカルな大阪 Ruby 会議として開催されました。

第 4 回となる今回は大阪市中央区にある[中之島フェスティバルタワーウエスト 4F 中之島会館ホール](https://www.festival-city.jp/) で開催しました。総勢 150 名 (運営スタッフ含む) の方にご参加いただきました。

![01_venue.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/01_venue.jpg)

## セッション

### Opening Talk

* 発表者
  * ydah ([@ydah](https://twitter.com/ydah_))

大阪 Ruby 会議 04 の開催の挨拶をいたしました。

![02_ydah.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/02_ydah.jpg)

### Keynote: 最高の構文木の設計 2024 年版

* 発表者
  * Yuichiro Kaneko 氏 ([@yui_knk](https://twitter.com/spikeolaf))
* 資料
  * [スライド](https://speakerdeck.com/yui_knk/zui-gao-nogou-wen-mu-noshe-ji-2024nian-ban)
  * [ブログ記事](https://yui-knk.hatenablog.com/entry/2024/08/23/113543)

Parser や Parser Generator の未来を探求している金子さんが、現在考えている構文木の設計についてのお話でした。
他の言語の Parser を見ても、それらが生成する構文木に明確な原理原則や設計方針があるとは思えなかったそうで、今回はユースケースを分析し、その骨子をまとめられたとのことです。

LSP (Language Server Protocol) や [RuboCop](https://github.com/rubocop/rubocop) のユースケースを照らし合わせる中で、Ruby が提供する構文木の設計を検討すると、本当に多様なユースケースが存在することが明らかになったそうです。
それらを解決するために、具象構文木 (Concrete Syntax Tree : CST) という抽象構文木では失われる括弧や空白文字といった情報を保持する構文木や、Red Green Tree という [Roslyn](https://github.com/dotnet/roslyn) で発明されたアプローチで、解析した構文を2つの木構造として表現する手法で、多様なユースケースに対応できる構文木の設計を提案されていました。
Ruby の構文木の理想的な姿を考察するだけでなく、これまで人類が見落としてきた設計を Ruby のユースケースに結びつけた金子さんの分析と設計力には、さすがだと感じました。

![03_yui_knk.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/03_yui_knk.jpg)

### dRuby 入門者による あなたの身近にある dRuby 入門

* 発表者
  * makicamel 氏 ([@makicamel](https://twitter.com/makicamel))
* 資料
  * [スライド](https://speakerdeck.com/makicamel/druby-ru-men-zhe-niyoruanatanoshen-jin-niarudruby-ru-men)
ß
dRuby という分散オブジェクトシステムを実現するライブラリについて、入門者の視点から解説していただきました。
分散オブジェクトシステムとは、複数のプロセスやマシン間でオブジェクトを共有できるシステムのことを指します。

身近な例として、[RSpec](https://rspec.info/)、[ActiveSupport](https://railsguides.jp/active_support_core_extensions.html)、[Rabbit](https://rabbit-shocker.org/ja/)、[るりま](https://docs.ruby-lang.org/ja/) でも dRuby が利用されているとのことでした。
トーク全体を通して、dRuby に対するワクワク感が一貫して伝わり、その魅力をより一層感じられる素敵な内容でした。

![04_makicamel.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/04_makicamel.jpg)

### RubyKaigi 公式スケジュールアプリ開発で得た、Hotwire の使い方

* 発表者
  * kinoppyd 氏 ([@kinoppyd](https://twitter.com/kinoppyd))
* 資料
  * [スライド](https://www.docswell.com/s/kinoppyd/5EXNJQ-osaka-ruby-kaigi-04?utm_source=twitter&utm_medium=social&utm_campaign=singlepage)

RubyKaigi の公式スケジュールアプリを開発する中で、[Hotwire](https://hotwired.dev/) を活用した開発の知見を共有していただきました。
前回の [大阪 Ruby 会議 03](https://regional.rubykaigi.org/osaka03/) でも Hotwire に関するセッションがあり、非常に注目を集めている技術であることが伺えます。

注意が必要な点はあるものの、制御をすべて Rails 側で一元化できる点や、HTML のセマンティクスを尊重できる点は非常に魅力的ですね。
直面した課題についても、実際にどのように解決したかを具体的に説明していただいたので、これから Hotwire を導入しようと考えている方にとって非常に参考になる内容だったと思います。
以下のスライドにも、この取り組みについて詳しく紹介されているとのことです。あわせてご覧いただけると、より理解が深まるかと思います。

[https://www.docswell.com/s/kinoppyd/KQ86MW-schedule-select-meets-hotwire](https://www.docswell.com/s/kinoppyd/KQ86MW-schedule-select-meets-hotwire)

![05_kinoppyd.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/05_kinoppyd.jpg)

### ランチタイム

ランチタイムは、会場近くのお店で各自ランチを楽しんでいただきました。

著者がよく訪れる[キッチンルミエール](https://kitchen-lumiere.com/) さんでは、大阪 Ruby 会議 04 当日の 24 日 (土) 限定で、ランチメニューのご飯を 「蘭王の目玉焼きご飯」 に無料で変更できるサービスを提供してくださいました。多くの参加者に喜んでいただけたようで、本当にありがたいご厚意でした。ありがとうございました。

![06_lunch.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/06_lunch.jpg)

### Re-line 〜 IRB・Reline 複数行編集の裏側

* 発表者
  * ぺん！ 氏 ([@tompng](https://twitter.com/tompng))
* 資料
  * [スライド](https://drive.google.com/file/d/19g1BQ9YuTQhr_HYEQk2Ktr9ZIeONSuO9/view)

[IRB](https://github.com/ruby/irb) や [Reline](https://github.com/ruby/reline) のメンテナーであるぺんさんによる、Reline のリアーキテクチャについてのお話でした。
補完候補を表示する際に出力されるダイアログの実装の複雑さを、3D レンダリングの手法を参考にして解消されたとのことです。

一見異なる分野のように見えても、実は繋がりがあるという視点は非常に重要だと感じていて、単にリアーキテクチャの話だけでなく、ぺんさんが開発する際に考えていることや大事にしていることが詰まったお話でした。
「当たり前のことを当たり前にやるとソフトウェアは確実に良くなる」という言葉は、これからもずっと心に留めておきたい言葉です。

![07_tompng.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/07_tompng.jpg)

### Rust で作る TreeSitter パーサーの Ruby バインディング

* 発表者
  * joker1007 氏 ([@joker1007](https://twitter.com/joker1007))
* 資料
  * [スライド](https://speakerdeck.com/joker1007/rustdezuo-rutree-sitterpasanorubybaindeingu)
  * [リポジトリ](https://github.com/joker1007/tree_stump)

[TreeSitter](https://github.com/tree-sitter/tree-sitter) という Rust 製の Parser Generator を Ruby から利用するためのバインディングを作成され、その中で得た知見を共有していただきました。
「[パーフェクト Ruby](https://gihyo.jp/book/2017/978-4-7741-8977-2)」をもし改訂するならば、Rust で書く RubyGem の章を追加したい、そしてその開発方法を身につけておきたいという思いから、今回の発表テーマを選ばれたそうです。

Rust の言語上の制約が Ruby の世界とのやり取りにどのような影響を及ぼすのか、またどのような落とし穴が存在するのかについて丁寧にまとめられており、大変参考になりました。
これから Rust を使って Ruby のバインディングを作成しようと思う方々にとって、非常に有益な資料として長く活用されるのではないかと感じました。

補足については以下のブログ記事にて解説されているので、あわせてご覧いただけるとより理解が深まるかと思います。

[https://joker1007.hatenablog.com/entry/2024/08/26/112124](https://joker1007.hatenablog.com/entry/2024/08/26/112124)

![08_joker1007.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/08_joker1007.jpg)

### 競技プログラミングでみる Ruby の豊かさ

* 発表者
  * haruguchi 氏 ([@haruguchiyuma](https://twitter.com/haruguchiyuma))
* 資料
  * [スライド](https://speakerdeck.com/haruguchi/jing-ji-puroguramingudejian-rurubynoli-kasa)

Ruby で競技プログラミングをされている haruguchi さんによる、競技プログラミングを通じて Ruby の豊かさを感じたというお話でした。
競技プログラミングでは、普段の開発で重視される「可読性」「拡張性」「保守性」といった要素がさほど重要視されないため、普段とは異なるコードを書く楽しみがあるとのことでした。

短いコードで問題に特化した解法を目指す、コードゴルフのような要素も取り入れられており、試行錯誤しながらさまざまな書き方を考える楽しさが伝わってきました。
また、「攻略本に載っていない書き方」を探求する過程は非常に魅力的で、Ruby の多様な表現力を知ることで、より一層その豊かさを実感できる内容でした。

![09_haruguchi.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/09_haruguchi.jpg)

### Minify Ruby Code

* 発表者
  * Koichi ITO 氏 ([@koic](https://twitter.com/koic))
* 資料
  * [スライド](https://speakerdeck.com/koic/minify-ruby-code)
  * [リポジトリ](https://github.com/koic/minifyrb)

JavaScript の UglifyJS や Terser のように、ソースコードのサイズを小さくする Minify 技術を Ruby に適用する取り組みについて紹介していただきました。
発表順は偶然ではありましたが、「同じ振る舞いなら短い方が良い」という観点から、haruguchi さんのセッションともリンクしているように感じ、興味深かったです。

設計方針や選択の理由が明確に説明されており、koic さんがどのように考えながらこの gem を構築したのかを知ることができる内容でした。
さらに、「Minify で壊して RuboCop で直す」という、RuboCop のエッジケース発見ツールとしての活用という展開も含めて、koic さんにしか出来ない話だなと感じました。

![10_koic.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/10_koic.jpg)

### strscan なしで文字列をスキャンする

* 発表者
  * 前田 修吾 氏 ([@shugomaeda](https://twitter.com/shugomaeda))
* 資料
  * [スライド](https://github.com/shugo/OsakaRubyKaigi04/blob/main/slide.md)

[StringScanner](https://docs.ruby-lang.org/ja/latest/class/StringScanner.html) クラスを使わずに文字列をスキャンする方法について解説されています。
StringScanner の基本的な利用方法や正規表現に関する解説を踏まえ、`String#index` や `String#byteindex` の利便性と課題についても掘り下げられていました。

課題に対する解決策として、[提案された MatchData#bytebegin/byteend](https://docs.ruby-lang.org/en/master/MatchData.html#method-i-bytebegin) の紹介と[net-imapの修正の例](https://github.com/ruby/net-imap/pull/286)の解説がありました。
なお、この提案は大阪Ruby会議04をきっかけに提案されたそうで、Ruby 3.4 で導入されています。以下に提案の PR へのリンクを記載します。

[https://github.com/ruby/ruby/pull/10973](https://github.com/ruby/ruby/pull/10973)

![11_shugomaeda.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/11_shugomaeda.jpg)

### どうしてこうなった？から理解するActive Recordの関連の裏側

* 発表者
  * willnet 氏 ([@willnet](https://twitter.com/netwillnet))
* 資料
  * [スライド](https://speakerdeck.com/willnet/dousitekounatuta-karali-jie-suruactive-recordnoguan-lian-noli-ce-3dad1d86-eb47-4b73-9c69-34b66919315b)

Active Record の関連先の自動保存と双方向の関連付けについて、どのような動作になっているのかを解明していくお話でした。

前半では、関連を定義した際にどのようなコールバックが定義され、そのタイミングがいつなのか、また関連先の保存がどのように行われるのかについて、具体的なコード例を交えながら解説されていました。
後半では、双方向の関連付けについて、[inverse_of](https://guides.rubyonrails.org/association_basics.html#inverse-of) の動作が順序立ててわかりやすく説明され、仕組みの理解が深まる内容でした。

また、紹介されていた [save_chain_inspector](https://github.com/willnet/save_chain_inspector) という gem は、関連保存の処理をトレースできるツールとしてとても便利で、双方向の関連を有効にした際のデバッグに非常に有用だと思いました。
さらに、この発表は以下のブログ記事を元にしているとのことですので、あわせてご覧いただけるとより理解が深まるかと思います。

[https://blog.willnet.in/entry/2023/08/07/231704](https://blog.willnet.in/entry/2023/08/07/231704)

![12_willnet.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/12_willnet.jpg)

### Keynote: 令和の隙間産業——PicoRubyはどこから来て、どこへ行くのか

* 発表者
  * Hitoshi HASUMI 氏 ([@hasumikin](https://twitter.com/nethasumikin))
* 資料
  * [スライド](https://slide.rabbit-shocker.org/authors/hasumikin/OsakaRubyKaigi04/)

まつもとさんのスライドスタイルで、角谷さんのようないい話を目指されたとのことでした。
その宣言通り、はすみさんのこれまで歩んできた人生の縮図のようなものが詰まった、素敵なクロージングキーノートでした。

これまでの取り組みやプロダクト（はすみさんが仰るところの隙間産業）を持つに至った経緯、そしてこれまで見てきたことや考えていたことを追体験できる内容だったと思います。
私は個人的には、「ぼくらにはそれぞれ旅に出る理由がある」というスライドの言葉に、深く心を動かされました。

はすみさんが冒頭で宣言された「役に立たない話をする」という宣言をされていましたが、このトークは多くの人の心に響く話であったと思います。

![13_hasumikin.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/13_hasumikin.jpg)

## 公式アフターパーティ

大阪 Ruby 会議 04 の公式アフターパーティは、京橋まで移動し [Restaurant & Cafe GARB DRESSING](https://garb-dressing.com/menu/) さんで開催しました。
当日になって急遽募集したLT大会も行われ、参加者同士の交流が深まる場となりました。

![14_party.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/14_party.jpg)

![15_party.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi04Report/15_party.jpg)

## ご協賛頂いた企業様

[株式会社アジャイルウェア](https://agileware.jp/) [株式会社永和システムマネジメント](https://agile.esm.co.jp) [フリー株式会社](https://www.freee.co.jp) [株式会社インゲージ](https://www.ingage.co.jp/) [株式会社ナレッジラボ](https://knowledgelabo.com/) [ポノス株式会社](https://www.ponos.jp/) [株式会社 Ruby 開発](https://www.ruby-dev.jp/) [株式会社 SmartHR](https://hello-world.smarthr.co.jp/) [株式会社アンドパッド](https://engineer.andpad.co.jp/) [BouqueTec 株式会社](https://www.instagram.com/bouquetec_com/)

## 著者について

### 高田 雄大 ([@ydah](https://twitter.com/ydah_))

大阪市在住、新米 Ruby コミッタ。parse.y に最近住み始めました。

### Special Thanx

本記事の執筆にあたり、フォトグラファーとして大阪 Ruby 会議 04 の運営に参加いただいた [@hachiblog](https://x.com/hachiblog) さんと [@shutooike](https://twitter.com/shutooike) さんに写真を提供いただきました。ありがとうございました。
