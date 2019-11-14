---
layout: post
title: RegionalRubyKaigi レポート (XX) 富山Ruby会議01 レポート
short_title: RegionalRubyKaigi レポート (XX) 富山Ruby会議01 レポート
tags: 0061  regionalRubyKaigi
post_author: noboru-i
created_on: 2020-01-dd
---
{% include base.html %}

## はじめに

北陸初のRegionalRubyKaigiである富山Ruby会議01が、2019年11月に開催されました。  
本記事はその開催レポートです。

なお登壇者名の表記は公式サイトに則っています。

## 開催概要

### テーマ

Rubyと富山を楽しみ知ってもらう

### 開催日

2019-11-03 (日) 11:00 - 18:00

### 会場

富山国際会議場

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/venue.jpg)

### 主催

Toyama.rb

### 参加者

およそ80名

### 公式サイト

<https://toyamarb.github.io/toyama-rubykaigi01/>

### 公式タグ

[#toyamark](https://twitter.com/search?q=%23toyamark)

### ツイートまとめ

[富山Ruby会議01 - Togetter](https://togetter.com/li/1425458)

## オープニング

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/kunitoo.jpg)

## 講演

### 招待講演「○○からRubyへ」

* 発表者
  * 伊藤 淳一
  * [Twitter](https://twitter.com/jnchito)
  * [GitHub](https://github.com/JunichiIto)
* 資料
  * [○○からRubyへ / #toyamark - Speaker Deck](https://speakerdeck.com/jnchito/number-toyamark)
  * [○○からRubyへ・Ruby事始めコーディング動画 #toyamark - YouTube](https://youtu.be/UZE3T5TYAvU)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/jnchito.jpg)

型がない（語弊あり）言語でも、ある言語でも、結局は動作確認するし、テスト・レビューするよね。そんなに変わらなくね？とのこと。  
たしかに、ある程度チームのスキルレベルが高ければ確かにと思う反面、それが不安定な状況では、型の安心感はあるなーと思います。

そのためにスキルアップし、良いコードを書いていく必要があるよね。ということで、"良い"の一つである"読みやすいコード"の話（次のセッション）に続く。

他にも、経験者が語るRubyの利点などが多く、今後比較が必要な場面では見返したら良さそうなスライドでした。

### 「読みやすいコードとRubyらしいコード」

* 発表者
  * 黒曜
  * [Twitter](https://twitter.com/kokuyouwind)
  * [GitHub](https://github.com/kokuyouwind)
* 資料
  * [読みやすいコードとRubyらしいコード](https://slides.com/kokuyouwind/toyama-ruby-01/#/)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/kokuyouwind.jpg)

個人的にも、いつも気にしている"読みやすいコード"について、リーダブルコードからエッセンスを抽出した感じ。  
また、そこに"Rubyらしい"を付け加え、Rubyにおける"読みやすいコード"についての考察。

名前の付け方や処理の書き方など、自分でも気をつけつつ、教育もできるようになっていかないとなーと思いました。

### 「初心者PHPerがRubyキメて思うこと」

* 発表者
  * oratake
  * [Twitter](https://twitter.com/kyosuketakenaka)
  * [GitHub](https://github.com/oratake)
* 資料
  * [初心者PHPerがRuby(+Rails)キメて思うこと - Speaker Deck](https://speakerdeck.com/oratake/chu-xin-zhe-phpergaruby-plus-rails-kimetesi-ukoto)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/oratake.jpg)

初心者に近い視点から、どのようにしてWeb系企業を目指し、学習していったかというお話。  
個人的には、だいぶ昔に通った道、、感がありましたが、今ではRailsチュートリアルが整備されていたり、各種いろんな動画教材があったりと、便利な時代になりましたね。  
ただ、情報がありすぎて、その取捨選択するスキル・良い情報にたどり着くためのスキル、などが必要になるのかなーと。  
そのために、コミュニティに参加するのは良いですね。

### 「Crawler on Rails」

* 発表者
  * suginoy
  * [Twitter](https://twitter.com/suginoy)
  * [GitHub](https://github.com/suginoy)
* 資料
  * [GitPitch Slide Deck](https://gitpitch.com/suginoy/toyama_rubykaigi_01)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/suginoy.jpg)

お昼を挟んでクローラーを作るお話。  
サーバと逆の動作だからRailsを使えるのでは？って発想が面白かったし、実際に意外と使える部品が多いのも面白かったです。  
個人での開発だと、それに合わせた選択が必要だよなーというのは共感しました。  
外部サービスに依存してるアプリケーションでも、外部サービス側の動作が想定外だったり、急に変わったりするので、どこまで厳密にチェックすべきか？というのは考えないといけないよなーと思いました。


### 「TracePointから学ぶRubyVM」

* 発表者
  * joker1007
  * [Twitter](https://twitter.com/joker1007)
  * [GitHub](https://github.com/joker1007)
* 資料
  * [TracePointから学ぶRubyVM - Speaker Deck](https://speakerdeck.com/joker1007/tracepointkaraxue-burubyvm)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/joker1007.jpg)

ガチ枠。  
写真撮りながらというのもあったけど、おそらく半分も理解できてない気がします。  
（そもそも、TracePointとは？ってのが、いまいち理解できてない気がする。）  
わからないなりに、「プログラムもプログラムで動いている」ということが改めて実感できた気がします。  
また、これだけ強い人でもコードから変数名の意味は推測するしかないということだったので、コメントだったり略さないことだったりは大事だなーと思いました。

### 「北陸で Ruby なお仕事に携わるための3つの戦略」

* 発表者
  * 清原 智和
  * [Twitter](https://twitter.com/kiyohara)
  * [GitHub](https://github.com/kiyohara)
* 資料
  * [北陸で Ruby なお仕事に携わるための3つの戦略 - Speaker Deck](https://speakerdeck.com/kiyohara/bei-lu-de-ruby-naoshi-shi-nixi-warutamefalse3tufalsezhan-lue)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/kiyohara.jpg)

エモい話枠。  
特に地方だと、自分のやりたい仕事をやりたければ、いろいろ越境しないと難しいよね、という話。  
実際に経験したことがベースの話だったので、かなり納得感のある話だった。  
とはいえ、自分にここまでできるのか？という気持ちも大きいので、今の会社を辞めたとしても、リモートできる企業を探そう、、、というきもちになりました。

### 「業務で！Rubyを！キメる！」

* 発表者
  * 伊藤 浩一
  * [Twitter](https://twitter.com/koic)
  * [GitHub](https://github.com/koic)
* 資料
  * [Project automation for internal affairs - Speaker Deck](https://speakerdeck.com/koic/project-automation-for-internal-affairs)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/koic.jpg)

ちょっとしたツール（ワンショットのツール）であれば、比較的自由に技術選定しやすく、やりたいことをやりやすいという話。  
個人的には静的解析とかにちょっと興味があり、RuboCopの話に興味があったけど、想定外の使い方で面白かったです。  
ASTってちゃんと見たことなかったんですが、説明を聞いているとなんとなーく読めそうな気はしてきました。

### 「mrubyでハローワールド！」

* 発表者
  * 羽角 均
  * [Twitter](https://twitter.com/hasumikin)
  * [GitHub](https://github.com/hasumikin)
* 資料
  * [mruby de Hello World! - HASUMI Hitoshi - Rabbit Slide Show](https://slide.rabbit-shocker.org/authors/hasumikin/ToyamaRubyKaigi01/)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/hasumikin.jpg)

弊社からのスピーカースポンサーということで、mrubyの話。  
mrubyとかmruby/cが別ということは知っていたけど、ROMやRAMの使用量も違っているとのこと。  
その分制約も違うので、使う場所にあわせて考える必要がありそう。  
そこから、コンパイラを作る話になったけど、わかるようなわからんような。。。  
ただ、順々に説明されることで、なんとなくの流れはわかったような気がしました。

### LT

#### LT

* 発表者
  * muryoimpl
  * [Twitter](https://twitter.com/muryoimpl)
  * [GitHub](https://github.com/muryoimpl)
* 資料
  * [RSpec導入奮戦記/The struggle of introducing RSpec - Speaker Deck](https://speakerdeck.com/muryoimpl/the-struggle-of-introducing-rspec)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/LT_muryoimpl.jpg)

Rspecでのテストコードを、短期集中で増やしていく話。  
テストを広めていくための方法や、その際に気をつけたことが紹介されていました。  
自分もテストを書いて、広めていかないとなーと思っているので、参考になりました。

#### LT

* 発表者
  * ふぁらお加藤
  * [Twitter](https://twitter.com/PharaohKJ)
  * [GitHub](https://github.com/PharaohKJ)
* 資料
  * [俺 と Ruby - Speaker Deck](https://speakerdeck.com/pharaohkj/an-to-ruby)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/LT_PharaohKJ.jpg)

個人事業主として、なぜRubyを選択するのか？という話。  
Rubyで仕事してる人は、比較的こだわりの強い人が多く、ハズレが少ない印象とのこと。  
個人的には、Ruby書いている人たちは、そういう層と、"Railsでしか書けない層"に大きく二分されると思ってるので、そこだけ見分けられれば、いい感じの人と仕事できそうというのは納得。

#### LT

* 発表者
  * 相生ゆら
  * [Twitter](https://twitter.com/Little_Rubyist)
  * [GitHub](https://github.com/Little-Rubyist)
* 資料
  * [元富山県民から見たRubyコミュニティ - Speaker Deck](https://speakerdeck.com/littlerubyist/yuan-fu-shan-xian-min-karajian-tarubykomiyunitei)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/LT_Little_Rubyist.jpg)

富山弁枠。かつ初心者枠。  
実務経験4ヶ月で、この規模の会場でLTしたのはいい経験だろうなーと思いました。  
パーフェクトRuby読んで、アルゴリズムの問題をゲーム感覚で解き、Railsチュートリアルをサクサク進められるって、かなり優秀なのでは。。？と思いました。

#### LT

* 発表者
  * wtnabe
  * [Twitter](https://twitter.com/wtnabe)
  * [GitHub](https://github.com/wtnabe)
* 資料
  * [join-kanazawarb-or-7years-passed-since-it-was-borned - Speaker Deck](https://speakerdeck.com/wtnabe/join-kanazawarb-or-7years-passed-since-it-was-borned)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/LT_wtnabe.jpg)

地方勉強会の歴史の話など。  
Kanazawa.rbは7年継続しているとのこと。すばらしい。  
地方で"Ruby"で完全に縛ったコミュニティ・勉強会を開いてもつらいのは、全力で同意。（そもそも、自分もそんなにRubyを書かない）  
最近行けてなかったのですが、Kanazawa.rbも久々に参加したくなりました。

#### LT

* 発表者
  * Yuka Kato
  * [Twitter](https://twitter.com/yucao24hours)
  * [GitHub](https://github.com/yucao24hours)
* 資料
  * 公開されておらず

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/LT_yucao24hours.jpg)

Capybaraの裏側の話。あと、Capybaraのかんたんなおさらい。  
BrowserとDriverにいろいろ種類があって、用途によって選ばないとなーと思いました。  
PhantomJSがメンテ終了してたのは聞いたことあった気がしますが、それに引きづられる形でDriverも世代交代してる？  
次に使うことがあったら、Apparitionはちょっと調べてみようと思いました。

#### LT

* 発表者
  * 水尻裕人
  * [Twitter](https://twitter.com/mizukmb)
  * [GitHub](https://github.com/mizukmb)
* 資料
  * [RUBYでアッカーマン関数の計算をがんばる方法 / How to write ackermann function in ruby - Speaker Deck](https://speakerdeck.com/mizukmb/how-to-write-ackermann-function-in-ruby)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/LT_mizukmb.jpg)

アッカーマン関数って、聞いたことあるようなないような、、ぐらいでしたが、たしかにまともに計算できなさそう。  
再起って、アプリケーション開発ではあんまり使うことがないけど、いざ使うとなるとテクニックが必要になるので、覚えておいて損はなさそう。  
最適化オプションつけてみたけどだめでした -> Ruby自体のコンパイル時に指定が必要だよ（うろ覚え）的なツッコミがすぐに入るあたり、すごく強い人達を呼べたんだなーと再認識しました。

#### LT

* 発表者
  * よしだ たけひこ
  * [Twitter](https://twitter.com/chihayafuru)
  * [GitHub](https://github.com/chihayafuru)
* 資料
  * [RubyによるC言語コードのメトリクス測定](https://chihayafuru.github.io/toyamark/)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/LT_chihayafuru.jpg)

組み込みエンジニアが、本業のすぐ隣の開発（調査）ツールとして、Rubyを使う話。  
小さなプログラムをかんたんに動かせて、正規表現がさくっと使えて、外部のライブラリもかんたんに導入できるということで、ちょっとした調査ツールには確かに良さそうですね。  
で、厳密なツールを作るのは難しいものでも、用途に合わせて、人力の補助ツールとして作るのは良さそうですね。

#### LT

* 発表者
  * 羽角 均
  * [Twitter](https://twitter.com/hasumikin)
  * [GitHub](https://github.com/hasumikin)
* 資料
  * 無し

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/LT_hasumikin.jpg)

2度目の登場。  
先程の発表で入ってなかった、Generate Codeの部分のライブコーディング？  
vimでライブでバイナリ列を書いていくという荒業に出て、なんとなくやりたいことはわかったけど、途中のハプニングで完成できずに終了でした。  
なんとなく、バイナリ列がどうなっているか？が、わかったような、わからんかったような。

### 招待講演「型なし言語のための型」

* 発表者
  * 松本 宗太郎
  * [Twitter](https://twitter.com/soutaro)
  * [GitHub](https://github.com/soutaro)
* 資料
  * [型なし言語のための型 - Speaker Deck](https://speakerdeck.com/soutaro/xing-nasiyan-yu-falsetamefalsexing)

![]({{base}}{{site.baseurl}}/images/0061-ToyamaRubyKaigi01Report/soutaro.jpg)

最後に今後のRubyの話。  
Ruby3で型を入れようとしていることは知っていたけど、パフォーマンスが目的ではないというのは知らなかった。  
型関連の歴史についても全然気にしたことがなかったので、型推論が思ってたよりも昔からあったことには驚きました。  
最初の招待講演で好きなメソッドとして挙げていた `map` が、最後の招待講演で邪魔者扱い（語弊）されていたのが面白かったですね。  
Union typesやflow-sensitive typingなど、"型なし言語のための型"として必要な要素を徐々に理解できました。  
TypeScriptの成功は、たしかに特異なことだったんだと、なんとなく理解できました。  
「人類は型を書く」ってのは確かに面白いと思いました。型を書かなくて済んでいたJavaScript界隈で、これだけTypeScriptが流行っているのが面白いなと。  
TypeScriptは、センスよく型を解決しているんだなーと感じました。  
型なし言語に型を導入するという意味で、 `incompatible`という指定の必要性は理解できるけど、もともと型のあるJavaから入った自分としてはなんだかなーという思いもあったりします。

## スポンサー

* 会場スポンサー
  * [株式会社永和システムマネジメント](https://agile.esm.co.jp/)
* 懇親会スポンサー
  * [株式会社Misoca](https://www.misoca.jp/)
* スピーカースポンサー
  * [株式会社 モンスター・ラボ](https://monstar-lab.com/)
* 招待講演スポンサー
  * [株式会社ソニックガーデン](https://www.sonicgarden.jp/)

## まとめ

懇親会でも話に上がりましたが、発表の順番が絶妙だったと思います。

別言語からRubyに入った話・Rubyの良さの話  
↓  
Rubyらしいコードの話  
↓  
初心者がRubyに抱いた感想  
という比較的初心者向けのセッションを午前中に聞いて、  
Rubyでちょっと変わったアプリケーションを作る話  
↓  
RubyVMの話で深淵をちょっと見せて  
↓  
頭使ったところで、北陸（地方）特有のエモい話  
↓  
エモい話入れつつ、ちょっとASTの話  
↓  
mrubyをベースに、言語の作り方の話  
↓  
LTでちょっと閑話休題  
↓  
型のがっつりした話

という感じで、緩急つけつつ、前に聞いたことがちょっとずつ関連する流れでした。

## Toyama.rbについて

[connpass](https://toyamarb.connpass.com/)

富山県とその周辺地域のRubyistのためのコミュニティです。 主催者は [@mugi_uno](https://twitter.com/mugi_uno) です。  
富山市内を中心に活動しています。

もくもく会をメインに活動しています。  
もくもくと好きな作業をしつつ、参加者同士での交流を深めましょう！というのが目的です。  
不定期にもくもく会以外のイベントをやったりもしています。  
終了後には懇親会もあるよ！

基本的には毎月第２土曜日の日中の開催としています。 1ヶ月前には募集ページができるので、そこから申し込んでね！

参加に制約はありません、どなたでもウェルカムです。

* Ruby初心者でもOK
* というか主催者が初心者です
* 熟練者ももちろんOK
* もはやRubyじゃなくてもOK
* と言うかもうなんでもOK（読書します！とかでも大丈夫）

Toyama.rbをなぜ作ったのか？  
そこにコミュニティがなかったからさ！  
富山では決して多くないRuby案件。 でもRubyが好きでもいいよね！

## 著者について

石倉 昇 ([@noboru_i](https://twitter.com/noboru_i)) 富山Ruby会議01 写真係 兼 レポート係。  
フルリモート会社員。
