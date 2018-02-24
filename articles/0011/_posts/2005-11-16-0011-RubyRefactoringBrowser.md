---
layout: post
title: 解説 Ruby Refactoring Browser - Ruby Refactoring Browser の組み込み
short_title: 解説 Ruby Refactoring Browser - Ruby Refactoring Browser の組み込み
tags: 0011 RubyRefactoringBrowser
---
{% include base.html %}


* Table of content
{:toc}


文章: 大林一平

## はじめに

この文章では Ruby Refactoring Browser を様々な IDE、エディタに組み込み、
利用できるようにするために必要なことを解説します。

Ruby Refactoring Browser に関する基本的な事柄や Emacs での使いかたなどについて
知りたい方は、前回の記事 ([解説 Ruby Refactoring Browser - Emacs でリファクタリング]({% post_url articles/0010/2005-10-10-0010-RubyRefactoringBrowser %})) を参照してください。

### この文章が対象とする読者

この文章の読者には、少なくともリファクタリングについて一定の知識を持って
いることと、Ruby についてそれなりの知識があることを仮定します。

また、例としては Emacs と Vim での実装を挙げるので、それらについて
知識があったほうが理解しやすいでしょう。

### なぜ組み込むのか

なぜリファクタリングブラウザを組み込むのでしょうか。
仮に、リファクタリングブラウザが IDE とは独立したツールであった場合を考えましょう。
そのときには、以下の手順でこのツールを利用することになります。

1. IDE 上のファイルをすべてセーブする。
1. リファクタリングブラウザにそのファイルを読み込む。
1. リファクタリングする。
1. リファクタリングした後のファイルを IDE へロードする。


リファクタリングをしようとするとこれを何度も繰り返す必要があります。
これは非常に面倒です。

よって、快適にリファクタリングするためには、自分の開発環境
になんらかの形でリファクタリングブラウザを組込み、手軽に使えるよう
にする必要があるのです。

### 準備

あらかじめ Ruby Refactoring Browser をインストールし、正しく動作するかテストして
おいてください。

## 内部構造

組み込み方を説明する前に内部構造を解説します。

まず全体像を図示しましょう。
図の上の方が EmacsLisp で、下のほうが Ruby で実装されています。

{% highlight text %}
{% raw %}
 -----------------------------
 |  emacs interface(rrb.el)  |
 -----------------------------
     |
     | pipe によるプロセス間通信
     |
 -----------------------------
 |     bin/rrb               |
 |---------------------------|
 |     コアライブラリ        |
 |---------------------------|
{% endraw %}
{% endhighlight %}


下部から解説していきましょう。

まず、リファクタンリング機能を実現するコアの部分です。
ソースコードとリファクタリングに必要なパラメータ
(例えば古い変数名と新しい変数名など)
をうけとり、リファクタリング可能かを判定し、
可能ならばその結果を返す、という機能を実現しています。
ここは Ruby で書かれています。

次に、 Emacs とのやりとりをする部分の Ruby 側の部分です。
これは bin/rrb というコマンドとして実現されています。
その実体は lib/rrb/emacs_interface.rb です。

最後に EmacsLisp で書かれた部分です。基本的にユーザからの入力を受けとり、
bin/rrb を呼びだしている (call-process、call-process-region) だけです。

## 実装の方針

実際に組み込む方法を解説していきます。
まずは、どのようにして対象のエディタに組込むのかを考えていきます。
以下の 3 つの方針を考えましょう。

1. コアライブラリの部分だけ利用する。
1. bin/rrb コマンド部も利用する。
1. 新たなプロセス間インターフェースを作る。


1 は対象の IDE / エディタに Ruby が組込まれている場合、
もしくはそれが Ruby で書かれている場合に有効です。
この方針は面倒なプロセス間通信をしなくてよい分プログラムが簡潔に
なることが期待できます。

2 は対象の IDE / エディタが Ruby を直接利用できない場合につかいます。

3 は COM や CORBA のインターフェースを作ってしまおうというアイデアです。
面倒なので今のところやっていませんが、Windows などでは有用かもしれません。

## Emacs での例

まずは上の方針 2 に従った実装例として Emacs での例をあげましょう。
Ruby Refactoring Browser の配布物には Emacs 用インターフェースとして
rrb.el が付属していますが、これはエラー処理や便利な機能の実現のため複雑
になっています。そのためここでは
それを非常に簡略化したものを例として挙げます。

Emacs や Emacs Lisp に詳しくない人にとっては少々わかりにくいかもしれませんが
elisp の解説 (info など) を読んで補完してください。

また、以下の例は Debian testing 上の Emacs のバージョン 21.4.1 で動作することを
確認しています。

### 実現する仕様

まずどんな仕様にするかを考えましょう。簡単のため、以下のようにします。

1. リファクタリングの対象となるファイルはカレントバッファのファイルのみ
1. Rename local variable のみ実装する
1. ユーザに「どのクラス」の「どのメソッド」に含まれる「どのローカル変数」を「どのような名前」に変更するかを指定させる


注: カレントバッファとは現在編集しているファイルのこと

### bin/rrb コマンド

まずは rrb コマンドの仕様について解説します。コマンドライン上で

{% highlight text %}
{% raw %}
 rrb
{% endraw %}
{% endhighlight %}


とだけ打つと、以下のようなヘルプメッセージが得られます。

{% highlight text %}
{% raw %}
 Usage: rrb refactoring-type refactoring-parameter io-type

   refactoring-type
     * --rename-local-variable  Class#method old_var new_var
     * --rename-method-all  old_method new_method
     * --rename-class-variable  Class old_var new_var
     * --rename-instance-variable  Class old_var new_var
     * --rename-global-variable  old_var new_var
     * --extract-method path new_method start_lineno end_lineno
     * --rename-method "old-class1 old-class2..." old_method new_method
     * --rename-constant old_const new_const
     * --pullup-method old_class#method new_class path lineno
     * --pushdown-method old_class#method new_class path lineno
     * --remove-parameter class#method parameter
     * --extract-superclass namespace new_class "target-class1 target-class2..." path lineno

   io-type
     * --stdin-stdout
     * --filein-overwrite FILES..
     * --filein-stdout FILES..
     * --marshalin-overwrite FILE
     * --marshalin-stdout FILE
{% endraw %}
{% endhighlight %}


まずどのリファクタリングをするかを refactoring-type オプション群から選び、
そのリファクタリングに必要なパラメータ (例えば新しい変数名など) を
二番目以降の引数 (refactoring-parameter) に指定します。
最後にリファクタリングの対象となるファイルのやりとりの方法を
io-type オプション群から選んで指定します。

Heke::Hoge クラスの f というメソッドの中の i というローカル変数を index に変更する
リファクタリングをさせる場合の例を下に挙げましょう。

{% highlight text %}
{% raw %}
 rrb --rename-local-variable Heke::Hoge#f i index --stdin-stdout
{% endraw %}
{% endhighlight %}


また、/home/ohai/test.rb の 10 行目から 17 行目までを foo というメソッドとして
抽出する場合は以下のようにします。

{% highlight text %}
{% raw %}
 rrb --extract-method /home/ohai/test.rb foo 10 17 --stdin-stdout
{% endraw %}
{% endhighlight %}


「--stdin-stdout」というオプションは、リファクタリング対象の
ファイルを標準入力に渡し、リファクタリングした結果を標準出力から得る、
ということを指定しています。

そして受け渡しのフォーマットは以下の通りです。

{% highlight text %}
{% raw %}
 ファイル 1 のパス \C-a ファイル 1 の内容
 \C-a ファイル 2 のパス \C-a ファイル 2 の内容
   …
 \C-a ファイル n のパス \C-a ファイル n の内容
 \C-a-- END --\C-a
{% endraw %}
{% endhighlight %}


ここで \C-a はアスキーコード 1 の文字を表しています。

### 実装

まずはインターフェースから実装していきましょう。

{% highlight text %}
{% raw %}
 (defun rrbs-rename-local-variable (class method old-var new-var)
   (interactive "sClass: \nsMethod: \nsOldVariable: \nsNewVariable: ")
   )
{% endraw %}
{% endhighlight %}


入力部分はこれで OK です。interactive を使って 4 つの文字列を入力させ、
それぞれ class, method, old-var, new-var という変数に束縛します。

ちなみに関数名のプリフィクスになっている rrbs は「rrb simple」の省略形です。この後も使います。

つぎに入力データの準備をしましょう。

{% highlight text %}
{% raw %}
 (defun rrbs-rename-local-variable (class method old-var new-var)
   (interactive "sClass: \nsMethod: \nsOldVariable: \nsNewVariable: ")
   (let ((path (buffer-file-name (current-buffer)))
         (content (buffer-string))
         (input-buf (get-buffer-create " *rrbs-input*"))
         (output-buf (get-buffer-create " *rrbs-output*")))
     (save-excursion
       (set-buffer input-buf)
       (erase-buffer)
       (insert path)
       (insert "\C-a")
       (insert content)
       (insert "\C-a")
       (insert "-- END --")
       (insert "\C-a"))))
{% endraw %}
{% endhighlight %}


(buffer-file-name (current-buffer)) でカレントバッファのファイル名を、
(buffer-string) でカレントバッファの中身を得ています。

また、入出力用のバッファを別に " *rrbs-input*" 、 " *rrbs-output*" という
名前で用意します。そして (insert 文字列) で入力用バッファに文字列
を書き込みます。

これで

{% highlight text %}
{% raw %}
 class Heke
   def f(x,y)
     x ** 2 + y ** 2
   end
 end
{% endraw %}
{% endhighlight %}


というソース (/home/ohai/test.rb) に対し  

{% highlight text %}
{% raw %}
 /home/ohai/test.rb^Aclass Heke
   def f(x,y)
     x ** 2 + y ** 2
   end
 end
 ^A-- END --^A
{% endraw %}
{% endhighlight %}


という内容のデータが" *rrbs-input* "に用意されます。

次に rrb コマンドを呼びだします。

{% highlight text %}
{% raw %}
 (defun rrbs-rename-local-variable (class method old-var new-var)
   (interactive "sClass: \nsMethod: \nsOldVariable: \nsNewVariable: ")
   (let ((buf (current-buffer))
         (path (buffer-file-name (current-buffer)))
         (content (buffer-string))
         (input-buf (get-buffer-create " *rrbs-input*"))
         (output-buf (get-buffer-create " *rrbs-output*")))
     (save-excursion
       (set-buffer input-buf)
       ;; clear input buffer
       (erase-buffer)

       ;; setup input data
       (insert path)
       (insert "\C-a")
       (insert content)
       (insert "\C-a")
       (insert "-- END --")
       (insert "\C-a")

       ;; clear output buffer
       (set-buffer output-buf)
       (erase-buffer)
       (set-buffer input-buf)

       ;; call "rrb" command
       (call-process-region (point-min) (point-max) "rrb" nil output-buf nil
                            "--rename-local-variable"
                            (concat class "#" method)
                            old-var new-var))))
{% endraw %}
{% endhighlight %}


call-process-region でプロセスを起動し、rrb コマンドを呼びだします。
引数の詳しい意味は info を見てください。
この結果、リファクタリングされたソースコードが " *rrbs-output*" に出力されます。

例えば上の例で Heke#f の x を u にリネームすると

{% highlight text %}
{% raw %}
 /home/ohai/test.rb^Aclass Heke
   def f(u,y)
     u ** 2 + y ** 2
   end
 end
 ^A-- END --^A
{% endraw %}
{% endhighlight %}


という内容となります。

最後に出力結果をもとのバッファに反映します。

{% highlight text %}
{% raw %}
 (defun rrbs-rename-local-variable (class method old-var new-var)
   (interactive "sClass: \nsMethod: \nsOldVariable: \nsNewVariable: ")
   (let ((buf (current-buffer))
         (path (buffer-file-name (current-buffer)))
         (content (buffer-string))
         (result)                        ; Result string
         (input-buf (get-buffer-create " *rrbs-input*"))
         (output-buf (get-buffer-create " *rrbs-output*")))
     (save-excursion
       (set-buffer input-buf)
       ;; clear input buffer
       (erase-buffer)

       ;; setup input data
       (insert path)
       (insert "\C-a")
       (insert content)
       (insert "\C-a")
       (insert "-- END --")
       (insert "\C-a")

       ;; clear output buffer
       (set-buffer output-buf)
       (erase-buffer)
       (set-buffer input-buf)

       ;; call "rrb" command
       (call-process-region (point-min) (point-max) "rrb" nil output-buf nil
                            "--rename-local-variable"
                            (concat class "#" method)
                            old-var new-var)

       ;; set refactored code to 'result'
       (set-buffer output-buf)
       (setq result (cadr (split-string (buffer-string) "\C-a"))))
     ;; clear old ruby source
     (erase-buffer)
     ;; insert new ruby source
     (insert result)))
{% endraw %}
{% endhighlight %}


(setq result (cadr (split-string (buffer-string) "\C-a")))
で必要な部分を取りだし、
(erase-buffer) でもとの内容を全消去、 (insert result) で新たな内容を反映
して終わりです。

### rrb コマンドに関する注意

「--pushdown-method」「--pullup-method」「--extract-superclass」
の 3 つのオプションは、
どのファイルのどの行に新しいメソッド/クラスを生成するのかを
引数 path と lineno で指定します。

「--extract-superclass」オプションのように複数のクラスを指定するときは、
一つのコマンドライン引数でまとめて渡す必要があります。
したがってコマンドラインから使うときは "Class1 Class2 Class3"
のようにクオートでくくらなければいけません。

上の例では一切エラー処理をしていませんが、rrb コマンドの返り値が 0 でない場合は
エラーで、エラーの原因は stderr から得られます。ちゃんとした実装をしようとし
た場合はきちんとエラー処理する必要があるでしょう。

### 「rrb_なんとか」コマンド

Ruby Refactoring Browser の配布物のなかには、rrb コマンドの他にも、
rrb_marshal, rrb_compinfo, rrb_default_value というコマンドがあります。
それぞれ引数無しで呼べば引数の種類等がわかります。

 rrb_compinfo INFOTYPE IOTYPE 
: 
:  Ruby スクリプトをパースし、含まれる識別子のリストを得るコマンドです。クラス名のリスト、ローカル変数名のリストなどが得られます。この情報を補完をするためなどに利用します。

 rrb_default_value PATH LINENO INFOTYPE IOTYPE 
: 
:  Ruby スクリプトをパースし、指定したファイルの指定した行のところのメソッド名/クラス名は何か、を得るためのコマンドです。得た文字列をユーザに入力させる値のデフォルト値として利用します。

 rrb_marshal 
: 
:  上で挙げたコマンドを利用すると、スクリプトのパースと構文木の構築を何度も実行することになります。これは実行コストが高いので、あらかじめスクリプトをパースし、生成した構文木を Marshal を利用してファイルに出力することで高速化できる場合があります。rrb_marshal はそのためのコマンドです。rrb コマンドの --marshalin-stdout などはこれを利用するためにあります。

以上のコマンドで、出力される内容やその形式など詳しいことは
それぞれのソースを読んでください。

## Vim での例

Emacs の次は Vim で実装してみましょう。Vim には独自のスクリプト言語があり、
そこから ruby のインタプリタとやりとりすることができます。
これを利用しましょう。

仕様は以下の通りにしましょう。

1. リファクタリングの対象となるファイルはカレントバッファのファイルのみ
1. Rename local variable のみ実装する
1. リネームする変数はカーソルの下にあるものとする
1. 新しい変数名はユーザに入力させる


以下での例を実行するためには、
Vim のコンパイル時に ruby インターフェースを有効にしておく必要があります。
この例は Debian testing 上で ruby インターフェースを有効にした Vim 6.3 で
動作を確認しています。

Vim スクリプトや Ruby インターフェースについては詳しく解説
しませんので、Vim のヘルプを参考にしてください。

### コアライブラリの仕様

まず、

{% highlight text %}
{% raw %}
 require 'rrb/rrb'
{% endraw %}
{% endhighlight %}


でライブラリをロードします。

コアライブラリの中で中心的なクラスは RRB::Script と RRB::ScriptFile です。
RRB::ScriptFile が個々のファイルで、それを集約したものが RRB::Script です。

 RRB&#58;&#58;ScriptFile.new(str, path) 
: 
:  新しい ScriptFile のインスンタンスを生成し返す。str はそのファイルの中身の文字列、path はファイルパス文字列。

 RRB&#58;&#58;Script.new(files) 
: 
:  新しい Script のインスンタンスを生成し返す。files は ScriptFile のインスタンスの配列。

 RRB&#58;&#58;Script#files 
: 
:  含まれる RRB::ScriptFile のインスタンス全ての配列。

 RRB&#58;&#58;Script#rename_local_var?(method, old_var, new_var) 
: 
:  そのファイル群が Rename Local variable 可能かどうか判定する。method は RRB::Method のインスタンスでどのメソッドのローカル変数を変更するかを指定する。old_var は古い変数名、new_var は新しい変数名。

 RRB&#58;&#58;Script#rename_local_var(method, old_var, new_var) 
: 
:  実際に変換する。引数の意味は RRB::Script#rename_local_var? と同じ。

 RRB&#58;&#58;ScriptFile#new_script 
: 
:  変換した結果の文字列。nil ならば変更点がないことを示している。

 class RRB&#58;&#58;Method 
: 
:  クラス名とメソッド名の組を表すクラス。

 RRB&#58;&#58;Method[str] 
: 
:  新しいインスタンスを作成する。str は "Foo::Bar#baz" という形式の文字列で与える。

この他にも様々なクラス、メソッドがあります。

Ruby Refactoring Browser の配布物の doc/dev/rrb_embed.ja.rd に解説が書かれています。
また、これだけでは不十分な場合はすいませんが直接ソースを見てください。

### Vim での実装

全体の枠組みを作っていきます。

{% highlight text %}
{% raw %}
 command -nargs=1 RRBRenameLocalVariable :call s:RRBRenameLocalVariable(expand("<args>"))

 ruby << EOS
 # here is ruby script
 def rename_local_var(new_var)
 end
 EOS

 function s:RRBRenameLocalVariable(newvar)
   execute "ruby rename_local_var(\"" . a:newvar . "\");"
 endfunction
{% endraw %}
{% endhighlight %}


これで vim に RRBRenameLocalVariable というコマンドが登録され、

{% highlight text %}
{% raw %}
 :RRBRenameLocalVariable foo
{% endraw %}
{% endhighlight %}


とすることで foo という文字列が ruby の rename_local_var というメソッドに
渡されるようになりました。

カーソルのある位置にある識別子を取る処理を書きます
VIM::Window#cursor でカーソルの位置を得、VIM::Buffer#[] で一行分の文字列
を得ます。

{% highlight text %}
{% raw %}
 command -nargs=1 RRBRenameLocalVariable :call s:RRBRenameLocalVariable(expand("<args>"))

 ruby << EOS
 # here is ruby script
 require 'rrb/rrb'
 def vim_buffer_content(buf)
   (1..(buf.count)).inject(""){|r, i| r << buf[i] << "\n"; r}
 end

 def search_id(str, col)
   st = (str.rindex(/[^a-zA-Z_]/, col) || -1) + 1
   ed = (str.index(/[^a-zA-Z_]/, col) || str.size + 1) - 1
   str[st..ed]
 end

 def rename_local_var(new_var)
   path = VIM::Buffer.current.name
   lineno, col = VIM::Window.current.cursor
   old_var = search_id(VIM::Buffer.current[lineno], col)
 end
 EOS

 function s:RRBRenameLocalVariable(newvar)
   execute "ruby rename_local_var(\"" . a:newvar . "\");"
 endfunction
{% endraw %}
{% endhighlight %}


次にカーソルのある行のクラスの名前およびメソッドの名前を作ります。

{% highlight text %}
{% raw %}
 command -nargs=1 RRBRenameLocalVariable :call s:RRBRenameLocalVariable(expand("<args>"))

 ruby << EOS
 # here is ruby script
 require 'rrb/rrb'
 def vim_buffer_content(buf)
   (1..(buf.count)).inject(""){|r, i| r << buf[i] << "\n"; r}
 end

 def search_id(str, col)
   st = (str.rindex(/[^a-zA-Z_]/, col) || -1) + 1
   ed = (str.index(/[^a-zA-Z_]/, col) || str.size + 1) - 1
   str[st..ed]
 end

 def rename_local_var(new_var)
   path = VIM::Buffer.current.name
   lineno, col = VIM::Window.current.cursor
   old_var = search_id(VIM::Buffer.current[lineno], col)

   content = vim_buffer_content(VIM::Buffer.current)
   script = RRB::Script.new([RRB::ScriptFile.new(content, path)])

   method = script.get_method_on_cursor(path, lineno).name

 end
 EOS

 function s:RRBRenameLocalVariable(newvar)
   execute "ruby rename_local_var(\"" . a:newvar . "\");"
 endfunction
{% endraw %}
{% endhighlight %}


上で説明したように RRB::Script のインスタンスを作ります。そして
RRB::Script#get_method_on_cursor(path, lineno) でその行がどのメソッド
に含まれているかを得ます。
これで変数 methodname に "Hoge#f" という形の文字列が代入されます。

今度はリファクタリングが可能かどうかの判定をします。

{% highlight text %}
{% raw %}
 command -nargs=1 RRBRenameLocalVariable :call s:RRBRenameLocalVariable(expand("<args>"))

 ruby << EOS
 # here is ruby script
 require 'rrb/rrb'
 def vim_buffer_content(buf)
   (1..(buf.count)).inject(""){|r, i| r << buf[i] << "\n"; r}
 end

 def search_id(str, col)
   st = (str.rindex(/[^a-zA-Z_]/, col) || -1) + 1
   ed = (str.index(/[^a-zA-Z_]/, col) || str.size + 1) - 1
   str[st..ed]
 end

 def rename_local_var(new_var)
   path = VIM::Buffer.current.name
   lineno, col = VIM::Window.current.cursor
   old_var = search_id(VIM::Buffer.current[lineno], col)

   content = vim_buffer_content(VIM::Buffer.current)
   script = RRB::Script.new([RRB::ScriptFile.new(content, path)])

   method = script.get_method_on_cursor(path, lineno).name

   unless script.rename_local_var?(RRB::Method[method], old_var, new_var)
     VIM.message(script.error_message)
     return
   end
 end
 EOS

 function s:RRBRenameLocalVariable(newvar)
   execute "ruby rename_local_var(\"" . a:newvar . "\");"
 endfunction
{% endraw %}
{% endhighlight %}


RRB#script#rename_local_var? で判定します。真なら可能、偽なら不可能です。
ローカル変数のリネームの場合、同じ名前の新しい名前の変数がすでに存在
する場合などに偽が帰ってきます。

そして失敗した場合は VIM.message で Vim にメッセージを表示させ終了するように
しました。

最後に実際に変換して、その結果を反映させます。

{% highlight text %}
{% raw %}
 command -nargs=1 RRBRenameLocalVariable :call s:RRBRenameLocalVariable(expand("<args>"))

 ruby << EOS
 # here is ruby script
 require 'rrb/rrb'
 def vim_buffer_content(buf)
   (1..(buf.count)).inject(""){|r, i| r << buf[i] << "\n"; r}
 end

 def search_id(str, col)
   st = (str.rindex(/[^a-zA-Z_]/, col) || -1) + 1
   ed = (str.index(/[^a-zA-Z_]/, col) || str.size + 1) - 1
   str[st..ed]
 end

 def clear_vim_buffer(buf)
   buf.delete(1) until buf.count == 1
   buf[1] = ""
 end

 def append_vim_buffer(buf, content)
   content.split(/\n/).reverse_each do |line|
     buf.append(0, line)
   end
 end

 def rename_local_var(new_var)
   path = VIM::Buffer.current.name
   lineno, col = VIM::Window.current.cursor
   old_var = search_id(VIM::Buffer.current[lineno], col)

   content = vim_buffer_content(VIM::Buffer.current)
   script = RRB::Script.new([RRB::ScriptFile.new(content, path)])

   method = script.get_method_on_cursor(path, lineno).name

   unless script.rename_local_var?(RRB::Method[method], old_var, new_var)
     VIM.message(script.error_message)
     return
   end

   script.rename_local_var(RRB::Method[method], old_var, new_var)
   new_script = script.files[0].new_script
   if new_script != nil
     clear_vim_buffer(VIM::Buffer.current)
     append_vim_buffer(VIM::Buffer.current, new_script)
   end
 end
 EOS

 function s:RRBRenameLocalVariable(newvar)
   execute "ruby rename_local_var(\"" . a:newvar . "\");"
 endfunction
{% endraw %}
{% endhighlight %}


RRB::Script#rename_local_var で変換をします。変換した結果は
RRB::ScriptFile#new_script から取りだせます。

## さらなる開発のために

ここまで説明してきたことはごく基本的な内容です。さらにきちんとしようと
考えると以下のような問題が考えられます。

### UI の問題

上で挙げた Emacs の例のような UI を作るのであれば補完入力は必須でしょう。
また、Rename Method では任意個のクラスを指定できるので、これに対応するた
めの UI を作るのは面倒になるかもしれません。各開発環境に合わせて適切な
UI を考えてください。

### エラー処理

上に挙げた例はエラー処理等を殆どしていません。実用的なものに仕上げるには
きちんとエラー処理をする必要があるでしょう。

### 複数のファイルを対象にする

ある程度大規模なプログラムであればプログラムが複数のファイルに
分かれている場合が考えられるでしょう。その場合どのファイルをリファクタリング
の対象とし、どれを対象としないかを判別するのは結構難しい問題です。

RDT のようにプロジェクトという単位でファイルを管理している場合は
簡単ですが、そうでない場合はどうすれば良いのでしょうか。
Emacs インターフェースでは、その
Emacs プロセスで開いているファイルをすべてひとかたまりのものとして
扱っています。複数のファイルが開けるエディタならこの方法が良いかも
しれません。Vim ではそのファイルと同じディレクトリにある Ruby スクリプト
全体を対象にしてしまっても良いかもしれません。

これに対する一般的な回答はありません。そのエディタや IDE の性質に
合わせて適宜決めてください。

## 最後に

参考資料としてはやはり Ruby Refactoring Browser のソースが一番でしょう。
lib/rrb/cui_interface.rb、lib/rrb/emacs_interface.rb は Ruby 側の例として
参考になるでしょう。 FreeRIDE に付属しているリファクタリングプラグイン
や、elisp/rrb.el も見てください。

わからないことがあれば遠慮なく筆者 (ohai@kmc.gr.jp) に質問してください。

筆者の個人的願望としては RDT や RDE、xyzzy などが対応してくれないかなあ、
と思っています。

様々な環境で Ruby Refactoring Browser が使えるようになることを
願っています。

## 著者について

私 (大林) は京都で大学院生をしています。専門は数学です。
また KMC (京大マイコンクラブ) 部員でもあります。
Ruby Refactoring Browser の主要開発者です。
Ruby Refactoring Browser は最初 KMC 内部のプロジェクトとして開発を開始しました。

## 解説 Ruby Refactoring Browser 連載一覧

{% for post in site.tags.RubyRefactoringBrowser %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}


