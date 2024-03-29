---
layout: post
title: Rubyist インタビュー特別編 小崎資広さん 前編
short_title: Rubyist インタビュー特別編 小崎資広さん 前編
created_on: 2014-04-05
tags: 0046 SpecialInterviewKosaki
---
{% include base.html %}


## はじめに

2013 年 11 月 8 日から 3 日間の日程で、アメリカはフロリダ州マイアミビーチにて  [RubyConf 2013](http://confreaks.com/events/rubyconf2013) が開催されました ([るびまにも参加レポートがあります]({{base}}{% post_url articles/0045/2013-12-21-0045-RubyConf2013 %}))。

その際に Ruby と Linux カーネルのデュアルコミッタとして有名な小崎資広さん (現在はボストン近郊在住) が参加されており、編集部からも数名が RubyConf 2013 に参加していたこともあり、せっかくですので (いつもの [Rubyist Hotlinks インタビュー](CategoryIndices#l2)とは別企画の特別編として) インタビューさせていただきました。二日間にわたるインタビューとなりましたので、前後編に分けてお送りします。

では、お楽しみください。

![DSCI3712.JPG](http://lh3.googleusercontent.com/-Yi9SFzlHfIY/UoYva8KZD7I/AAAAAAAA1z8/xWO3gR525OQ/s400/DSCI3712.JPG)

## プロフィール

好きな言葉
: 「夜明け前が一番暗い」「生きてるだけで儲けもの」

尊敬する人
: 漆原教授 (動物のお医者さん)、ヴェルナー・フォン・ブラウン

## インタビュー

聞き手
: [卜部さん]({{base}}{% post_url articles/0042/2013-05-29-0042-Hotlinks %}) ([@shyouhei](https://twitter.com/shyouhei))

語り手
: 小崎資広さん

野次馬
: 笹田さん ([@koichisasada](https://twitter.com/koichisasada))、[松田さん]({{base}}{% post_url articles/0037/2012-02-05-0037-Hotlinks %})[^1] ([@a_matsuda](https://twitter.com/a_matsuda))、[中村さん]({{base}}{% post_url articles/0028/2009-12-07-0028-Hotlinks %}) ([@nari3](https://twitter.com/nari3))、瀬尾さん ([@sonots](https://twitter.com/sonots))、菅井さん ([@hokkai7go](https://twitter.com/hokkai7go))、三村さん ([@takkanm](https://twitter.com/takkanm))、郡司さん ([@gunjisatoshi](https://twitter.com/gunjisatoshi))

日にち
: 2013 年 11 月 9 日、11 月 10 日[^2]

場所
: RubyConf 2013 会場ホテル ([Loews Miami Beach Hotel](http://www.loewshotels.com/Miami-Beach-Hotel)) の瀬尾さんの部屋

### 目次

* Table of content
{:toc}


### プロフィール

#### 生年月日、出身地、家族構成
: ![DSCI3729.JPG](http://lh6.googleusercontent.com/-9lL2AR860Xg/UoYvoRbqjII/AAAAAAAA12A/TMSjJLrZglk/s400/DSCI3729.JPG)

__卜部__ 本日はよろしくお願いします。最初にプロフィールを簡単に聞かせてください。

__小崎__ 1975 年生まれ。出身地は愛知県で、現住所はボストン[^3]郊外のマサチューセッツ、東海岸の北側ですね。ニューヨークからは飛行機で北東に 1 時間くらい、と言うとけっこう離れてるように聞こえるけど、向こうの感覚では近い。家族構成はシングルです。

#### 好きな言葉、座右の銘

__卜部__ 好きな言葉や座右の銘は？

__小崎__ 「夜明け前が一番暗い」かな。しんどい時にその頑張りに意味がないと思ってしまうと、どんどん気持ちが下を向いてしまう性格だから。ポジティブシンキングというよりも、ネガティブから派生したポジティブという感じ。
あとは「まだ生きてる」とか気づいたらつぶやいてる。宗教的な意味はないけど、どうも生きてる事に意味を見いだす性格みたいです。気が抜けたときにふっと。あんまり意識していなかったけど、若い頃に知り合いがばんばん死ぬ時期があって、そういう影響だと思う。リアルはフラグもなしに人が死ぬからよくないよね。現実はクソゲー。

#### 尊敬する人物

__卜部__ 尊敬する人物は？

__小崎__ 架空の人物だと、「[動物のお医者さん](http://ja.wikipedia.org/wiki/%E5%8B%95%E7%89%A9%E3%81%AE%E3%81%8A%E5%8C%BB%E8%80%85%E3%81%95%E3%82%93)」の漆原教授。傍若無人だけど周りからは好かれているという。自分の目標です。正反対な性分なので (笑)。実在の人物で真面目に答えると、[ヴェルナー・フォン・ブラウン](http://ja.wikipedia.org/wiki/%E3%83%B4%E3%82%A7%E3%83%AB%E3%83%8A%E3%83%BC%E3%83%BB%E3%83%95%E3%82%A9%E3%83%B3%E3%83%BB%E3%83%96%E3%83%A9%E3%82%A6%E3%83%B3)。V2 ロケットを作りたいとなるとナチスに身を売って実現させてしまう、ポリシーのない所がいいですね。
{% isbn_image_right('4592881419') %}

__卜部__ 「目的のためなら手段を選ばない」？

__小崎__ 「目的のためなら手段を選ばない」というよりも、むしろ「手段のためなら目的を選ばない」かな。ロケットを作りたい、でも何に使われるかはどうでもいい、というところが理系っぽいじゃないですか。

__一同__ (笑)

__小崎__ 色々言われる人物だけれど、ちゃんと成果を出して月まで行ったんだからね。素晴らしい。

### 代表作

__卜部__ 小崎さんの代表作は？

__小崎__ 特にないかな。あんまりものを作ったりしないし。

#### テレビの組み込みブラウザ

__小崎__ 会社での代表作は、パナソニックのテレビのブラウザですかね。組み込み系の。データ放送って 2000 年代くらいから提供されてるんですが、中身は XHTML なんです[^4]。コンテンツは HTML なので、それを表示するレンダリングエンジンの開発というイメージ。通信が一方向というのは帯域の活用という意味では最低 (笑)。パケットを 1 個とれなかったらどんだけロスが起こるか。その当時は機能も少なくてネット対応もしていなかったけど、それを対応させたりといったことをしていました。当時はブラウザの実装と W3C の規格との乖離が大きいし、ブラウザも色々種類があるしで、それぞれの挙動を見ながら規格を読んだりして、また Web ではこういう運用してるからテレビでも同じ運用するように縛りいれようと放送規格にフィードバックしたりして、そういう中で規格の読み方とかについてはだいぶ訓練されたかなあ、とか。

__卜部__ その経験は今でも役立っていますか？

__小崎__ 多分。新人の頃、最初の仕事がこの BS デジタル対応だったんです。ブラウザってその当時では組み込みとしてかなり規模が大きくて、それまでが数十 KB で媒体が ROM だったのが、デジタル放送になってフラッシュ 2 MB でコードが 10 万行くらいに。規模の爆発ですよね。大規模ソースコードを見るコツがだいぶ養われた。みんな慣れてないから、ばっかんばっかんバグを埋め込む (笑)

#### malloc の解説

__卜部__ なるほど。プログラム以外の代表作は？　動画でもいいですよ？

__小崎__ 昔 glibc[^5] malloc[^6] を[解説した動画](http://www.youtube.com/watch?v=0-vWT-t0UHg)が未だにアクセスがあるみたいで。本人的にはああいうのって、時間が経つと「うおー！　直したい！」ってなるじゃないですか。話的に古くなってる訳ではないけど。

__一同__ (笑)

__卜部__ 今からやるなら glibc malloc ではなくて、もっと変な malloc の解説をやるとか？

__小崎__ 今やるとすれば、jemalloc との比較とか、ウケそうですね。色んな実装を調べて比較したり。

__卜部__ 非同期割り込み可能な malloc とか楽しそうですね。元 HP で atomic_ops を実装してた Hans Boehm [^7]が書いてたやつですけど。シグナルハンドラの中から malloc が使えるようになる。するとシグナルハンドラの中から printf とかが使えるようになる。

__小崎__ でも malloc って性能が大事なので。そういうレアなケースで平気になったよと言われても (笑)[^8]。

#### Linux Kernel Watch

__小崎__ あとは、「[Linux Kernel Watch](http://www.atmarkit.co.jp/flinux/index/indexfiles/watchindex.html)」ていう Linux カーネルの連載を Web でしばらくやっていました。

__卜部__ 続ける予定はないんですか？

__小崎__ あれは正直ちょう辛い (笑)。仕事でやるなら良いけど、Web 媒体だとほぼ原稿料も入らないし。@IT は出してくれる方だけど、あれだけでは生活は成り立たない。

__卜部__ るびまでも Ruby の ML の解説を記事化するアイデアがあるんだけど、なかなか難しい。なかなか人がいなくて。Ruby でもそうなのに、Linux カーネルのコミット全部読むなんて死にますよ。

__小崎__ そんなの Linus でも読んでないよ。つまみぐい。あえて「主要なところだけ」って言いかたはしないけど。そもそも Linux カーネルの主要な所ってどこなんだ、という所から論争があるから (笑)

__笹田__ メモリマネージメントあたりのコミットはぜんぶ読んでいるのですか？

__小崎__ 一時期は読んでいたけど、最近は忙しくて全部は読んでいないですね。

__卜部__ 全部読まなくても仕事はできちゃう？

__小崎__ 仕事によりますね。今僕がやっている仕事は、コアのどこかを弄っている訳ではないので。どこかのタイミングでキャッチアップは必要になるかも。

#### Ruby と Linux への貢献

__郡司__ 代表作といえば、Ruby で問題になっていた所を Linux のバグとして直す、みたいなのがありましたよね。

__小崎__ わりと何個もあるので、どの話だろう (笑)。一番最初のは、select(2) で書き込み可能待ちをすると Linux の時だけハングすると akr [^9] さんに教えてもらった現象があって。Linux の仕様だったんだけれども Ruby で都合が悪いから Linux の仕様を変えてもらって、全世界の Linux ユーザーに恨まれるという (笑)[^10]。違いますね、きっと感謝されている、はず (笑)

__卜部__ もともとハングしていたものが、ハングしなくなったんだから。

__小崎__ そうですよね。僕も当時その理屈を使って説得したはず。Ruby の場合はどこにもドキュメントで保証されてない挙動についてオレの思ってた動きと違うからカーネル変えろとか言ってくるので色々言われました。テストケースで fadvise を使ってるから困るとか。

__卜部__ レアですね。いったいどういうケースなんだ？

__小崎__ [IO#advise メソッド](http://docs.ruby-lang.org/ja/2.1.0/method/IO/i/advise.html) とかのテストコードでしょう。Linux の場合は、共有メモリファイルシステムなど一部のファイルシステムについては fadvise で先読みするメリットがないので、ENOTSUP とか特殊なエラーコードを返していた。Ruby 側ではそれを受けてシステムコールが失敗したら例外を投げる想定だったという話になって。じゃあ Ruby 側でも例外があがって嬉しいかというと、全く嬉しくない。ので非サポートの場合はエラーを返さないというふうに Linux の仕様を変更した。Eric Wong[^11] と一緒に (笑)

__卜部__ 代表作たくさんあるじゃないですか。[ブログ](http://mkosaki.blog46.fc2.com/)もありますよね？

__小崎__ 最近はブログよりも [Twitter で呟いてそれをまとめるだけ](http://togetter.com/id/kosaki55tea)という簡単な方法に (笑)。あと、Ruby の [IO.select メソッド](http://docs.ruby-lang.org/ja/2.1.0/method/IO/s/select.html)について、POSIX の仕様からは若干逸脱した作りになっていて。POSIX では fd_set はスタック上に置く前提だから C 言語の制約で固定長にせざるを得なくて、ファイルディスクプリタの最大数が 1024 なんだけど、Linux でサーバやるときとかそれでは全然足りないから、みなさんカーネルパラメータをそれよりたくさんに変更してるんですよ。それで回避策としては一番お手軽なのは epoll(2) に移行することなんだけど、 Ruby の場合は別の解決策をとっていて、ファイルディスクプリタのビットマップだけを malloc でとってそれを渡すことをやっている。でも最近 glibc 側で select に渡すファイルディスクプリタの最大値をチェックして、1024 を超えていたら abort するというロジックを入れた方がいらっしゃいまして。

__卜部__ 正しくないコードを見つけたときに、ライブラリの側でどう処理するべきかという議論が最近ありますよね。

__小崎__ 最近の流れとして「セキュリティ的な意味で悪用されたら問答無用で処理を中断する」という方針がある。select も同じで、全然違うメモリ領域を buffer overflow で書かせる事ができてしまう。glibc 側でもこの理由があってチェックを入れたんですよね。

__卜部__ 「どのファイルディスクプリタにビットがたっている」なんて制御できない[^12]から、現実問題怪しげな事はどれくらいできるのか。任意のメモリ領域に書き込む事が出来るというのは理解できるけど、じゃあそれで具体的にどう攻撃できるのか。

__小崎__ 俺もそう思う (笑)。でも glibc 側としてはそれはデフォルトでは OFF なんだよね。 _FORTIFY_SOURCE の設定で引数チェックをしていて、ON の時だけ追加でチェックをかけるから、それが嫌なら外せばいいじゃないかと言うんですね。
でも Ubuntu では gcc のコンパイルオプションを独自に変えていて、そこの設定がデフォルトで ON になっている。

__卜部__ Ubuntu は最近は EGLIBC に流れているのでは。

__小崎__ EGLIBC は glibc から派生したプロジェクトだけど、glibc の側のメンテナが交代した関係で最近また仲直りしたので、再統合しそう。[^13] 

__卜部__ GCC もそうだよね。昔 EGCS というバージョンがあった。モチベーションが尽きたときに放置されることも多いけど、本家に合流というのも良くある話。フォークした後もどちらもアクティブに開発し続けるというのが超レアなんですよ。XEmacs や BSD 位ですよね。

__小崎__ 確かにね。そんなこんなで Ruby 界隈では Linux プラットフォームメンテナーという称号を頂戴しておりまして、バグが起票されたときにプラットフォームが Linux って書いてあると俺が見ないといけない (笑)

__卜部__ だいたい Linux じゃないですか。

__一同__ (笑)

__小崎__ 理不尽に思う事も多くて。さっきの glibc の select の仕様が変わってましたとか、普通に使っていたら気がつかないだろ！　っていう。誰に振れば良いのか極めて難しい。

__卜部__ それで select はどうやって解決するつもりなんですか？

__小崎__ 今は Ruby 側に workaround が入っているんだけれども、もうすぐ glibc 側を変えるパッチがマージできそう。

__卜部__ -D_FORTIFY_SOURCE=2 になっていても、それを無視するような？

__小崎__ まだ確定ではないけれど、もう一個 ON OFF のフラグをつけようかという話が進んでいる。-D_FORTIFY_SOURCE=2 はみんな ON にしたいから OFF したときにどうするのかと。もう一個フラグを作ってそっち側でフラグを OFF にしておけば解決できるかなという話。

__卜部__ でも Ubuntu ではデフォルトで ON になってしまう？

__小崎__ それは Ruby 側で上書きすれば済む話なので。select.h を読む前に #undef しておくと。超苦労した所は、Ruby ってなぜか GCC は -include を使うので真っ先に select.h が include されてしまう仕様になってる。なので泣きながら -include 周りを変えまくって。[中田さん]({{base}}{% post_url articles/0009/2005-09-06-0009-Hotlinks %})に戻されて。また壊れて。みたいな (笑)。しばらくせめぎ合いました。

__笹田__ でもそれで直るなら、glibc に手を入れる必要はなかったのでは？

__小崎__ Ruby では確かに直るけれども理由が 2 つあって、1 つ目は、Ruby 以外にも困ってるプロダクトはあるはずということ。もう 1 つは _FORTIFY_SOURCE が OFF ってことは、すべてのチェックが OFF になってしまう。でも Ruby が OFF にしたいのは select の件だけ。あと poll(2) に変えればいいという意見も貰ったんだけど、poll と select とセマンティクスが違うので。

__笹田__ 無理矢理シミュレーションする必要がある？

__小崎__ Linux だとそれらのメソッドがカーネル内で合流しているからシミュレーション出来るんだけど、System V 系だと中の処理が全く別物で、どうやってもシミュレーションできないケースが発生してしまう。Regular file とかの超王道はいいとしても tty とかは歴史的な理由という名の下に、どうしようもない (笑)。メソッド名が select である以上、select セマンティクスを期待するのは極めて自然な訳ですよ。なので、もしやるのであれば Ruby のなかで select バージョンと poll バージョンを 2 つ作ってどっちもメンテしないといけなくなるから、それは避けたいね、と。

__nari3__ ライブラリを変えよう、という発想には普通ならない気がします (笑)

__小崎__ いやいやそんなことないですよ。[松田さん]({{base}}{% post_url articles/0037/2012-02-05-0037-Hotlinks %})だって、作っている Rails アプリが思う通りに動かないと Rails を変えると言ってましたよ[^14]。

__nari3__ 本人が Rails の開発をやっているから、というのもありそうですね。

__小崎__ 確かに。システム開発者やカーネル開発者から見ると、こういう使い方もあるんだっていう知見をくれる人は重要なんですよ。ユースケースがふにゃふにゃしていると議論が迷走しがちですから。そんな感じのバトルが他にも色々あったりなんだけど、だいたいうまく収まっていて、最近は Linux は Ruby に最適なプラットフォームです。なぜなら Ruby の都合で Linux 変えちゃうからと言ってます。宣伝宣伝 (笑)

__卜部__ 昔 Ruby で sprintf を #define していた時期があるんですよ[^15]。Linux で -D_FORTIFY_SOURCE=2 にすると、glibc で引数チェックのある sprintf に #define してしまう。 #include 順序によってどっちになるのか変わってしまって、とあるファイルでは死ぬけど別のファイルでは死なないというという話になって。辛かったですね。結局 ./configure で回避した記憶があります。

__小崎__ そうやって下回りの開発者がいると、割とすぐに分かるんだけれどね。

__卜部__ gcc -E でマクロ展開して、ようやく全部気づいたレベルです。ちょうつらい。

__小崎__ Ruby さんはマクロを使い過ぎ (笑)。変な置換とか。アプリから libruby.so をリンクしている人は辛いだろうなって思います。close を ruby_close に差し替えるとか、あの辺はすごいなと思ったけど。malloc とか sprintf みたいに差し替えるのは良いんだけど、拡張ライブラリとか、libruby を使う他のアプリがみえるような公開ヘッダーで差し替えるのがすごいなっていう。Ruby の中で完結していない。普通プライベートヘッダーでやるだろう、っていう。

__卜部__ 難しい話で。プライベートヘッダーに書いてしまうと、デバッガとかプロファイラとかやる人達からは拡張ライブラリの側から見せてくれという話になったり。なので結構せめぎあいなんですよね。「Ruby の AST ライブラリを作った」と言われて見てみると、Ruby のヘッダーが丸ごとコピペされていたり。

__小崎__  (笑)。でも他に方法はないですよね。

__卜部__ 全部公開して「それを使ってね」とするか、隠しておいてコピペされるのを諦めるか。

__小崎__ 今は ruby.h が #include されて全部取り込まれちゃう。「手動で #include したときだけ追加のヘッダーが入る」って方法だと良さそうなんだけど。

__卜部__ 確かに。昔は ruby.h が小さかったから良かったのかもしれない。Ruby のソースコードが大きくなるにつれて、そういう問題も出てきていますね。Ruby が小さかったときは 1 ファイルに全部書かれていて、コントロールできていたんだけれど。

### Ruby に関して

#### Rubyist になったきっかけ
: ![DSCI3741.JPG](http://lh3.googleusercontent.com/-AKpoaN5mMZs/UoYvwljWClI/AAAAAAAA13k/yiXjB5qu6Kw/s400/DSCI3741.JPG)

__卜部__ そもそも Ruby をやるようになったきっかけは？

__小崎__ 当時カーネル開発をしていて、どうもユースケースに疎い部分があるなと感じて。なにかプロジェクトに参加したいなと思いつつ、忙しさもあって実行に移せていなかったんです。
そんな時たまたま Ruby の IRC に入ったときに「Ruby が全く分かっていない」という話をしたら、shinh [^16]さんという方が Ruby の Hello World の書き方を教えてくれて。そのときは C しか分からなくて、ライトウェイト・ランゲージとか全く分からない状態だったんだけれど、「[Ruby は C と同じだ](http://shinh.skr.jp/dat_dir/mederu/028.html)」と言われて。彼は polyglot のエキスパートでもあるから、その場で [C と Ruby の両方で valid なプログラム](http://shinh.skr.jp/dat_dir/mederu/029.html)を書き始めて。「ほら同じでしょ」とか言いながら #include &lt;stdio.h&gt; とか見せるわけ。# がコメントとか知らないから「おおー、おなじだー」とすごく感動して、俺でも出来そうだ、と。

__一同__ (笑)

__小崎__ Ruby は printf も exit もあるし。int main は書けないけども main の中では exit が書けるんですよ。int が NoMethodError になる前に、exit で閉じてしまう。

__一同__ (笑)

__小崎__ なので Ruby でも C でも正当なコードは書けるんだけれど、それを教えるかっていう (笑)

__卜部__ Rubyist になったキッカケは、だいたい浜地さんのせいだと。

__小崎__ (笑)。3 年くらい前ですかね。気持ち的にはまだ新人のつもりなので、Ruby Prize とか来年また応募したいですね。[今年](http://www.ruby.or.jp/rubyprize2013/)も応募したけど、かすりもしなかった。[受賞した近永さん](http://rubyprize.uvs.jp/win_chikanaga_01.html)とかラスボス度が高すぎて。

#### 好きなメソッドと嫌いなメソッド

__小崎__ 文字列操作や正規表現は C よりも楽になってるから好きですね。嫌いなメソッドはいっぱいあるけど、一番嫌なのは [Thread#raise](http://docs.ruby-lang.org/ja/2.1.0/method/Thread/i/raise.html) とかのスレッド周りのおかしな仕様 (笑)。raise して何が嬉しいのっていう。

__卜部__ Thread#raise は悩ましいですよね。外に向かってスレッド間通信の代わりに使えるんですよね。

__小崎__ Thread#raise はタイミングが選べないから、スレッドを殺したいときにしか有用じゃないんじゃないかなと。スタック上に実行履歴が積まれていて巻き戻すときには意味があるけど、他のスレッドに raise させるっていうのは巻き戻しとは違うセマンティクスなので、あんまり使い道がない。まず名前から気に入らない (笑)

__卜部__ その昔、タイムアウトを実行しようとすると Thread#raise を使うしかなかったと聞きますね。タイムアウトなら待ってる方のスレッドは既に止まっているので、そこに raise してもあまり問題がなかったので。

__小崎__ タイムアウトもあれはあれで、もうちょっとなんとかならんのかと思うけど。Ruby は 1.8 以前と 1.9 以降でスレッドの仕様が大きく違うので、いろんな矛盾がね。1.8 ではグリーンスレッドが表に見えちゃって、API 仕様はまあありかなと。[Thread.exclusive](http://docs.ruby-lang.org/ja/2.1.0/method/Thread/s/exclusive.html) するのもある意味アリだよね。1.8 のスレッドを最初に読んだときは、ここまで割り切るのもアリなんだ、と、その時はプラスの評価だったんですよ。1.9 で Thread.exclusive はない。

__笹田__ がらっと変えたけど、全然苦情来てない。だれもそこまで真面目に使っていない。

__小崎__ Mutex 待ちをしている所に ^C したらロック取らずに抜けてくるとか。これはまだ例外があがってくるけど、条件変数で ^C したときには例外があがってこない。

__卜部__ 嫌いな所はスレッド、と。

__一同__ (笑)

__小崎__ それも難しくて、Ruby に Thread クラスがなかったら俺コミッターになれなかった気がする。自分がソースコードを見て明らかにおかしい所が残ってないとコミット無双モードに入れない (笑)

__nari3__ Ruby のソースコードはどのくらい読んでるんですか？

__小崎__ そんなに読んでない、得意分野だけ。僕がよく直してる [process.c](https://github.com/ruby/ruby/blob/trunk/process.c) や [io.c](https://github.com/ruby/ruby/blob/trunk/io.c)、[thread.c](https://github.com/ruby/ruby/blob/trunk/thread.c) とか。システムコールから遡って読んでいくだけだから。 

__笹田__ あまりそういう読み方はしない (笑)

__小崎__ まあ grep かけたところから。Ruby の [parse.y](https://github.com/ruby/ruby/blob/trunk/parse.y) から初心者が入ろうと思ったら、結構きついと思う (笑)

__卜部__ 挫折する人結構いますよ。parse.y とか。

__小崎__ [笹田さんと一緒に学生向けのプログラミングキャンプをやったことがある](http://codezine.jp/article/detail/4515)んだけれど、学生さんは文法拡張したがるから、あそこは避けられない。でもなぜその魔窟を選ぶのかと。残り数時間で (笑)

__卜部__ 文法もなんとかしたいですけどね。でも「文法をなんとかしたい」と「スレッドと割り込みをなんとかしたい」というのを比べると、割り込みの方をなんとかした方が、と思っちゃう。文法はそこまで困らない。

#### 現在の Ruby とのつきあい方

__小崎__ [バグ登録](https://bugs.ruby-lang.org/)を監視していて、プラットフォーム Linux の申告があると確認する。あとは ABI 非互換を検出する仕組みを作っていて [RubyCI](http://rubyci.org/) に組み込んだり。リリースのときに非互換が出ないようにする仕組みを機械的に作ったりとか。機械的チェックはやっぱり必要ですよね。

__卜部__ 昔はそういうツールがないのに ABI 非互換はありませんとか。言っちゃった以上やる他ないので結構大変でした。Ruby のスクリプトでアプリを作って使うというような事はあまりしない？

__小崎__ そうですね。カーネルを直したときに、デバッグのテストツールで出力したログに対して、おかしな組み合わせを検出したり、というのはやってますね。さっきも言った文字列操作や正規表現がありがたいっていうのは、このあたりかな。

#### Ruby を使って成功した事例

__小崎__ 成功した事例ってほどでもないけど、さっき言ったテストツールかな。日々の検証で地道に使っています。テストツールはバグ発見というよりも修正できたかの確認。自分はバグを発見するタイプではないので。

__卜部__ 田中さんは自分でバグを発見するタイプですよね。

__小崎__ そもそもなぜそのテストをしようと思ったのか、っていう (笑)。どうやったらその発想ができるのか。正解を知って逆算してるのでは、と思ってしまったり。たまに自分もしますけどね。ソースコードを追って怪しそうな所を見つけてから狙い撃ちしたり。

__一同__ (笑)

__小崎__ 数少ない Ruby への貢献では、昔は Ruby って大きい文字列を作るといろんなメソッドが落ちてたんです。原因は alloca を使っていたので、スタックがあふれるという単純なものだった。その辺はソースコードを見ながら alloca を使っている所を狙ってテストケースを作り報告しましたね。結局中田さんが必要な所は malloc を使うように修正してくれたり。

__卜部__ 配列はまだ大きいと落ちちゃうんですよね。大きい配列をスプラットに渡そうとするとスタックがあふれて落ちる。お話しいただいたのはマシンスタックの話で、これは VM スタックの話なので、別ですが。たしかにマシンスタックの alloca はもうないですよね。結局 alloca の引数に外から来た任意の引数を渡してしまうとまずいという話で、固定長はまだ残ってたかな。

__小崎__ そこから数年経った今まさに glibc でも同じ話になっていて。インプットをそのまま alloca に渡していて、一掃作戦をかけています。　

__卜部__ alloca 使いたい気持ちも分かるけど、前後にチェックを挟むとそこまで速くならないし。

__小崎__ そうですか？　ぜんぜん速度違うと思うけどな。malloc したら CPU とかロック競合を考えないといけない。Ruby みたいに GVL だから関係ないのかもしれないけど。

__卜部__ alloca だと、alloca 出来ないときにどうするのか考える必要があるのが手間かなと。スタック足りなかったりとか。

#### キラーアプリ

__卜部__ 自分のとってのキラーアプリとは？

__小崎__ アプリではないけれど [GitHub](https://github.com/) ですね[^17]。僕の人生を変えかねない位のインパクトが。

__卜部__ Linux って GitHub をどれくらい使ってるんですか？

__小崎__ ほとんど使ってない。個人的には、カーネルは色んなマシンでテストしたくなる訳だけど、色んなマシンに push できて超便利とか。後は人様のプロジェクトを見るときに分かりやすい。ブラウザで見れるし。GitHub なかったら、Git の普及ってもっと遅かったと思う。コマンドだけだと何を操作しているのかイメージしづらいし。GitHub は目で見て分かる。Git のコマンドって便利だけど理解するまでが (笑)。GitHub だとワンクリックで fork が出来る。

__nari3__ この間 Mozilla のリポジトリに使ってないマクロがあって。消すためのパッチを作ろうとすると、Mozilla は独自のバグトラッキングシステムを持っていて、再現性を問われたりアカウントを作らないといけなかったり。結局マクロ 1 つ削るのに 3 ヶ月もかかりました。GitHub にあればいいのにって (笑)

__小崎__ Mozilla はレビューの割り振りが均等でない感じがする。

__卜部__ あと、GitHub を使っている人はコミットログをちゃんと書いてほしいですね。「#123」みたいに書いてる人がいるんだけど、GitHub だとリンクとして表示されるけど、他では困ってしまう訳で。ちゃんと書いてほしい。

__小崎__ キラーアプリはその位かな。Ruby 界隈では [tDiary](http://www.tdiary.org/) を使っていないと Rubyist を名乗れない、みたいな感じがありますけど。僕使ったことなくて。

__卜部__ いやいや。そんな事ないですよ (笑)

#### Ruby の習得は簡単でしたか？

__小崎__ 何一つ分からないのでソースコードを読むまで分からなかった感じですね。

__卜部__ メソッドの振る舞いの話ですよね。文法はどうですか？

__小崎__ 文法は完全に理解してないですよ。複雑な事はしていないし。Ruby のテストプログラミングに頼っているので、そこで使っていない [method_missing](http://docs.ruby-lang.org/ja/2.1.0/method/BasicObject/i/method_missing.html) みたいなメタプログラミング系の知識は未だに全然ないです。

### プログラミング全般

#### Ruby 以外のプログラミング言語あるいはテストの話
: ![DSCI3743.JPG](http://lh3.googleusercontent.com/-HkeMMmEOldc/UoYvx1ZhIqI/AAAAAAAA13w/-z5sn2ash1Y/s400/DSCI3743.JPG)

__卜部__ Ruby 以外のプログラミング言語は何を？

__小崎__ 普段使いは Linux のカーネルのテストを C で書いてます。Linux 独自のシステムコールは C からしか叩けないから、もう得手不得手関係なしに C。

__卜部__ それはテストケースの話ですよね。テストドライバーみたいなものは無いんですか？

__小崎__ 無いでーす。一つひとつ手で実行する。Linux にも LTP っていうテストプロジェクトはあるけれども、Linux の中心的開発者で使っている人は見たことはありません。
みんな自分が作ったところは自分の手でテストしている。

__nari3__ Ruby は大きな修正の時にテストを走らせないでコミットすると怒られますね。

__小崎__ Linus さんがテストしないでコミットする人だからしょうがない。

__nari3__ どっかで聞いた話ですね (笑) [^18]

#### レビューをするかチケット管理をするか

__卜部__ GitHub が出てくるまでは Ruby ではあんまりレビューをしなかった。パッチを送ってきてレビューするという文化がない。コミットしてからバグに気づく。
その代わりちゃんとチケットを管理している。

__小崎__ Linux で偉いのはパッチをメイリングリストに投げてみんなでレビューしているところ。
Ruby は仕事じゃないのにリリース前にチケット総ざらえするのが偉いよね。
kernel.org にもバグ管理システムはあるんだけどだっれも見てへん。Linus が見てない以上……。

__笹田__ そういう意味じゃ、まつもとさんも見てないじゃん。

__一同__ (笑)

#### Linux 界隈と Ruby コミッター界隈の文化の違い

__nari3__ Linux 界隈と Ruby コミッター界隈の文化の違いとかありますか？

__卜部__ 日本語が通じるかどうか？

__小崎__ Ruby の方がコミッターどうし仲が良いかな。IRC でだべってるし、数も多くないし。顔を覚えなくちゃいけないのは 30 人くらい。
いっぽう、Linux は名前覚えなくちゃいけないのが 200 - 300 人くらい。
カーネルサミットの会場に限界があって 80 - 100 人くらいしか呼べない。どういう基準で選んでも居ないやつがいるから議論が成立しないんですよね。

__卜部__ まあしゃあないですよね。世界中から 300 人とか呼んでもみんなは来られない。

#### カーネルサミット

__nari3__ カーネルサミットはどこでやるんですか？

__小崎__ 全世界を転々と。今年はイギリス、去年はアメリカだったと思う。日本でやったこともあるじゃないですか。

__郡司__ Linus が来て、よしおかさんがカーネル読書会に呼んで[^19]。

__小崎__ Windows 7 の発売セールやってるアキバのヨドバシで親指を立てて (笑) [^20]
カーネルサミットは年 1 回やってます。毎回行ってるわけじゃないけど。発表したこともあったかもしれないけど英語がよくわからないとかいって同僚の誰かに押し付けることが多い。

__笹田__ 行くと 300 人くらいいて顔と名前は一致する？

__小崎__ 残念ながらほとんどわかってへん。向こうから話しかけてきた人だけは、顔と名前が一致する。

__菅井__ RubyKaigi とかだと Ruby を作ってる人も使ってる人も来るけれど、カーネルサミットは？

__小崎__ Linux を作ってる人も全員来られるわけじゃないけれど、サブシステムごとにミニサミットをやっている。
一番大きいのは LSF/MM (ストレージ、ファイルシステム、メモリ)。それが 60-80 人くらいで、僕も毎年呼ばれてるので、年に一度ツイートしてると思います。
「今年はこういうことやることになりました」って。

__卜部__ と言ったはなしを、「Linux Kernel Watch」で書いてくれれば良いんだけど。

#### C 以外の言語は？

__小崎__ 昔は C++ とか Java とかホビーに使ってたけど使わなくなったなあ。
大学生とか新人の頃に Java が流行り始めて。Ruby のスレッドは明らかに Java からの影響を感じられるよね。

__卜部__ Java でアプリケーションを書こうと思ったことは？

__小崎__ Java とカーネル屋さんの二足の草鞋を履くには JVM を知らないといけないからちょうつらい。
ちょっと時間ができたから見てみよっかなー、というには太刀打ちできないレベルになってる。
Ruby は行数を見て、ああこのくらいだったら理解できるかな、と。

__卜部__ さっき言ってたテレビのブラウザは？

__小崎__ C。組み込みはほとんど C。C でブラウザを書くのはつらいけれど、Mosaic の頃は C で、どこかで分岐した Mosaic が組み込みでは延々と使われている。

__卜部__ バグってても武器が無さすぎてどこでメモリが壊れてるかわからないですよね？

__小崎__ それは Ruby も一緒じゃん。

__卜部__ でも Ruby はどこを注目すれば良いかはある程度明らかですよね？

__小崎__ それは結局ソースコードを習熟すれば明らかだということ。結局最初はちょうつらいんだけども、ソースコードを何回も読んでると、だいたいこの辺じゃないの？　というのがだんだんわかってくるので。

#### 文字列操作

__卜部__ あまり僕は C では文字列操作はやりたくないな。

__小崎__ 特に web 系の文字列操作はね。
Ruby のパーズが幸せなのは、文字列が全部そろってから始められること。
組込みブラウザの時は、パケットが全部来てなくてもパーズを始めなくちゃいけないじゃん。
次のパケットが来たら、「解釈間違ってましたぁ」みたいなことも起きるし、

__卜部__ そこそこ速く動かなくちゃいけないので、先頭からやりなおすわけにも行かないし。

__小崎__ バッドノウハウの塊なので、心を無心にして読まないと、むきーって。
でも、当時はわからなかったけれど、ブラウザの世界はけっこう狭いから、人の交流のせいで似た設計になる。ひとつ理解すると、他社のブラウザもわかる。

#### ソースコードの行数

__卜部__ ところで Ruby のソースコードの行数は、C の部分で 20 万行ぐらいでしたっけ。

__小崎__ ユーザー空間でそれはずいぶん少ない。OpenOffice は 1 千万って聞いたけど。

__卜部__ コンパイルする時間を考えても。OpenOffice は一日がかりだしね。
Gentoo っていうディストリビューションがあって、だいたい全部コンパイルするので、絶対的な行数はわからないけれど、相対的な規模がそれなりにわかる。
Emacs とカーネルは同じくらいとか、それに比べて ghc は明らかに遅いとかわかって楽しい。
今は日和って Ubuntu を使ってますけど。

__小崎__ そういう意味では Linux もずいぶん小っちゃくって、ドライバを全部合わせて 1 千万レベルだから、
カーネルのコアだけなら数万行で Ruby とそんなに変わらない。

__笹田__ 目的があれば見てみようかな、っていうレベルですね。

__卜部__ システムコールは読みたくないな。土地勘ができるまで大変。libc なら土地勘があるんだけど。

#### 美しいソースコード

__卜部__ 今まで読んだなかで最も美しいソースコードは何ですか？

__小崎__ 感銘を受けたのは『[Lions' Commentary on UNIX](http://en.wikipedia.org/wiki/Lions%27_Commentary_on_UNIX_6th_Edition,_with_Source_Code)』。Unix like operating system に対する土地勘がたったの 1 万行のソースコードで得られる。
もうひとつ挙げるとすれば X[^21]。今から見るとちょう汚ないんだけど、業務で普段みてるヘッポコソースと比べると突然まったく関係ない処理が顔を出さないので感動した。まあフォローしておくと、組み込みはいろんな事情があって汚くなるのは避けられないんだけど。

#### テレビの規格

__小崎__ そういえば、テレビの描画は X のプロトコルでやってる。X にはエクステンションがいろいろあって、僕が選んだのは横に 2 画面あるのを同じ座標に 2 画面重ねるようなもの。テレビは日本の規格では、昔のゲームのスプライトみたいのを 5 画面重ねてる。動画、JPEG 用、データ放送用 (文字とか PNG の軽いやつ)、あと、字幕が 2 つ。字幕は、番組連動のものと、野球速報や地震津波の警告みたいに番組に連動していないものと。こうしておくと録画した番組を見ているときは速報字幕みなくてすむからって。でも、せっかく規格をつくったのに結局実際の運用では、地震警告は動画にはりついてる。録画とかしたものに変な警告が張り付いちゃってるのは、元テレビ屋さんとしては残念。せっかく苦労して仕組みつくったのにって。

__郡司__ それは全部のテレビに実装されていないから？

__小崎__ いやいや。アナログテレビはもう無いし、デジタルテレビは全部実装されてる。

#### 今興味があること

__卜部__ 今興味があることは何ですか？

__小崎__ トランザクション・メモリ。Haswell が発売されたので何かネタないかなと。Linus 先生が VFS のロックを書き換えてちょう速くなったって言ってた。UNIX のファイルシステムは全部ルートからつながってるからルート近くでロックが競合する。実際にはファイルはほとんど競合しないから、楽観的な仕組みにすればすごく性能が上がる。そんなわけでトランザクション・メモリとはすごく相性が良いんです。

__卜部__ じゃあ効くところでは効くっていう感じですね。Intel が入れると言った時は本気か？　と思ったけどアリなのかもねという感じもしてきました。Haswell の入ってる Mac とか。

__小崎__ MacBook Pro。欲しいんだけど高くて買えない。

__卜部__ 何かのグラントをもらって買えばいいんじゃないですか？　「とりあえず Ruby を速くします」って Kickstarter に登録してみるとか。

__小崎__ それでできなかったら、恥かしいね。もう 1 個やりたいのは glibc malloc の高速化。jemalloc や tcmalloc より遅い理由を何個か知ってるけど upstream にコミットできていないので、そのうちやりたい。

#### GNU プロジェクトへの著作権の譲渡

__小崎__ でも GNU の場合は面倒くさい。ほとんどの会社では、従業員が業務時間内に書いたコードの著作権は会社のものになる。そのコードが業務時間外に書かれたものだという証明は困難なので、GNU にコードを貢献するには、フリーランスでもない場合は、会社の責任のとれる人のサインがないとコードを受け付けてくれないんだよね。VP レベルの人のサインが必要なので、特に弊社みたいな大企業だと結構大変で。偉い人すぎるとね。

(後編に続く)

## 途中で

小崎さんインタビューの前半はここでおしまいとなりました。
翌日おこなわれた後編のインタビューに続きます。お楽しみに。

(インタビュー：卜部、テープ起こし＆編集：小林、zunda)

----

[^1]: インタビュー前編では欠席
[^2]: インタビュー前編は 11 月 9 日に行われました
[^3]: MIT とかハーバードとかがあるところ。クトゥルフものでよく出てくるアーカムという架空の町のモデルになったセイラムという魔女狩りがあった町も近い
[^4]: 正確には BML という XTHML もどき。テレビ用にいろいろ拡張されてる
[^5]: GNU C Library のこと。GNU プロジェクトにおける C の標準ライブラリ http://www.gnu.org/software/libc/libc.html
[^6]: C 言語でメモリを動的に確保する関数。glibc に含まれている。
[^7]: この解説は嘘ではないが、BoehmGC の作者と言った方が実はこのインタビューの参加者にはとおりがよかったかも
[^8]: などと言っていたら glibc malloc に対しても同様の提案が libc コミュニティで出てきてびっくりした
[^9]: [田中哲さん]({{base}}{% post_url articles/0008/2005-07-19-0008-Hotlinks %})
[^10]: るびまの記事「[[0044-CRubyCommittersWhosWho2013#l10]]」も参照
[^11]: Unicorn の作者として有名。ごく最近 Ruby のコミッターにも就任。
[^12]: select はディスクリプタが読み書きできるようになった瞬間にビットがたつ。だからたとえばソケットが読み込み待ちとかのときは立たない。そんなもんで任意の場所を任意のビットパターンにするのは至難の技かと
[^13]: 原稿を書いてる間に開発停止の表明が出てしまいました。 https://sourceware.org/ml/libc-alpha/2014-02/msg00060.html 現在 eglibc の Web ページトップにも "EGLIBC is no longer developed and such goals are now being addressed directly in GLIBC." と書いてあります
[^14]: 野次馬に松田さんの名前がありますが、前編 (インタビュー初日) は欠席されていました。
[^15]: sprintf: 今も #define している。BSD の sprintf に流れている
[^16]: 浜地さん。[id:shinichiro_h](http://d.hatena.ne.jp/shinichiro_h/about) や[るびまゴルフ]({{base}}{% post_url articles/0021/2007-09-29-0021-RubiMaGolf %})を参照。
[^17]: GitHub のサイトは Ruby on Rails で実装されているそうです。 http://ja.wikipedia.org/wiki/GitHub
[^18]: まつもとゆきひろさんはテストせずにコミットして Ruby のコミット権を剥奪されかけたことがある http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/29650
[^19]: [第100回カーネル読書会にLinusが来た件 - 未来のいつか/hyoshiokの日記](http://d.hatena.ne.jp/hyoshiok/20091023)
[^20]: [Slashdot Linus来日中、Windows 7に喜ぶ？](http://linux.slashdot.jp/story/09/10/23/0550238/Linus%E6%9D%A5%E6%97%A5%E4%B8%AD%E3%80%81Windows-7%E3%81%AB%E5%96%9C%E3%81%B6%EF%BC%9F)
[^21]: X Window System のこと。 http://ja.wikipedia.org/wiki/X_Window_System
