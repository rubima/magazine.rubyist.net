---
layout: post
title: Ruby コードの感想戦 【第 2 回】 WikiR
short_title: Ruby コードの感想戦 【第 2 回】 WikiR
created_on: 2013-02-24
tags: 0041 CodePostMortem
---
{% include base.html %}


* Table of content
{:toc}


書いた人: 関将俊さん

## Ruby コードの感想戦 【第 2 回】 WikiR

この連載は第一回の冒頭で説明されている通り、あるコードをテーマにした文通です。
たいていの文通は人に見せるものではないのだけれど、今回は特別にみなさんに公開します。

サラリーマンモードのコードレビューではにらむ、指差す、びっくりするなど言葉を使わなくてもわりと伝わりますが、今回は文通ですからなんとか言葉にしていきたいと思います。

前回は須藤さんのターンでした。私の小さな Wiki を題材に、須藤さんからコメントをいただきました。
今回は私のターンです。須藤さんのコメントに私が言い訳していく番です。

### 須藤さんのこと

須藤さんを知ったのはオーム社の森田さんからのメールです。

私が昔 (いまも) 使っていた WebUI のライブラリを使ったアプリケーションを森田さんが見つけて教えてくれたのです。
当時、須藤さんは社長ではなく学生だったのではないでしょうか。
たぶんそれと同じ頃に RWiki の開発に参加してくれたと思います。須藤さんは国際化やリファクタリングだけでなく、The RWiki の運営などめんどうなことも担当してくれました。昔過ぎて思い出せませんが、だいたいそんな感じです。

RWiki は別の誰かとコードを書いた唯一のプロダクツ (語弊があるけど、誰かに頼って開発した、という意味) です。それ以来はどれもパッとしないというか相手にされてないでいるし、まあ一人でもいいかなと思っています。そういうわけで、私が誰かとコードを書いたのは須藤さんが最後です。
すごいでしょ。

須藤さんとの作業はひっかかるポイントがよく似ていてとても楽しかったです。似ていても解決方法は全く違ったりすることもあり、誰かとやるのもいろいろ面白いなあ、と思い知らされましたね、そういえば。

そうそう。須藤さんの話題と同じくらい重要なポイントがあります。私はいわゆる OSS 的なかっこいい活動とは縁遠いということです。プルリとかパッチとかそういうモダンなソーシャルネットワークの世界を楽しんだ経験は少ないので、須藤さんが語られているよいパッチのスタイルなど関することへの言及はしません。
その分、ソースコードについてたくさん時間を割きますね。

### ソフトウェアの構成

まずソフトウェアの構成について解説されています。

> WikiR は dRuby サーバーと dRuby サーバーに接続する CGI で構成されています。これは、咳プロダクツではよくあるパターンです。
> 咳フリークならみんな知っています。


須藤さんはじめ多くの方はご存知かと思うのですが一応説明しますと、私は dRuby という Ruby のプログラムならなんでもサーバにしてしまうライブラリを書きました。それ以来このような構成の、サーバによるアプリケーション本体 (モデル？) とクライアントによる UI の組合せを用いたシステムを書くことが多いです。
WebMVC がこういう風に流行る前には、モデルのプロセス／ビューとコントローラーのプロセスと分けて配置するように意識していましたが、最近はもう飽きてしまいました。

アプリケーション自体をサーバとして考えるのは、Smalltalk のプロセスの様子や、AppleEvent/AppleScript 時代の Macintosh のアプリケーションの利用、X11 アプリケーション開発などの経験からです。まあ全然ちがうだろ！と思うかもしれませんが、私はよく似た何かを感じたんですよね...。

なんの話でしたっけ。えっとソフトウェアの構成のことですね。須藤さんがおっしゃる通り、咳フリークならよくしっているいつもの構成でした。

### 命名に関すること

私はプログラミングにおいて「名前重要」というのが好きじゃありません。なんだか名前だけが重要に聞こえるので「名前も重要」くらいが好みです。いろいろな判断をした結果として残されたのがコードです。名前をはその背景を知るひとつの手がかりで、読み手にとっては重要なヒントになります。

#### 喩えた名前

須藤さんは WikiR::Book という名前についてコメントしています。

> ページを管理するクラスには他にも違う名前が考えられます。例えば「Wiki」という名前です。ページを全部集めたものが Wiki だと考えれば適切な名前です。
> あるいは、「データベース」という名前です。ページが保存されている感じがします。「本」や「Wiki」ではどのように保存するかは気になりませんが、
> データベースという名前を使うとどのようにページを保存するかを意識している感じがしますね。
> 
> 咳さんは何かに例えた名前をつけます。作っているものは Wiki ですが、「ページが集まっているものと言えば本だよね」という連想をして
> 「本」という名前をつけたのでしょう。このように何かに例えた名前をつけると愛着がわき、例えたものベースで説明するようになります。
> 例えば、「ページの数が増えてきて処理に時間がかかるようになったね」というのではなく、「本が厚くなって重くなったね」というような感じです。
> 自分が書いたソフトウェアに愛着がわくので一度は試してみるとよいでしょう。


愛着もそうかもしれないけど、私はその文脈で識別し易いものを選ぶようにしている気がします。 (今まで意識したことなかったですが、この文通のためにムリに考えています。)

Book については Wiki を作っているのに Wiki って名前にしたらよくわからないし、辞書構造だから Hash とかデータ構造を表すのも実装を狭めるし、なんとなく Page の集まりだから Book を選びました。もっと素敵な名前が出てくるかもしれないけど、以前書いたときも Book だったし、まあ惰性も強く働いたと思います。

私がこういった名前の付け方を知ったのは TCL からです。TCL とはシマンテック社の THINK Pascal についていた THINK Class Library です。tcl とは関係ないです。
私はこの小さくて速いコンパイラとクラスライブラリに夢中になりました。コンパイラに付属していたクラスライブラリのマニュアルを何度も何度も読みました。このクラスライブラリの日本語版のマニュアル、バージョンアップ後の英語版のマニュアルの二冊はまだ手元に置いてあります。もうボロボロになってしまったけれど捨てられません。

喩えを使った名前は GUI 部品ではよく見かけましたが、次のような機能を喩えた名前を知ってくすくすした覚えがあります。

CBartender
:  イベントを適切なオブジェクトにディスパッチする係

rainyDayFund / creditLimit / loanApproved
:  メモリが少ない時のための蓄え、借りれる最大サイズ、メモリ要求が承認されたかの状態

はっ。そういえばプロセス間通信に使われるメカニズムの名前は比較的キラキラネーム (セマフォ、ランデブー、リンダとか) が多い気がしますね。

#### set_srcのこと

> RWiki の時もそうでしたが、咳さんは set_src いう名前を使います。 src= の方が Ruby らしいのに、です。たぶん、「src= だと単純に値を設定するだけ」
> というイメージがあるけど、実際は「ソースを設定した後に HTML に変換するというようにたくさんやっている」から set_src という
> 別の名前にしているんじゃないかと思います。で、私はこの名前が好きではありません。


同感です。私も set_src は好きでありません。というよりも、まず思いつきません。当然、最初は src= で書き始めました。そうするとですね、

{% highlight text %}
{% raw %}
 @@ -29,11 +29,11 @@ class WikiR
    class Page
      def initialize(name)
        @name = name
 -      set_src("# #{name}\n\nan empty page. edit me.")
 +      self.src = "# #{name}\n\nan empty page. edit me."
      end
      attr_reader :name, :src, :html, :warnings
{% endraw %}
{% endhighlight %}


この記述に出会うわけです。「self.src = 」。どうですかこの奇妙さは！

ここまできてああそうか、src= は dRuby/irb などの外部アプリケーションからの操作のためにとっておいて、内部は特別なことをしそう感のある奇妙な名前にしておこうかなあと思ったわけです。そんな思考を経て、10 年前に書いた set_src を「あのときもこんな気分だったのかなあ」と思い出しつつ拝借しました。src= 以外の名前があったらそれにしたいと思います。

#### 奇妙な省略形と attr_reader の位置

> km という変数名が気になります。これは KraMdown の略だと思いますが、このオブジェクトは
> Kramdown::Document オブジェクトなので km ではなく document が適切です。


なんで省略形に km を選んだのかよく覚えていないのですが、Kramdown を示す名前を使った理由は覚えています。私はよく暇つぶしに Wiki を実装しますが、最初のバージョンは書式をもたない plain text (というより HTML 直書き) で始めます。その場合、フォーマッタは plain や html だったりします。
今回もそのように書き始めて、Kramdown のフォーマッタに取り替える時に km としました。その他のフォーマッタの採用を検討してもいましたし、この当時は doc でなく km を選んだんでしょうね、たぶん。

> 他にも src と省略しないで source にしたいとか、attr_reader は initialize の下じゃなくて上に書きたいとか、"# #{name}..." は default_source
> というメソッドとして括りだしたいとかありますが省略します。


src を source にするべきかは議論があると思います。
常に省略しない名前が素晴らしいと誰かが言ってたみたいですが、自分の想定する読者の範囲のリテラシーに合わせて良いと思います。たぶん。私はそう信じているので、source は src でソースだと通じると考えました。C でループを書くときの添字の i や、座標の x, y、stdin/stderr/stdout、また WikiWikiWeb を Wiki と略したりするのもわりと通じることが多いのではないでしょうか。

そうそう。The dRuby Book の訳者である井上さん[^1]から ary というのがイケテナイと指摘をうけたことがあります。ary は ruby のソースコードではポピュラーな省略形ですから、なんの躊躇もなく使用しています。通じなくてごめんなさい。

さて、attr_reader の位置はどうでしょうか。Ruby ではインスタンス変数を宣言する必要はなく、代入した瞬間に生まれます。多くの場合、initialize メソッドで初期値を入れることで宣言のように見せているのではないでしょうか。ですから attr_reader など、インスタンス変数を操作するコンビニエンスメソッドを定義するのは initialize の後が好みです。

default 値をつくるメソッドを分けるのは賛成です。その場合、Kramdown という書式を追い出してそのフォーマッタにデフォルト値を生成するメソッドを配置すると思います。

### MonitorMixinのこと

> MonitorMixin を include して、initialize で super() して、up の中の処理を synchronize do ... end しています。
> これは dRuby を使ったプログラムでよく見る処理です。
> 
> と、 MonitorMixin の説明をしてきましたが、私は MonitorMixin が好きではありません。initialize で super() するのがカッコ悪いなぁと思います。
> 継承したときに initialize で super() するのは親クラスも初期化しないといけないからだろうなぁとは思います。
> クラスをインスタンス化するときに initialize が呼ばれるというルールがあるからです。
> しかし、モジュールは initialize が呼ばれるというルールはありません。
> それなのに super を呼ばなければいけないのがカッコ悪いなぁと思う理由な気がします。


MonitorMixin は私のコードでよく出現します。使用例などは須藤さんが示されている通りです。入れ子に呼び出してもロック可能なのでアプリケーションを書くのが楽です。

実は私は MonitorMixin よりも Monitor が好きです。MonitorMixin が好きでない理由は @mon_owner, @mon_count, @mon_mutex の三つのインスタンス変数を定義してしまうところです。須藤さんの言う通り、superが必要なのもめんどくさいです。でもそれを補って MonitorMixin を採用する理由があります。それは synchronize メソッドが定義されることです。

{% highlight text %}
{% raw %}
  class WikiR
    class Book
 -    include MonitorMixin
      def initialize
 -      super()
 +      @monitor = Monitor.new
        @page = {}
      end

 @@ -19,7 +18,7 @@ class WikiR
      end

      def []=(name, src)
 -      synchronize do
 +      @monitor.synchronize do
{% endraw %}
{% endhighlight %}


須藤さんのパッチをごらんください。synchronize は @monitor のメソッドのままです。これは、@monitor に関して排他制御することを意思表示しています。オブジェクト自身の排他制御ではなく、あるモニターに関する排他制御に見えます。あるオブジェクトの中で複数の関連しない区間が排他制御される可能性がある (つまりモニターが複数あるかもしれない、という心構えで読む必要がある) ということです。排他制御はある関心事について書かれるべきです。
MonitorMixin が synchronize メソッドを定義してくれる場合、いま読んでいるオブジェクト全体が関心ごとであることを意思表示することになります。あるオブジェクトの中で本当に複数の関心事それぞれに排他制御が必要なケースで @関心事.synchronize を導入するべきだと信じています。

すると次のような synchronize メソッドを導入すればいいじゃんと思いますよね。

{% highlight text %}
{% raw %}
 def synchronize(&blk)
   @monitor.synchronize(&blk)
 end
{% endraw %}
{% endhighlight %}


これを毎度定義するくらいなら、super とインスタンス変数が増えちゃうことを受け入れて MonitorMixin を使ってもいいかー、となるわけです。

#### DefMethod

> 特に改善案はないのですが、前から DefMethod というモジュール名がカッコ悪いなぁと思っていることだけ書いておきます。


はい、同感です。

### 例外のこと

> それでは、最近の書き方をしているところも見てみましょう。
> 
>   84 text = text.force_encoding('utf-8')
> 
> force_encoding は ! がついていないので名前だけではわかりづらいですが、破壊的なメソッドです。
> そのため、戻り値を text に代入する必要はありません。これで十分です。


うおおお。それは知りませんでした。コメントありがとうございます。

> このメソッドにはそれよりも気になることがあります。それは、例外を握りつぶしているという事です。
> 
> wikir.rb:
>   81 def do_request(req, res)
>   ...
>   86 rescue
>   87 end
> 
> rescue の中でログを出力するなどした方がよいです。


do_request は WikiR の中で、外部から入ってくる怪しい入力を濾過してきれいな入力だけを扱うメソッドと位置づけました。怪しい入力を却下し、扱える入力だけを処理します。怪しい入力はいろいろな方法で怪しく、それに対してアプリケーションができることはほとんど残されていません。せいぜいログを吐いてユーザに言い訳するくらいでしょう。それくらいなら httpd のログにも手がかりはあるし、ruby の起動オプションで印字することもできます (全ての例外が等しく重要であるなら、ですが) 。

このコメントは二通りの受け止め方ができます。一つは、HTTP のリクエストではログを残すべきである、もう一つは、例外を握りつぶすのはダメだ、です。

前者の意図であれば、須藤さんの言う通りかもしれません。私は HTTP のサービスを仕事で書いた経験はありませんし、運用もしていませんから、経験豊富な須藤さんの意見が正しいと思います。

後者の場合、私は「例外を握りつぶす」という表現がよくわかりません。例外をフィルタするのが悪で、ログするべきである、というニュアンスのことを言われることがよくありますが、私はそうは思いません。例外はちょっとかっこいい制御構文とエラー情報であって、他の戻り値やジャンプ命令と大差ありません。例外だけを特別扱いするのは奇妙な感じがします。

アプリケーションはいつかどこかで例外を処理しなくてはなりません。例外はそれぞれの間で適切にフィルタされるべきだし、適切に発生させるべきだと思っています。ライブラリを設計するとき、全ての例外をそのまま通すのは簡単です。その処理の責任を呼び手に押し付けるわけですから。アプリケーションはライブラリの値域に対して正しく動くように書かなくてはなりません。例外の設計はエラー値の設計でもあります。ライブラリはアプリケーションが書き易いような値域にすることを心がけるべきです。例外を返すということは、アプリケーションがそれを処理するべきだ、という意思表示であったり、一連の処理のそれぞれに対してエラーチェックすることなく、まとめて rescue でエラー処理するチャンスを与えるためであったりするでしょう。

アプリケーションにとって役に立つ例外はなんでしょう。do_request に関して言えば、ここで例外をあげてもアプリケーションができることはないし、積極的に例外を捨てることが正しいと判断しました。

WikiR とは関係ありませんが、この言い訳をしているうちに例外を発生させないライブラリに対して、アプリケーションの記述を容易にするために、例外を発生させるラッパーを書いたことがあるのを思い出しました。

* [http://d.hatena.ne.jp/m_seki/20081203#1228239611](http://d.hatena.ne.jp/m_seki/20081203#1228239611)


これは Koya という OODB の習作をしていて書いたものです。Koya のストレージには TokyoCabinet (以下 TC) を利用しました。TC では「例外を発生させず、戻り値でエラーを表現する」という方針を採用しており、エラーが起きるかもしれない呼び出しに関しては戻り値をチェックする必要があります。
アプリケーションで全てのTCの操作に対して戻り値の検査をするのは退屈ですよね。たとえばトランザクションの処理のようなものを想像してください。トランザクション中で行う TC の操作の全てについていちいち検査するのではなく、rescue でまとめて処理するとアプリケーションのコードはシンプルになります。

{% highlight text %}
{% raw %}
   class BDBError < RuntimeError
     def initialize(bdb)
       super(bdb.errmsg(bdb.ecode))
     end
   end

   class BDB < TokyoCabinet::BDB
     def exception
       BDBError.new(self)
     end

     def cursor
       TokyoCabinet::BDBCUR.new(self)
     end

     def self.call_or_die(*ary)
       file, lineno = __FILE__, __LINE__
       if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(1)[0]
         file = $1
         lineno = $2.to_i
       end
       ary.each do |sym|
         module_eval("def #{sym}(*arg); super || raise(self); end",
                     file, lineno)
       end
     end

     call_or_die :open, :close
     call_or_die :tranbegin, :tranabort, :trancommit
     call_or_die :vanish
   end
{% endraw %}
{% endhighlight %}


call_or_die というクラスのメソッドに Symbol を渡すと、戻り値が異常なら例外を発生させるメソッドを定義します。

こんな風に、処理はうまくいかなかった (うまくいかなかったら false を返すという仕様のメソッドだと考えると、メソッドはうまく動いているとも言えるんだよなー) けど例外があがらないケースって多々ありますよね。この場合はどう考えたらいいんでしょう。「例外」が特別なのか戻り値が false なのも特別なのか、いや全てのメソッドの戻り値はログされるべきだとか、いろいろ考えられますが、こういうのってあるルールで機械的に思考する類のものではなく、その状況に応じて対応をテキトーに選ぶものではないでしょうか。

あっ、ここばっかり言い訳が長くなりました。苦しいので先に進みます。

### WEBrick::CGIのこと

WEBrick::CGI はここ五年くらい (もっと？) 意識して使ってます。

CGI や WEBrick サーブレットなどのアプリケーションインターフェイスはよく似ているけど、ちょっとずつ違ってます。たいていそういうのをみるとインターフェイスをそろえてみたくなるのが人情です。私も 20 世紀にそういうのをやってたんですが、全部のインターフェイスをそろえるのめんどくさいんですよね。細かい仕様とか調べるの苦手だし。そこで CGI でもなんでも WEBrick のインターフェイスにそろえることができそうだと気付いておねだりして作ってもらったのが WEBrick::CGI です。よく似たアイデアのものも多いかもしれないけど、gem なしですぐ使えるのが魅力です。
WikiR も CGI でないところに配置されたとしても、WEBrick なアプリケーションインターフェイスを変更することなく動作させることができます。

### index.rbのこと

もっとも、index.rb のように非常に小さい CGI は Rails を CGI で起動するようなケースと比べて軽いため、実用的な速度を持ちます。イントラネットで使用するには十分なことも多いです。

{% highlight text %}
{% raw %}
 index.rb:
   #!/usr/bin/ruby
   require 'drb/drb'

   DRb.start_service('druby://localhost:0')
   ro = DRbObject.new_with_uri('druby://localhost:50830')
   ro.start(ENV.to_hash, $stdin, $stdout)

 その人のコードを見続けていると、この人はどうしてこんなコードを書いたのか、というのがわかってきます
 (想像できるようになってくるだけで、わかってはいないかもしれません) 。
 昔、咳さんのコードを見ていた私からすると「このコードはいろんなプロダクツで使いまわしているコードだろうなぁ」と感じます。

 ちゃんと書いた咳さんのコードでは「ro (たぶん、Remote Object の略) 」という名前を使いません。
 咳さんなら「wikir (リモートにあるどのオブジェクトを触るかがわかる名前。一見、ローカルのオブジェクトに
 見える名前をつけるはずです。wikir.rb の最後を見るとリモートにあるのは WikiR::UI ですが、ui にはしないはず
 です。リモートのオブジェクトを提供する側は公開用に WikiR::UI というオブジェクトを用意していますが、
 使う側からすれば Wiki サービスを使いたいだけなので、それが UI 用のやつかどうかなんて気にしたくありません。) 」や
 「front (dRuby 本でも使われている伝統的な名前) 」といった名前を使うはずです。
{% endraw %}
{% endhighlight %}


その通り、このコードは使い回しです。相手が特定の何かであることを意図しないので remote object としています。there でもよかったんだけど。

最近のテストコードはもっとひどくて、ファイル名をそのままポート番号にしています。外部のサービスでこんなことをする人はいないと思うけど、紹介しておきます。

54321.rb

{% highlight text %}
{% raw %}
 require 'drb/drb'

 DRb.start_service('druby://localhost:0')
 ro = DRbObject.new_with_uri('druby://localhost:' +  File.basename($0, '.rb'))
 ro.start(ENV.to_hash, $stdin, $stdout)
{% endraw %}
{% endhighlight %}


### まとめ

須藤さんからいただいたコメントにたくさん言い訳しました。
気になるポイントは近いのに選んだコードが違うことが多いことに (慣れてたけど) やっぱり驚きました。

意識の高い読者が多いところで述べるのは怖いのですが、最後に。
コードのどうでもいいところはどうでもよく書く。それも意図の表現のひとつであると思っています。

次回は別のペアでやってくださいー。

### 延長戦

咳さんからの文通のお返事を受けて、メールで追加のやりとりがありましたので紹介します。結論を出そうというものではないので、自分の判断をするときに両者の視点を参考にしてもらえればと思います。

以下、須藤さんからのコメントです。

> 例外の話へのコメントが書けそうであればお願いします。
> 咳さんのいいわけに納得ならそれで終わりです。


納得というか、そういう考えもあるんだーとは思いますが、じゃあ私も今度からはその方向で！となることはあんまりなくて、今回もそうなのでコメントを書きますね (別に咳さんの考えが間違っているとは思わなくて、そういう考え方もあるのかーという感じです。念のため) 。

> このメソッドにはそれよりも気になることがあります。それは、例外を握りつぶしているという事です。
> 
> wikir.rb:
>  81 def do_request(req, res)
>   ...
>  86 rescue
>  87 end
> 
> rescue の中でログを出力するなどした方がよいです。
> 
> これはあえてそうしています。do_requestはWikiRの中で、外部からくる怪しい入力を濾過してきれいな入力だけを扱うメソッドと位置づけました。怪しい入力を却下し、扱える入力だけを処理します。怪しい入力はいろいろな方法で怪しく、それに対してアプリケーションができることはほとんど残されていません。せいぜいログを吐いてユーザに言い訳するくらいでしょう。それくらいならhttpdのログにもあるし、rubyの起動オプションで印字することもできます。


httpdのログにはPOSTの内容が残らないので再現できないんですよねぇ。起動オプション（-dのことです）だと余計なものがたくさんでて目的のものをみつけるのが大変にな（ることがあ）ります。

私はデバッグのしやすさを大事にしたいんだなぁと思いました。バグ（想定していない動作のことで、今回の場合だとこの入力は受け付けてほしいなーと思ったのに実際は無視されたという挙動）は自分で使っているときにもおきますが、他の人が使っているときにもおきます。私は、自分だけが使うツールよりも、自分以外の人も使うツール（自分以外の人にも使って欲しいツール）を作ることが多いので、手元でバグを調べることができないこともあります。そういうときに、必要な情報をとる仕組みがあると便利なんですよね。「ここにでているログを見せてもらえませんか？」とかができるので。

自分だけが使うツールならログも出さなくてもいいかなぁとは思います。

> まず「例外を握りつぶす」という表現がよくわかりません。アプリケーションはいつかどこかで例外を処理しなくてはなりません。
> 例外はそれぞれの間で適切にフィルタされるべきものだと思っています。ライブラリを設計するとき、全ての例外をそのまま通すのは簡単です。
> その処理の責任を呼び手に押し付けるわけですから。アプリケーションはライブラリの値域に対して正しく動くように書かなくてはなりません。
> 例外の設計はエラー値のの設計でもあります。ライブラリはアプリケーションが書き易いような値域にすることを心がけるべきです。
> 例外を返すということは、アプリケーションがそれを処理するべきだ、という意思表示です。アプリケーションにとって役に立つ例外はなんでしょう。
> do_requestに関して言えば、ここで例外をあげてもアプリケーションができることはないし、積極的に例外を捨てることが正しいと判断しました。


例外を捨ててもいいのですが、例外があったということはわかるようにして欲しいなぁということでした。理由はデバッグしやすいので。

### バックナンバー

{% for post in site.tags.CodePostMortem %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}

----

[^1]: 井上さん注：いけていない (というよりスペルミスじゃないかという) 指摘をしたのは私というより PragMagazine 編集者のスザンナです。あと私の会社の同僚は Euruko で Matz に「elsif」がいけていないと直接指摘していました (別に Ruby だけの文法でもないのですが) 。英語圏の人も単語の省略はしますが、日本人のしかたとちょっとやりかたが違うんではないでしょうか。
