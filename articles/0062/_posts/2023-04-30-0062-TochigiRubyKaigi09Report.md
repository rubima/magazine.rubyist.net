---
layout: post
title: RegionalRubyKaigi レポート (81) とちぎ Ruby 会議 09
short_title: RegionalRubyKaigi レポート (81) とちぎ Ruby 会議 09
tags: 0062 TochigiRubyKaigi09Report regionalRubyKaigi
post_author: gadgdiler
created_on: 2023-04-30
---

{% include base.html %}

## とちぎ Ruby 会議 09 レポート

独学のプログラミングに限界を感じているアナタ！とちぎ Ruby 会議で一緒に学びまショウ！ドーモ！application/json デス！

2020 年 9 月 12 日、今年もやってまいりましたとちぎ Ruby 会議。今回は 9 回目記念ということで、なんと！オンライン・オフラインの同時開催となりました！オフ会場となったのはお馴染み栃木県大田原市にある那須野が原ハーモニーホール。ここから ZOOM によるオンライン配信と Discord によるチャットという 2 元中継で全国にお届けします。実はとちぎ Ruby 会議 02 でも配信したことがあったそうですが、さっぱり覚えていません。

そんなわけで設営もいつもと違う雰囲気。これまではゲストは来たらすぐさまイス並べに駆り出されるという「これが栃木の洗礼だ！」といわんばかりの情景が繰り広げられていましたが、今回は toruby の面々でカメラやマイクなどの慣れない機材の設置にてんてこ舞い。けれども、予行演習をしていたこともあり、どうにかほぼ定刻どおりに前座がはじまりました。

ちなみに文章中の ID は敬称略とさせていただきます。恐縮でっす！

### 前座

今回はいつもの前座と趣向を変えて「謎の @m_seki チームの実態に迫る！」ということで @miwa719 が @m_seki チームの後輩メンバー 2 人に生インタビューする回となりました。果たして @m_seki チームは実在するのか？実はアジャイラーのネバーランドではないか？そうした疑問に 2 人が答えます。ちなみに前編。

数少ない写真の１つのインタビュー風景：

![]({{base}}{{site.baseurl}}/images/0062-TochigiRubyKaigi09Report/interview.jpg)

### はじまり

今回はいつもの前座と趣向を変えて「謎の @m_seki チームの実態に迫る！」ということで @miwa719 が @m_seki チームの後輩メンバー 2 人に生インタビューする回となりました。果たして @m_seki チームは実在するのか？実はアジャイラーのネバーランドではないか？そうした疑問に 2 人が答えます。ちなみに前編。

数少ない写真の１つのインタビュー風景：

### ライトニングトーク

本会の最初の演目はライトニングトークです。トップバッターはそのまま司会の @vestige* です。@vestige* といえばとちぎ Ruby 会議名物のタイマーですが、今回は Discord 上で動きます。ただ、それをどうやってみんなに知らせるかで四苦八苦です。

ライトニングトークの 2 番手は @track8。@track8 といえば前座。彼の前座を楽しみにしていた人も多いでしょうが、残念なことに今回はオンもオフも不参加。その代わりに手紙(のようなスライド)を託し、@vestige\_ が代読します。ソフトウェアの寿命の話ということで興味シンシンでしたが、話に入る前で時間切れ！次回に続く商法許すまじ！

次にとちぎ Ruby 会議実行委員長係の @mame による [Smalruby](https://smalruby.jp/) の紹介。@mame はプライベートで子どもたちにプログラミングを教える活動をしているとのことで、そこで Smalruby も使えるのではないかと期待しているそうです。

続いて @kakutani の [DIY キーボードの話](https://speakerdeck.com/kakutani/diykeyboard-is-ruby)。最近ではアジャイルおじさん卒業宣言してキーボードいじりの日々のようですが、なんのなんの、つい先日『[Clean Agile 基本に立ち戻れ](https://www.amazon.co.jp/Clean-Agile-基本に立ち戻れ-Robert-C-Martin/dp/4048930745/ref=asc_df_4048930745/?tag=jpgo-22&linkCode=df0&hvadid=342397001181&hvpos=&hvnetw=g&hvrand=1926361390811544102&hvpone=&hvptwo=&hvqmt=&hvdev=m&hvdvcmdl=&hvlocint=&hvlocphy=9053353&hvtargid=pla-945219738910&psc=1&th=1&psc=1&tag=&ref=&adgrpid=72867581430&hvpone=&hvptwo=&hvadid=342397001181&hvpos=&hvnetw=g&hvrand=1926361390811544102&hvqmt=&hvdev=m&hvdvcmdl=&hvlocint=&hvlocphy=9053353&hvtargid=pla-945219738910)』を訳したばかり。世界はまだ @kakutani を必要としている！

ここで @arton が登場して [Rails + RSpec + Capybara](https://www.slideshare.net/artonx/railsrspec-capybara) というビジネスワールドに一気に突入。お仕事タイヘン！といってもブラウザドライバの愚痴を聞いただけだったような…

次はおしょーさんによる [Struct](https://speakerdeck.com/osyo/jin-geng-wen-kenai-struct-falseshi-ifang-tojin-hou-falseke-neng-xing-nituite) の話。近々 Struct が便利に使えるようになるかも？とのこと。Anonymous Struct Literal は JavaScript のオブジェクトリテラルっぽくて好きです。Hash？Hash は Hash でオブジェクトじゃねーだろ！

ライトニングトークの最後は @m_seki で、RubyKaigi Takeout 2020 で話された「[Rinda in the real-world embedded systems.](https://speakerdeck.com/m_seki/rinda-in-the-real-world-embedded-systems)」の続きです。これは次回に続く商法の正しい活用法！

### 後座

ライトニングトークが終わってここで前座の後編。@miwa719 はさらに @m_seki チームの真相に迫るのであった！(賢明な読者は気づいたであろうが、インタビューの詳細は参加者特典なのだ！)

### 基調講演

基調講演は @igaiga555 の「[考えるのはたのしい](https://speakerdeck.com/igaiga/tork09igaiga)」。@igaiga555 は度々来那須していて、この基調講演は @mame のたっての願いがようやく叶った形です。今回の話は「とちぎ Ruby 会議らしく、モヤモヤ考えることを楽しむ」という趣旨です。@igaiga555 といえば『[パーフェクト Ruby on Rails](https://www.amazon.co.jp/パーフェクト-Ruby-Rails-【増補改訂版】-Perfect/dp/4297114623)』をはじめ、Rails 関係の書籍を何冊も執筆しています。また、[フィヨルドブートキャンプ](https://bootcamp.fjord.jp/) という教育事業の顧問にも就いています。そうした執筆や事業の継続性だったりをブレスト的にモヤモヤと考え楽しむお話でした。

### 閉会

基調講演が終わりいよいよクロージングです。@mame から挨拶があり、オフ会場の参加者が各々感想を述べてとちぎ Ruby 会議 09 はしめやかに閉会したのでした。

### りんごジュース

撤収するときにオフ会場の参加者にはりんごジュースが配られたのでした。これは、今回残念ながらキャンセルとなった長野県松本市で開催される予定だった RubyKaigi 2020 で大々的に配られるはずだった[宮本ファームのりんごジュース](https://www.facebook.com/Miyamotofarm/)を分けていただいたものでした。これマジうめー！りんごのエナジーでいっぱいになりました。

### 感想

さて、会議を終えての感想ですが、筆者はオフ会場にいてオンの様子をほとんど知ることはありませんでした。あとで聞いたところによると、ZOOM には 40 名ほどの参加者がいたようです。初見さんもいたそうで予想以上に多くてビックリしました。ただ、オフ会場のだだっ広いホールにスタッフとゲスト合わせて 10 人もいない状況は、なかなか熱を感じにくかったです。オンとオフとをうまくつなげればとちぎ Ruby 会議らしいワイワイガヤガヤした雰囲気をオンにもオフにも広げられるかなと思いました。

それにしても今回はタイマーよりも miwa タイムキーパーのほうが活躍してましたな。ガハハ！

あ、そういえば今回、@awazeki は早退してライトニングトークにも出てなかったんだった！@awazeki ファンのために彼の新しいホムペを紹介しておくよ。

[有限会社情報デザイン](http://www.jdesign.co.jp/)

### 謝辞

オンラインで参加された方、オフラインで参加された方、わざわざお越しいただきありがとうございました。日本 Ruby の会にもいつもお世話になっています。toruby のメンバー(後輩 2 名も含む)もお疲れさまでした。

また次回、オンになるかオフになるかわかりませんが、お会いできるのを楽しみにしています。

**ホワーイとちぎ Ruby カイギ～！**

### 著者について

@gadgdiler toRuby の一般メンバー。Nagano.rb で那須のお土産を置き逃げしたのは自分です。
