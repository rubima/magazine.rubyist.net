---
layout: post
title: RegionalRubyKaigi レポート (65) とちぎ Ruby 会議 07
short_title: RegionalRubyKaigi レポート (65) とちぎ Ruby 会議 07
tags: 0057 TochigiRubyKaigi07Report
---
{% include base.html %}

## とちぎRuby会議07 レポート

### 書いた人

gdgdiler@toRuby

### はじめに

日時
:  2017/08/26(土) 11:00 ～ 20:00

会場
:  那須野が原ハーモニーホール

主催
:  とちぎRubyの会(toRuby)

後援
:  日本Rubyの会

参加者
:  約50名

### 口上

元気ですかーーッ？！元気があれば何でもできる！

去る8.26、[那須野が原ハーモニーホール](http://www.nasu-hh.com/)において[とちぎRuby会議07](http://regional.rubykaigi.org/tochigi07/)が開催されました。那須野が原ハーモニーホールは大田原市にありますが、大田原市と旧西那須野町(現那須塩原市)が全国初の自治体共同文化会館として建てられた、由来も外観も非常に美しい会場であります([Wikipedia](https://ja.wikipedia.org/wiki/%E9%82%A3%E9%A0%88%E9%87%8E%E3%81%8C%E5%8E%9F%E3%83%8F%E3%83%BC%E3%83%A2%E3%83%8B%E3%83%BC%E3%83%9B%E3%83%BC%E3%83%AB))。

### 前座

AM11:00開場ということで、希望者には[からあげ専門店マルトク](https://ja-jp.facebook.com/marutoku11/)のからあげ弁当が会場で販売されました。これが田舎の弁当らしく、味は悪くないが量で攻めるタイプの弁当。年齢層高めな人が多い会場は早くもグロッギーか？！

そんな会場の雰囲気を一掃しようと登場したのが前座の@track8！当日の登壇者を80年代のプロレスラーに喩えて紹介するという荒技！胃もたれした聴衆も一気にヒートアップ！その仕事っぷりは80年代に前座で会場を沸かした[永源遙](https://ja.wikipedia.org/wiki/%E6%B0%B8%E6%BA%90%E9%81%99)を彷彿とさせるものでありました。
![tochigi07_track8_m.jpg]({{site.baseurl}}/images/0057-TochigiRubyKaigi07Report/tochigi07_track8_m.jpg)

まだ前座は続きます。[toruby](https://toruby.doorkeeper.jp/)の重鎮、@m_sekiの登場です！重鎮自ら前座を買って出る姿は、還暦を迎えてなおもリングに上がり続けた[ジャイアント馬場](https://ja.wikipedia.org/wiki/%E3%82%B8%E3%83%A3%E3%82%A4%E3%82%A2%E3%83%B3%E3%83%88%E9%A6%AC%E5%A0%B4)を彷彿とさせます。そして、その@m_sekiのネタはなんと(リアルな)カードゲーム「[ショッピングモール](http://gamemarket.jp/game/%E3%80%90%EF%BD%9110%E3%80%91%E3%82%B7%E3%83%A7%E3%83%83%E3%83%94%E3%83%B3%E3%82%B0%E3%83%A2%E3%83%BC%E3%83%AB/)」！しかも、会場でそのカードゲームを購入できるというダイレクトマーケティングっぷり！今や定番ムーヴとなった旅費ネタをぶっ込むのも忘れません！
![tochigi07_seki_m.jpg]({{site.baseurl}}/images/0057-TochigiRubyKaigi07Report/tochigi07_seki_m.jpg)

### 一般講演
![tochigi07_emori_m.jpg]({{site.baseurl}}/images/0057-TochigiRubyKaigi07Report/tochigi07_emori_m.jpg)

さて、休憩をはさんでここから一般講演です。まずは@emorimaさんの「"mission critical"なシステムでも使えるThreadの作り方」の話です。防災情報をリアルタイムで処理するために100個のプロセスで各々100個のスレッドを回すという野心的なシステムだそうで、開発当初はruby 1.8系だったとのこと。1.8系というとまだ[グリーンスレッド](https://ja.wikipedia.org/wiki/%E3%82%B0%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B9%E3%83%AC%E3%83%83%E3%83%89)の時代。さすがにそれを聞いて@artonさんから「そりゃムチャだ！」とのツッコミが。[YARV](http://magazine.rubyist.net/?0006-YarvManiacs)が導入されてからRubyのスレッド周りは大きく改善されたものの、今でも[ジャイアントインタプリタロック](https://ja.wikipedia.org/wiki/%E3%82%B0%E3%83%AD%E3%83%BC%E3%83%90%E3%83%AB%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%97%E3%83%AA%E3%82%BF%E3%83%AD%E3%83%83%E3%82%AF)の話題が出るなど、Rubyにとってスレッドは鬼門の１つ。ご苦労が忍ばれます。
![tochigi07_arton.jpg]({{site.baseurl}}/images/0057-TochigiRubyKaigi07Report/tochigi07_arton.jpg)

続いて@artonさん。実際に仕事であった厄介事をRubyで簡単に解決できたよという話。Rubyのスクリプト言語としての側面に改めてスポットを当てました。AIだなんだと世間は騒ぎますが、身近な厄介事はなくならないし、そんなときにはやっぱりスクリプト言語が頼りになります。

そうそう、@artonさんといえば[オペラがお好き](https://www.artonx.org/diary/20170409.html#p01)で。それで失礼ながら「オペラってストーリー(結末)は知ってて見るものですよね？どこらへんが面白いんですか？」って尋ねたんですよ。そうしたら@artonさんは「プログラムと同じよ。仕様が一緒でも実装は人によって違うじゃん？その違いを楽しむんだよ！」といったことを[おっしゃってました](https://www.artonx.org/diary/20170827.html#p01)。
![tochigi07_gotoken_m.jpg]({{site.baseurl}}/images/0057-TochigiRubyKaigi07Report/tochigi07_gotoken_m.jpg)

@artonさんのあとを受けて@gotokenさん。もやもやした話。そのタイトルのとおり、つかみどころのない話でしたけど「それ、わかるぅ～！」な内容。結局のところ「なぜRubyを使うのか？」ということになるんですけど、「pがいい」とか「ブロックがいい」とか、理由を１つ１つあげていくこともできるんですけど、やっぱり全体的なもやもやとした部分でRubyが好きということなんでしょうね。それは言語だけでなく、コミッタやユーザといった社会的な側面も含めて。

@gotokenさんともお話させていただいたんですけど、「Windows 10いいよ～。仮想環境いらないって素晴らしい！」とおっしゃってました。例によってこういう夏フェスなんかではマカーが多いわけで、貴重なご意見ありがとうございました。それと、お仕事の関係で文字エンコーディングを扱うことも多いらしく、「Rubyの多言語化がんばった人たち、エライ！」と熱弁されてました。
![tochigi07_ardbeg1958_m.jpg]({{site.baseurl}}/images/0057-TochigiRubyKaigi07Report/tochigi07_ardbeg1958_m.jpg)

続いて@ardbeg1958さん。@ardbeg1958さんには何度もとちぎRuby会議で講演していただいています。今回は[形式仕様記述](https://ja.wikipedia.org/wiki/%E5%BD%A2%E5%BC%8F%E4%BB%95%E6%A7%98%E8%A8%98%E8%BF%B0)について。スケジュールの都合上、さすがに時間が少なく、サワリ程度の話で終わってしまいました。これを機会に形式仕様記述についてみなさんが興味を持っていただければと願います。

講演後、@ardbeg1958さんに前から抱いていた疑問を聞いてもらいました。「オブジェクト指向と形式仕様記述ってどういうつながりなんですか？」いただたお答えは「[Eiffel](https://ja.wikipedia.org/wiki/Eiffel)の[契約プログラミング](https://ja.wikipedia.org/wiki/%E5%A5%91%E7%B4%84%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0)が形式仕様記述のはじまりなんですよ」。なるほど！Eiffelといえば@ardbeg1958さんが翻訳された名著「[オブジェクト指向入門](http://www.shoeisha.co.jp/book/detail/9784798111117)」がありました。やっぱり人の仕事ってつながりがあるものなんですね。

答えがいただけたので調子に乗って「形式仕様記述ってたまに聞きますけど、あんまり流行ってませんよね？」とぶしつけにお尋ねしたんですね。そしたら怒られることもなく穏やかに「[Felicaの開発でVDM++が採用されて劇的な効果があった](https://www.ipa.go.jp/files/000005473.pdf)りと実証例はあるのですが、上層部が導入しようとしても現場側で拒否されることが多いようです」とのこと。このあたりはかなり前のオブジェクト指向に似た状況だと感じました。

ついでといっては失礼ですが、もう１つ疑問があって、「AIって[関数型言語](https://ja.wikipedia.org/wiki/%E9%96%A2%E6%95%B0%E5%9E%8B%E8%A8%80%E8%AA%9E)と相性がいいように思えるんですけど、関数型言語でAIってあんまり聞かないのはなぜなんでしょうか？」それに対しては「Pythonが関数型言語的に代用されているのではないか」とのことでした。なるほどぉ。命令型言語が関数型言語のエッセンスを取り入れるというのは、Rubyをはじめ、よくあることですけど、そういう動きが関数型言語のシェアを食っている面があるんでしょうかね。

### 招待講演

#### @chomado + @okazuki
![tochigi07_chomado_m.jpg]({{site.baseurl}}/images/0057-TochigiRubyKaigi07Report/tochigi07_chomado_m.jpg)

ここから招待講演。@chomadoさんから。まずは自己紹介を兼ねて[はしれ！コード学園](https://codeiq.jp/magazine/category/programminggirls/)の紹介。いつもはC#の人たちをお相手されることが多いようで、Rubyの、しかも年齢層高めな人たちが聴衆ということで、ちょっと緊張気味でしたか。続いて紹介されたのが「松屋警察」。[松屋](https://www.matsuyafoods.co.jp/menu/)を愛する@chomadoさんが牛めしを判定するために作り出したスマホアプリ。その実装にはMicrosoftの[Custom Vision Service](https://azure.microsoft.com/ja-jp/services/cognitive-services/custom-vision-service/)と[Xamarin](https://www.xamarin.com/)が使われています。デモは、[Mac上のVisual Studio](https://www.visualstudio.com/ja/vs/visual-studio-mac/)で行われて、接続されたiPhoneの画面もリアルタイムに取り込まれていました。写真判定もバッチリ成功！
![tochigi07_kazuki_m.jpg]({{site.baseurl}}/images/0057-TochigiRubyKaigi07Report/tochigi07_kazuki_m.jpg)

で、@chomadoさん、さすがにRubyの話が出ないまま終わってはマズいと思ったのか(toruby的には全然OKなんですけど)、助っ人にバトンタッチとなりました。@okazukiさん、Xamarinガチ勢。@chomadoさんからの急な依頼であったにもかかわらず、サラサラッと書いたRubyで、Custom Vision Serviceにアクセスして、デモもバッチリ成功！オマケに[Microsoft](https://github.com/Microsoft)のイメージアップにも成功！

RubyからCustom Vision Serviceにつないだデモは、非常に「スクリプト言語らしい」と感じました。RubyはAIに出遅れている観がありますが、こうやってRESTで叩けるAIエンジンがあれば、Rubyのようなスクリプト言語でもイケるわけです。そして、AIといえども、いや、AIは競争が激しい分、コモディティ化は避けられなくて、ますますスクリプト言語の需要は高まり、それをPythonだけで補うわけにもいかないと思うのです。

余談なんですけど、あとで「なぜ@chomadoさんを呼ぼうと思ったの？」って聞いたら、@miwa719さんが「@chomadoさんの[デブサミでのお話](http://event.shoeisha.jp/devsumi/20170216/session/1282/)が素晴らしかったの！」といってました。

#### @shugomaeda
![tochigi07_shugo.jpg]({{site.baseurl}}/images/0057-TochigiRubyKaigi07Report/tochigi07_shugo.jpg)

招待講演2人目は@shugomaedaさん。ピュアRubyで書かれたテキストエディタ、[texbringer](https://github.com/shugo/textbringer)の話。cursesライブラリを使った端末上で動作するEmacsライクなテキストエディタです。[cursesライブラリ](https://ja.wikipedia.org/wiki/Curses)というのはUnix由来の端末制御ライブラリです。@shugomaedaさんは、そのライブラリをRubyから利用する[curses gem](https://github.com/ruby/curses)の開発者でもあります。curses gemはもともとは標準添付ライブラリで歴史も古いのですが、そもそも@shugomaedaさんがcursesライブラリに手を出したのは「いつかテキストエディタを作りたい」と思ったからでした。それが20年前の話。その夢がようやく叶ったわけです。

エディタの名前の由来の中二的な話や、細かい技術的な話もされていたのですが、個人的に「おっ！」と思ったのは「The Craft of Text Editing」の情報でした。この本、テキストエディタの製作者にはバイブルみたいなものとして有名だったのですが、日本語訳は絶版になったものの、[原書はネットで公開されている](https://www.finseth.com/craft/)そうです。

#### @mametter
![tochigi07_mame.jpg]({{site.baseurl}}/images/0057-TochigiRubyKaigi07Report/tochigi07_mame.jpg)

招待講演3人目は@mametterさん。「Rubyでつくる型付Ruby」の話。Ruby 3.0では静的型が導入される可能性があり、どのような実装になるかという話でした。今回紹介されたのは[漸進的型付け](http://qiita.com/t2y/items/0a604384e18db0944398)で、これなら既存のコードを壊さなくて済むのでいいとのことでした。

ところで、静的型には「ドキュメンテーション」と「静的型チェック」の２つの役割が紹介されていましたが、個人的には「最適化」が本命ではないかと思っています。意外にもRubyにはスピード狂がたくさんいるということがわかりましたから。そういう@mametterさんご自身も[ファミコンのエミュレータでベンチマーク](https://github.com/mame/optcarrot)というスピード狂を煽る作品を公開されています。

### 勉強会

講演だけで終わらないのがとちぎRuby会議。全員参加の勉強会の時間です。テキストは@mametterさんの「[RubyでつくるRuby](https://www.lambdanote.com/products/ruby-ruby)」。この本の特徴は、プログラミング言語処理系の作成では面倒で挫折しやすい字句解析の部分をできるだけ省いて、構文木の評価から話を本格的に進めている点です。

当日の勉強会では、その構文木の基礎となる木構造を理解する第3章を読みました。@mametterさんが本を読み上げて、そのあとみんなでサンプルコードを写経するというスタイルです。木構造ということで再帰が避けられませんが、@mametterさん曰く「再帰を理解するならフィボナッチより木構造のほうがいいです」とのこと。

### パーティーとLT

勉強会が終わったあとは、会場内に用意されたビュッフェでパーティー。料理は大田原の[リトルアンジェリカ](https://ja-jp.facebook.com/angeloitaliana/)さんに用意してもらいました。

みんなで料理をいただきながらLTがはじまりました。LTへの参加は自由で、ボードに名前を書くだけ！しかも何回でもしゃべれる！さらにLTの参加賞として、各社からご提供いただいた書籍やノベルティグッズがもらえる！まさにしゃべらにゃ損損なLT大会。

今回書籍やノベルティをご提供いただいた各出版社の方々に感謝いたします。以下、@m_sekiさんのブログからです(M-x sort-lines順)。

+ [とちぎRuby会議07書籍プレゼント紹介オライリー編](http://druby.hatenablog.com/entry/2017/08/08/204448)
+ [とちぎRuby会議07書籍プレゼント紹介オーム社編](http://druby.hatenablog.com/entry/2017/08/19/202955)
+ [とちぎRuby会議07書籍プレゼント紹介技術評論社編](http://druby.hatenablog.com/entry/2017/08/23/231043)
+ [とちぎRuby会議07書籍プレゼント紹介日経BP編](http://druby.hatenablog.com/entry/2017/08/22/201920)
+ [とちぎRuby会議07書籍プレゼント紹介翔泳社編](http://druby.hatenablog.com/entry/2017/08/10/224616)

LT、思い出せるだけ書いておきます。

@m_sekiさんの[chibi:bit](https://www.switch-science.com/catalog/2900/)を使った[イニD](https://www.google.co.jp/search?rlz=1C1EODB_enJP571JP571&q=%E3%82%A4%E3%83%8BD+%E3%82%B3%E3%83%83%E3%83%97+%E6%B0%B4&oq=%E3%82%A4%E3%83%8BD+%E3%82%B3%E3%83%83%E3%83%97+%E6%B0%B4&gs_l=psy-ab.3..0.15562.16119.0.16680.2.2.0.0.0.0.112.211.1j1.2.0....0...1.1j4.64.psy-ab..0.2.210...0i7i30k1.SG8OdC9294s)なりきりマシーン。商品化のご相談は@m_sekiまで。

@shugomaedaさんの「Rubyはオートバイだ！」という話。これは個人的に感銘を受けました。@shugomaedaさんといえば、最近、[KLX125](https://www.kawasaki-motors.com/mc/lineup/klx125/)から[Duke250](http://www.ktm.com/jp/naked/250-duke-1/)に乗り換えたそうです。「なぜオートバイのような不便な乗り物に乗るのか？」という問いは「なぜRubyのような不便な(あるいは不完全な)言語を使うのか？」という問いと同じだと。う～ん、[R432](https://ja.wikipedia.org/wiki/%E5%9B%BD%E9%81%93432%E5%8F%B7)、いつか走ってみたい。

@emorimaさんの[千鳥足.rb](https://twitter.com/hashtag/%E5%8D%83%E9%B3%A5%E8%B6%B3rb)の話。まぁ、Rubyには酒好きが多い。コミッターにも[酒好き](http://magazine.rubyist.net/?0009-Hotlinks)がいるし、[酒好きの集まる地方Ruby会議](https://tokyu-rubykaigi.doorkeeper.jp/)もある。[広島のRubyKaigi](http://rubykaigi.org/2017)でも、Drink Upが[開催される](https://esm-drinkup-2017.doorkeeper.jp/events/63804)そうですが、すでに予約が埋まっているとか。@emorimaさんも、パーティーの終わりころ、余った一升瓶をどうするかで悩んでおられました。ちなみに[ダイナマイトキッド](https://ja.wikipedia.org/wiki/%E3%83%80%E3%82%A4%E3%83%8A%E3%83%9E%E3%82%A4%E3%83%88%E3%83%BB%E3%82%AD%E3%83%83%E3%83%89)という強い[カクテル](https://www.google.co.jp/search?rlz=1C1EODB_enJP571JP571&q=%E3%83%80%E3%82%A4%E3%83%8A%E3%83%9E%E3%82%A4%E3%83%88%E3%82%AD%E3%83%83%E3%83%89+%E3%82%AB%E3%82%AF%E3%83%86%E3%83%AB&oq=%E3%83%80%E3%82%A4%E3%83%8A%E3%83%9E%E3%82%A4%E3%83%88%E3%82%AD%E3%83%83%E3%83%89+&gs_l=psy-ab.3.1.35i39k1l2j0l6.894.894.0.2890.1.1.0.0.0.0.139.139.0j1.1.0....0...1.1.64.psy-ab..0.1.139.qSfNR6CMltE)があるそうです。

@ledsunさんの咳マニアの話。[忍者テスト](http://ledsun.hatenablog.com/entry/2014/07/16/073122)に続きマルコフ連鎖によるテストシナリオの生成にチャレンジ！

@youchanさんの[gibier](https://github.com/youchan/gibier)の話。LT最多登壇。4回。

@nay3の[怒らない話](http://blog.nay3.net/)。@koichiroさんとお嬢さんにはカメラマンを勤めていただきました。

@you_sskさんのOneDrive.exeの[謎トラブルが解決](https://answers.microsoft.com/ja-jp/onedrive/forum/odstart-odinstall/onedrivesetupexe32%E3%83%93%E3%83%83%E3%83%88/248a708a-8509-48e1-a321-1af85efd7f50?auth=1)して、それがコミュニティ内で広まっていった様子の話、面白かったです。

@awazekiさんの普通の暗黒Rubyの話。

@tsuboiさんからいただいた[本](http://animevlguild.tumblr.com/)、大変興味深かったです。

他、登壇いただいた方々で思い出せなかった人もいます。申し訳ありません。

LTの最後は@awazekiさんだったんですが、そのあとに@zzak_jpさんも座って待ってたんですよ。でも、みんなLTに夢中になってか、お昼のからあげ弁当が後を引いてるのか、料理が一向に減らない。泣く泣くLTを打ち切って料理を食べるのに集中してもらうことになりました。@zzak_jpさんにはまたの機会にお願いします！

### おわりに

今、Rubyは元気なのか？元気でないのか？そんなもやもやを抱えつつ参加したとちぎRuby会議でしたが、やっぱりRubyは元気でした。身近に厄介事があれば、まず選ばれるのはスクリプト言語です。Rubyはスクリプト言語の中でも文字エンコーディングに強く、RESTのサービスだったらすぐに使えて、スレッドも扱えます。すでに20年を超える歴史があり、その中で蓄積された資産と知恵があり、未来に向けての動きも続いています。

栃木はここのところずっと雨続きでしたが、8.26は天候に恵まれました。ハーモニーホールを後にするとき、遠くに花火の音が聞こえました。それは夏の終わりを知らせる、ちょっぴり寂しさを感じさせるものでした。

講演してくださった方々、お出でいただいた方々、ご協力いただいた方々、そしてスタッフの方々、ありがとうごいました。またとちぎでお会いしましょう！

いくぞーー！イーチ！ニーイ！サーン！ダーーッ！

### 著者連絡先

[@gdgdiler](http://twitter.com/gdgdiler)


