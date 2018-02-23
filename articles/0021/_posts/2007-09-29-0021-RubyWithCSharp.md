---
layout: post
title: C# と Ruby を連携させる
short_title: C# と Ruby を連携させる
tags: 0021 RubyWithCSharp
---
{% include base.html %}


書いた人：星一

* Table of content
{:toc}


## はじめに

C# と Ruby を連携させるための (バッド) ノウハウを解説します。 Ruby から .NET の機能を呼び出したりすることが出来ます。

巷では、 IronRuby とか DLR とか色々話題になっていますが、今回の方法はそんなの関係ありません。 IronRuby は絶賛開発中ですが、ここで扱う方法は MatzRuby そのものを使うため、 Ruby の機能を制限なく活用しつつ、今すぐ試すことができます。ただし、拡張ライブラリのようなものが作れるわけではなく、閉じた環境でしか実行できないものになります。

### 前提知識

* C# の匿名デリゲートが分かる程度
* 組み込み Ruby の基本的なことが分かる程度


### その他

ここで扱う方法は忘れて、将来は素直に IronRuby を使ったほうがいいと思います。

## 背景

1. C# (.NET) には、 P/Invoke という、 C で書かれた DLL などの関数を呼び出せる機能がある
1. Ruby (Matz Ruby) は C で書かれている
1. しかも、 Ruby の機能をいじくる C のインターフェイスがとっても扱いやすい
1. C# で Ruby の DLL の関数呼べばなんでもできるね


というわけで、 C# で C の関数を呼び出して実行するのがメインになります。

## 準備

以下のものを準備します。

* [Visual C# 2005 Express](http://www.microsoft.com/japan/msdn/vstudio/express/vcsharp/)
* msvcrt-ruby18.dll (後述)


今回は Windows でのみ動作確認を行いました。 Linux でも [Mono](http://www.mono-project.com/) を使えば出来るかもしれません。

### Visual C# Express で新しいプロジェクトを作る

今回はコンソールアプリケーションで説明します。

名前は別に何でもいいです。ここでは「RubyTest」というプロジェクト名、名前空間であるとして説明します。

### Ruby の DLL を手に入れる

Windows 用の Ruby のライブラリを手に入れます。 mswin32 版でも cygwin 版でも mingw 版でも、どれでも OK なはずです[^1]。

今回は [mswin32 版](http://www.garbagecollect.jp/ruby/mswin32/ja/)の、 1.8.x 系統を使います[^2]。

### プロジェクトに DLL を追加する

下図のように、 DLL を追加してやります。
![project_tree.png]({{base}}{{site.baseurl}}/images/0021-RubyWithCSharp/project_tree.png)

さらに DLL の「出力ディレクトリにコピー」プロパティを「常にコピーする」に設定します。
![dll_property.png]({{base}}{{site.baseurl}}/images/0021-RubyWithCSharp/dll_property.png)

参照の設定は要りません。

現在 Ruby 1.8.x の、 64bit Windows 向けのバイナリは存在しません。そのため、そのまま C# をコンパイルしてしまうと、 DLL の関数呼び出し時に例外 (BadImageFormatException) が投げられます。デフォルトでは、 C# のコンパイルのターゲットは "Any CPU" となっており、 C の DLL と連携する際、想定する DLL の形式が実行環境依存になってしまうからです。 64 bit 版の Windows で試す場合は、 C# コンパイルのターゲットを 32 bit (x86) 用にして、 32 bit 互換モードで実行させてやる必要があります。

Visual C# Express の場合、

1. 「ツール」→「オプション」を開く
1. 左下隅の「すべての設定を表示」にチェックを入れる
1. 「プロジェクトおよびソリューション」→「全般」の「ビルド構成の詳細を表示」にチェックを入れる


という手順でビルドの詳細が設定できるようになり、ターゲットを設定することが出来るようになります。

## ファイルに出力 (Hello, World)

Ruby の Hello, World のスクリプトを、 C# から実行させましょう。標準出力 (コンソールに出力) はまだできないので、ファイルに出力します。

### ポーティング

Ruby の DLL で定義されている関数を、 C# で使えるように「ポーティング」してあげます。説明するのがだるいので、実例をさっさと挙げてしまいます。

{% highlight text %}
{% raw %}
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices; // (1)
using System.Text;
using VALUE = System.Int32; // (2)

namespace RubyTest
{
    static class Ruby
    {
        public const string RubyDll = "msvcrt-ruby18"; // (3)

        [DllImport(RubyDll)]
        public static extern void ruby_init(); // (4)

        [DllImport(RubyDll)]
        public static extern VALUE rb_eval_string_protect(byte[] script, ref VALUE state); // (5)

        public static VALUE rb_eval_string_protect(string script, ref state) // (6)
        {
            return rb_eval_string_protect(Encoding.UTF8.GetBytes(script + '\0'), ref state);
        }
    }
}
{% endraw %}
{% endhighlight %}


(1): DllImportAttribute を使用するための using です。 DllImportAttribute 属性はメソッドに付加する属性で、外部 DLL で定義されていることを表します。

(2): VALUE は、 Ruby のオブジェクトを一意に表す整数型です。整数型や nil などの特殊な値を除いて、ポインタの値そのものです。

今回使用する Ruby の DLL では VALUE は 32 bit 整数型 (のはず) であり、 C# では int (System.Int32) と同じです。ソースコード上で、 C# の int と、 VALUE の意味での int が混合するのは紛らわしいので、 (2) のようにエイリアスを作ってやります。

(3): DLL のパスを表す文字列定数です。拡張子は要りません。

以下、必要最小限の関数だけ定義してやります。

(4): C で定義された ruby_init() を C# で使う場合、このように記述します。 extern は C# の予約語です。この関数は引数がなく、返り値の型 void なので非常に素直に書けます。こんなのばかりだといいのですが、そういうわけには行きませんね。

(5): rb_eval_string_protect(char *script, int *state) 関数のポーティングです。この関数は、文字列の script を Ruby スクリプトとして評価します。例外発生時に、 state が NULL でない場合に例外オブジェクトの VALUE 値が代入されます。戻り値は評価された Ruby オブジェクトをあらわす VALUE です。

protect のつかない、 rb_eval_string 関数は今回は使いませんでした。 rb_eval_string 関数を使用した場合、スクリプト評価時に例外が発生すると、 C# 側で予期せぬエラーが生じるからです。

C で定義された関数を C# から呼び出すために、 .NET の「マーシャリング」を利用します。マーシャリングとは、 .NET の型とネイティブ型を相互変換する機能です。 C の型と C# (.NET) の型には一定のルールがあり[^3]、非常に複雑ですが、適当に抜粋すると以下のようになります。

| C| C#|
|---|---|
| char| byte|
| 32 bit 整数| int|
| 64 bit 整数| long|
| float| float|
| double| double|
| ポインタ| ポインタ|
| ポインタ| IntPtr 構造体|
| ポインタ| 参照渡し (ref)|
| ポインタ| 配列|
| char ポインタ| string|
| 関数ポインタ| デリゲート|


今回、 char* を byte[] 型にしました。文字コードに自由を効かせたいためです。

「マーシャリング」という言葉は Ruby の Marshal と紛らわしいので、以後「C/C# のデータ変換」と呼びます。

(6): バイトの配列を引数に取るのはちょいと使いづらいので、文字列を引数に取るバージョンを定義してあげます。

C# の string から byte[] にする際、文字列の最後にナルバイトを付加しています。

### ファイルに出力してみる

さっそく "Hello, World!" を出力するプログラムを書いてみましょう。

{% highlight text %}
{% raw %}
using System;
using System.Collections.Generic;
using System.Text;

namespace RubyTest
{
    class Program
    {
        static void Main(string[] args)
        {
            VALUE state = 0;

            Ruby.ruby_init();
            Ruby.rb_eval_string_protect("open('hello.txt', 'w') {|fp| fp.write(\"Hello, World!\\n\")}", ref state);
        }
    }
}
{% endraw %}
{% endhighlight %}


"Hello, World!" と書かれた hello.txt ファイルが生成されていれば成功です。

標準入力をコンソールに出すためには色々面倒な手順が必要なので、後ほど解説します。

## 標準出力

標準出力をコンソールに出すまでの手順を紹介します。

### C# による Ruby の定数の定義

Qnil などの定数を逐一 C# で定義してやる必要があります。全部定義するのは非常に面倒なので、よく使うものだけ定義しておきましょう。必要になったら付け足せばよいのです。

{% highlight text %}
{% raw %}
static class Ruby
{
    // 略

    public const VALUE Qfalse = (VALUE)0;
    public const VALUE Qtrue = (VALUE)2;
    public const VALUE Qnil = (VALUE)4;

    // 略
}
{% endraw %}
{% endhighlight %}


上から順に、 false、 true、 nil を表す値です。

Ruby の型を使って C# 上でごにょごにょやりたい場合は、 T_* 系の定数も定義する必要があります。ここでは割愛します。

VALUE も int も全く同じなので、キャストする必要は全然ないのですが、見やすくするために書いておきます。

### Ruby 文字列 → C# 文字列

Ruby 文字列を C# 文字列に変換するための処理を書きます。 Ruby の関数 rb_string_value_cstr を使用します。ところで、 Ruby 文字列を C 文字列に変換する際には、は StringValuePtr マクロを使うのが普通なのですが、マクロは展開されてしまっているために C# で使用することはできません。

{% highlight text %}
{% raw %}
static class Ruby
{
    // 略

    [DllImport(RubyDll)]
    private static extern IntPtr rb_string_value_cstr(ref VALUE v_ptr); // (1)

    public static string StringValuePtr(VALUE v) // (2)
    {
        int length = 0;
        IntPtr ptr = rb_string_value_cstr(ref v); // (3)
        unsafe
        {
            byte* p = (byte*)ptr; // (4)
            while (*p != 0) // (5)
            {
                length++;
                p++;
            }
        }
        byte[] bytes = new byte[length];
        Marshal.Copy(ptr, bytes, 0, length); // (6)
        return Encoding.UTF8.GetString(bytes);
    }

    // 略
}
{% endraw %}
{% endhighlight %}


(1): rb_string_value_cstr 関数をポーティングします。この関数は、 Ruby の String オブジェクトの値 (VALUE) から C の文字列を取得します。引数は VALUE * 型であり、 C# では VALUE の参照型 (ref) とできます。返り値は char* 型であり、これは IntPtr 構造体型とします。 IntPtr は、プラットフォーム非依存な、ポインタのラッパーです。

(2): StringValuePtr メソッドを定義します。引数に Ruby の文字列の VALUE をとります。

(3): 内部で rb_string_value_cstr メソッドを使用し、文字列の char * なポインタを取得します。

(4): IntPtr を適当なポインタ型にキャストします。 1 バイト単位で操作するので、ここでは byte * にキャストします。

unsafe ブロックが必要なため、 unsafe が有効になるようにコンパイルしてください。プロジェクトのプロパティの「アンセーフ コードの許可」という項目で設定できるはずです。

(5): NULL バイトが出るまでループを回し、文字列の長さを取得します。 C# は条件式に bool 値しか書けないので、ちゃんと (不) 等式を書く必要があります。

(6): 最終的に、 IntPtr 型の値 (ptr) から指定した長さ分だけ、 byte の配列に変換します。

StringValuePtr メソッドを使う、必要最小限と思われるサンプルを次に書いてみました。コンソールに "hoge" と出力されれば成功です。

{% highlight text %}
{% raw %}
using System;
using System.Collections.Generic;
using System.Text;
using VALUE = System.Int32;

namespace RubyTest
{
    class Program
    {
        static void Main(string[] args)
        {
            VALUE state = 0;

            Ruby.ruby_init();
            VALUE rbStr = Ruby.rb_eval_string_protect("'hoge'", ref state); // Ruby の文字列作成
            string csStr = Ruby.StringValuePtr(rbStr); // C# の文字列に変換
            Console.WriteLine(csStr);
            Console.ReadKey();
        }
    }
}
{% endraw %}
{% endhighlight %}


### C# による Ruby のメソッド定義

Ruby のメソッドを定義するためのインターフェイスとして、以下のような関数が用意されています。

* void rb_define_method(VALUE klass, const char *name, VALUE (*func)(), int argc);
* void rb_define_singleton_method(VALUE object, const char *name, VALUE (*func)(), int argc);


rb_define_method は普通のインスタンスメソッドを定義します。 rb_define_singleton_method は特異メソッドを定義します。

argc は引数の数を表します。

まず、三番目の引数のためのデリゲートを作ります。 C の関数ポインタは引数の型があいまいですが、 C# のデリゲードの型は厳格なので、引数の個数が異なるものは別のデリゲートとして定義してやる必要があります。

{% highlight text %}
{% raw %}
static class Ruby
{
    // 略

    public delegate VALUE CallbackArg0(VALUE self);
    public delegate VALUE CallbackArg1(VALUE self, VALUE arg1);
    public delegate VALUE CallbackArg2(VALUE self, VALUE arg1, VALUE arg2);

    // 略
}
{% endraw %}
{% endhighlight %}


引数の数はいくらでも定義できますが[^4]、とりあえずこの程度にしておきます。

引数を見れば分かりますが、最初の値は self (メソッドのレシーバ) で、それ以降の引数が、実際のメソッドの引数となります。

次に、 rb_define_method および rb_define_singleton_method をポーティングします。 argc はデリゲートの型から判別できるため冗長なので、 C# から使う場合は省略できるようにしてしまいます。

{% highlight text %}
{% raw %}
static class Ruby
{
    // 略

    private static List<Delegate> MethodDelegates = new List<Delegate>();

    [DllImport(RubyDll)]
    private static extern void rb_define_method(VALUE klass, string name, CallbackArg0 func, int argc);
    public static void rb_define_method(VALUE klass, string name, CallbackArg0 func)
    {
        MethodDelegates.Add(func);
        rb_define_method(klass, name, func, 0);
    }

    [DllImport(RubyDll)]
    private static extern void rb_define_method(VALUE klass, string name, CallbackArg1 func, int argc);
    public static void rb_define_method(VALUE klass, string name, CallbackArg1 func)
    {
        MethodDelegates.Add(func);
        rb_define_method(klass, name, func, 1);
    }

    [DllImport(RubyDll)]
    private static extern void rb_define_method(VALUE klass, string name, CallbackArg2 func, int argc);
    public static void rb_define_method(VALUE klass, string name, CallbackArg2 func)
    {
        MethodDelegates.Add(func);
        rb_define_method(klass, name, func, 2);
    }

    [DllImport(RubyDll)]
    private static extern void rb_define_singleton_method(VALUE obj, string name, CallbackArg0 func, int argc);
    public static void rb_define_singleton_method(VALUE obj, string name, CallbackArg0 func)
    {
        MethodDelegates.Add(func);
        rb_define_singleton_method(obj, name, func, 0);
    }

    [DllImport(RubyDll)]
    private static extern void rb_define_singleton_method(VALUE obj, string name, CallbackArg1 func, int argc);
    public static void rb_define_singleton_method(VALUE obj, string name, CallbackArg1 func)
    {
        MethodDelegates.Add(func);
        rb_define_singleton_method(obj, name, func, 1);
    }

    [DllImport(RubyDll)]
    private static extern void rb_define_singleton_method(VALUE obj, string name, CallbackArg2 func, int argc);
    public static void rb_define_singleton_method(VALUE obj, string name, CallbackArg2 func)
    {
        MethodDelegates.Add(func);
        rb_define_singleton_method(obj, name, func, 2);
    }

    // 略
}
{% endraw %}
{% endhighlight %}


上記ソースを見ていただければお分かりの通り、 C の関数を呼ぶ前にデリゲートを static なリスト (MethodDelegates) に保存しています。これはデリゲートが GC によって回収されてしまうのを防ぐためです。 C# (マネージド) のデリゲートは C (アンマネージド) では関数ポインタとなりますが、 C の関数ポインタをコールするときに、対応する C# のデリゲートが存在するかどうかは、 .NET のほうでちゃんと管理する必要があるのです。[^5]。回収されてしまったデリゲートをコールしようとするとエラーになってしまいます。それを防ぐために、デリゲートへの static な参照を保持することにしました。

実際に使う例は、以下の通り。動作させるためには、プロジェクトの参照設定に "System.Windows.Forms" を追加する必要があります。  String クラスにメソッド "show_message" を定義してみました。 Ruby の文字列をダイアログボックスに表示してくれます。なんと日本語も OK です。

{% highlight text %}
{% raw %}
using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using VALUE = System.Int32;

namespace RubyTest
{
    class Program
    {
        static void Main(string[] args)
        {
            VALUE state = 0;

            Ruby.ruby_init();
            VALUE rb_cString = Ruby.rb_eval_string_protect("String", ref state);
            Ruby.rb_define_method(rb_cString, "show_message", delegate(VALUE self)
            {
                MessageBox.Show(Ruby.StringValuePtr(self));
                return Ruby.Qnil;
            });
            Ruby.rb_eval_string_protect("'hoge'.show_message", ref state);
            Ruby.rb_eval_string_protect("'にほんご'.show_message", ref state);
        }
    }
}
{% endraw %}
{% endhighlight %}


### いよいよ標準出力

いままで、 Ruby スクリプトで puts などの標準出力メソッドを使用しても、コンソールには何も出ませんでした。原因はよくわかりません。リファレンスによると[^6]、Ruby では標準出力を変えるには「この変数 ($&gt;) の値を別の IO に再設定すればよい」ということが分かります。 $&gt; に代入されている値のデフォルト値は定数 STDOUT ですので、今回は STDOUT に write という特異メソッドを上書き定義してやることで、標準出力の挙動を変えることにします。

Ruby 風擬似コードを書くと、以下のようになります。

{% highlight text %}
{% raw %}
def STDOUT.write(str)
  (C# で Console.Write(str))
end
{% endraw %}
{% endhighlight %}


C# で書いてやると、次の通りになります。

{% highlight text %}
{% raw %}
VALUE rb_stdout = Ruby.rb_eval_string_protect("STDOUT", ref state);
Ruby.rb_define_singleton_method(rb_stdout, "write",
    delegate(VALUE self, VALUE rbStr)
    {
        Console.Write(Ruby.StringValuePtr(rbStr));
        return Ruby.Qnil;
    });
{% endraw %}
{% endhighlight %}


使用例は以下の通りです。

{% highlight text %}
{% raw %}
using System;
using System.Collections.Generic;
using System.Text;
using VALUE = System.Int32;

namespace RubyTest
{
    class Program
    {
        static void Main(string[] args)
        {
            VALUE state = 0;

            Ruby.ruby_init();

            VALUE rb_stdout = Ruby.rb_eval_string_protect("STDOUT", ref state);
            Ruby.rb_define_singleton_method(rb_stdout, "write",
                delegate(VALUE self, VALUE rbStr)
                {
                    Console.Write(Ruby.StringValuePtr(rbStr));
                    return Ruby.Qnil;
                });

            Ruby.rb_eval_string_protect("puts 'Hello, World!'", ref state);
            Console.ReadKey();
        }
    }
}
{% endraw %}
{% endhighlight %}


これでやっとこさ標準出力がコンソールに出ました。おめでとうございます。

## もっと C# と Ruby を連携させる

### 数値変換

Fixnum の場合、シフト演算を使って DLL の関数を呼び出さずに済ませる方法があります。そのようにすると、 C/C# のデータ変換のコストがかからないので、処理が高速化されます。ここでは説明しません。

#### Ruby 整数値 → C# 整数値

rb_num2int 関数を使います。

{% highlight text %}
{% raw %}
static class Ruby
{
    // 略

    [DllImport(RubyDll)]
    private static extern int rb_num2int(VALUE val);

    public static int NUM2INT(VALUE val)
    {
        return rb_num2int(val);
    }

    // 略
}
{% endraw %}
{% endhighlight %}


マクロの NUM2INT という名前で使いたい! という理由だけでラッパーを作ってみたり。以下同様。

#### C# 整数値 → Ruby 整数値

rb_int2inum 関数を使います。

{% highlight text %}
{% raw %}
static class Ruby
{
    // 略

    [DllImport(RubyDll)]
    private static extern VALUE rb_int2inum(Int32 i);

    public static VALUE INT2NUM(Int32 i)
    {
        return rb_int2inum(i);
    }

    // 略
}
{% endraw %}
{% endhighlight %}


### 文字列変換

#### Ruby 文字列 → C# 文字列

前述の通り、 StringValuePtr を使います。

#### C# 文字列 → Ruby 文字列

rb_str_new2 関数をポーティングします。

{% highlight text %}
{% raw %}
static class Ruby
{
    // 略

    [DllImport(RubyDll)]
    public static extern VALUE rb_str_new2(byte[] ptr);

    public static VALUE rb_str_new2(string ptr)
    {
        return rb_str_new2(Encoding.UTF8.GetBytes(ptr + '\0'));
    }

    // 略
}
{% endraw %}
{% endhighlight %}


本来 C では

{% highlight text %}
{% raw %}
VALUE rb_str_new2(char *ptr);
{% endraw %}
{% endhighlight %}


と定義されており、 C の char * 型を C# byte[] 型としました。この関数のほかに、 string を引数にとるメソッドを別途作りました。最初の rb_eval_string_protect と同じ要領です。

### C# から Ruby のメソッド呼び出し

Ruby のオブジェクトのメソッドを呼び出すためには、 rb_funcall 関数を使います。 rb_funcall 関数の定義は以下の通り。

{% highlight text %}
{% raw %}
VALUE rb_funcall(VALUE recv, ID mid, int argc);
{% endraw %}
{% endhighlight %}


ID は変数名やメソッド名を一意に定める値で、 Symbol のことです。文字列から Symbol を取得するには、 rb_intern 関数を使います。

{% highlight text %}
{% raw %}
ID rb_intern(const cahr *name);
{% endraw %}
{% endhighlight %}


ID は単なる整数値なので、 C# では int として扱えます。

両方を C# で定義してやると、以下のようになります。

{% highlight text %}
{% raw %}
using ID = System.Int32;

// 略

static class Ruby
{
    // 略

    [DllImport(RubyDll, EntryPoint = "rb_funcall")]
    private static extern VALUE rb_funcall_(VALUE recv, ID mid, int argc);
    public static VALUE rb_funcall(VALUE recv, ID mid)
    {
        return rb_funcall_(recv, mid, 0);
    }
    [DllImport(RubyDll, EntryPoint="rb_funcall")]
    private static extern VALUE rb_funcall_(VALUE recv, ID mid, int argc, VALUE arg1);
    public static VALUE rb_funcall(VALUE recv, ID mid, VALUE arg1)
    {
        return rb_funcall_(recv, mid, 1, arg1);
    }
    [DllImport(RubyDll, EntryPoint = "rb_funcall")]
    private static extern VALUE rb_funcall_(VALUE recv, ID mid, int argc, VALUE arg1, VALUE arg2);
    public static VALUE rb_funcall(VALUE recv, ID mid, VALUE arg1, VALUE arg2)
    {
        return rb_funcall_(recv, mid, 2, arg1, arg2);
    }

    [DllImport(RubyDll)]
    public static extern ID rb_intern(byte[] name);
    public static ID rb_intern(string name)
    {
        return rb_intern(Encoding.UTF8.GetBytes(name + '\0'));
    }

    // 略
}
{% endraw %}
{% endhighlight %}


### C# による Ruby のクラス定義

rb_define_class 関数を使います。

{% highlight text %}
{% raw %}
static class Ruby
{
    // 略

    [DllImport(RubyDll)]
    public static extern VALUE rb_define_class(string name, VALUE super);

    // 略
}
{% endraw %}
{% endhighlight %}


rb_define_class 関数は親クラスの指定が必須ですが、 rb_cObject (Object クラスを表す VALUE) が無くて困ることになります。 rb_cObject はグローバル変数ですが、 C/C# のデータ変換ができないのです。 rb_eval_string_protect を使って強引に切り抜けましょう。

{% highlight text %}
{% raw %}
VALUE rb_cObject = Ruby.rb_eval_string_protect("Object", ref state);
{% endraw %}
{% endhighlight %}


## 問題点

### 実行環境が限定される

実行環境はそのアプリケーション内でのみ限定されます。拡張ライブラリのような使い方はできません。

[RPG ツクール XP](http://www.enterbrain.co.jp/digifami/products/rpgxp/)のように完全に閉じた世界の Ruby のような、特殊な用途ならば大丈夫でしょう。

### C/C# のデータ変換はコストがかかる

C/C# のデータ変換は、通常の関数呼び出しに比べて大きなコストがかかります。高速化のためには、以下の工夫が必要でしょう。

* 呼び出し回数を減らす
* シンボルをキャッシュする (同じ文字列に対する ID 値は不変なため)
* Fixnum の計算をシフト演算で何とかする


### GC が独立して動いてしまう

Ruby の GC と C# の GC は独立して動きます。 Ruby のオブジェクトと C# のオブジェクトとを関連付ける場合、片方が GC で回収されてしまうなどの不整合を起こさないようにしましょう。

C# 側では連想配列などを使って常に参照を保持するようにし、 Ruby のオブジェクトを回収のタイミングをフックして、 C# のオブジェクトを回収させるようにすればよいでしょう。 ObjectSpace モジュールの define_finalizer メソッドを使いましょう。

## おわりに

本稿では、 C# と Ruby を連携させる方法について述べました。本稿で紹介する方法を使うことによって、 C# における .NET ライブラリの豊富さと、 Ruby のスクリプトの書きやすさの両方のメリットを受けることができます。また、ポーティング作業を通じて、 Ruby の C API やマーシャリング (C/C# データ変換) を学ぶことができます。

しかしながら、 Ruby で .NET のライブラリを使いたいという目的ならば、今後は IronRuby を使ったほうがよいでしょう。

## 宣伝

[Star Engine](http://star-engine.sourceforge.jp/) というゲームライブラリを開発しております。スーパーファミコン風なノスタルジックなゲームを簡単に作るためのライブラリです。 C# と Ruby の組合せを使っています。

画像操作などの速度が要求される部分は C# で書かれており、ゲームを作る「楽しい」部分は Ruby で書けるようになっています。

C# で書くことによって、 .NET の恩恵をそのまま受けることが出来ました。特に画像処理やフォント周りとかが楽チンでした[^7]。

## 謝辞

本稿を書くにあたって、 NyaRuRu さん、 arton さん、ささださん (順不同) にアドバイスをいただきました。この場を借りて厚く御礼申し上げます。

## 書いた人

星一。大学院生。色々と面倒くさがり屋。好きなアーティストは Michael Jackson です。

* [http://d.hatena.ne.jp/hajimehoshi/](http://d.hatena.ne.jp/hajimehoshi/)
* [http://twitter.com/hajimehoshi](http://twitter.com/hajimehoshi)


----

[^1]: 差異は、http://www.garbagecollect.jp/ruby/mswin32/ja/documents/mswin32.htmlを参照。
[^2]: ライセンスが GPL ですので、公開する際は注意してください。
[^3]: 参考: http://msdn2.microsoft.com/ja-jp/library/04fy9ya1(VS.80).aspx
[^4]: README.EXT.ja によると、 16 個が限界らしい。
[^5]: 厳密には、 C# のデリゲートと C の関数ポインタを仲介する Reverse P/Invoke thunk というサンクというものが存在し、デリゲートインスタンスごとに実行時生成されます。 C から関数ポインタをコールするとき、実際にはこのサンクが呼ばれます。サンクはデリゲートインスタンスと一対一に対応し、デリゲートインスタンスが回収されたときにサンクも破棄されることになっています。
[^6]: 組み込み変数: http://www.ruby-lang.org/ja/man/?cmd=view;name=%C1%C8%A4%DF%B9%FE%A4%DF%CA%D1%BF%F4
[^7]: SDL を使っていますが、 SDL_ttf などはあまり使いたくなかったんです。
