---
layout: post
title: Ruby ではじめるプログラミング 【第 2 回】
short_title: Ruby ではじめるプログラミング 【第 2 回】
tags: 0003 FirstProgramming
---
{% include base.html %}


著者：だん

## はじめに

前回 ([Ruby ではじめるプログラミング 【第 1 回】]({% post_url articles/0002/2004-10-16-0002-FirstProgramming %})) は次のこのようなプログラムの基本的な部分を紹介しました。
: ![mage2_s.png]({{base}}{{site.baseurl}}/images/0003-FirstProgramming/mage2_s.png)

* Ruby を実行するまでの手順
* 変数やメソッド（命令）呼び出し
* プログラムには流れがあるということ
* 制御命令を使って流れをコントロールできるということ


今回は知っているととても便利な機能を紹介します。

## 式展開

「あなたの名前は○○○です。」の○○○の部分に変数を当てはめて表示するプログラムを作ってみましょう。

{% highlight text %}
{% raw %}
puts '名前を入力してください。'
name = gets
print 'あなたの名前は'
print name
puts 'です。'
{% endraw %}
{% endhighlight %}


puts メソッドを使うと途中で改行されてしまうので、改行を行わない print メソッドを使用しています。しかし、このプログラムを実行すると期待通りの結果になりません。

「名前を入力してください。」と表示されたらキーボードから dan と入力してみます。
すると、実行結果はこうなります。

{% highlight text %}
{% raw %}
あなたの名前はdan
です。
{% endraw %}
{% endhighlight %}


dan のところで改行されてしまいました。これは gets メソッドで入力した文字列データの最後には改行コードが付いているからです。文字列の末尾の改行コードは __chomp メソッド__で取り除くことができます。

{% highlight text %}
{% raw %}
puts '名前を入力してください。'
name = gets.chomp
print 'あなたの名前は'
print name
puts 'です。'
{% endraw %}
{% endhighlight %}


実行結果はこうなります。

{% highlight text %}
{% raw %}
あなたの名前はdanです。
{% endraw %}
{% endhighlight %}


gets の後ろにある __chomp__ は gets の戻り値である文字列を操作するメソッドです。入力された文字列の末尾の改行コードを取り除いてから変数 name に代入しているわけです。

### 式展開で文字列に変数を埋め込む

このプログラムは__式展開__という機能を使うとこのように書くことができます。

{% highlight text %}
{% raw %}
puts '名前を入力してください。'
name = gets.chomp
puts "あなたの名前は#{ name }です。"
{% endraw %}
{% endhighlight %}


__ #{} __の中に変数を書いておくと、その変数の中身が文字列として埋め込まれます。
それから、式展開の機能を使うためには文字列を__ ' （シングルコーテーション）__ではなく__ "（ダブルコーテーション）__で囲む必要があります。

また、実は__ #{} __の中には変数以外にもいろいろなものを書くことができます。例えば四則演算やメソッド呼び出しが書けます。

{% highlight text %}
{% raw %}
puts "1+1= #{1+1} です。"
puts "10*10+5= #{10*10+5} です。"
{% endraw %}
{% endhighlight %}


このプログラムは実行すると次のようになります。

{% highlight text %}
{% raw %}
1+1= 2 です。
10*10+5= 105 です。
{% endraw %}
{% endhighlight %}


もちろん変数を使うこともできます。また、式展開では数値も自動的に文字列へ変換されます。

{% highlight text %}
{% raw %}
a = 5
b = 2
puts "#{a}+#{b}= #{a+b} です。"
puts "#{a}-#{b}= #{a-b} です。"
{% endraw %}
{% endhighlight %}


このプログラムは実行すると次のようになります。

{% highlight text %}
{% raw %}
5+2= 7 です。
5-2= 3 です。
{% endraw %}
{% endhighlight %}


自分で実際に動かしながらいろいろ遊んでみてください。

### やってみよう（その 1 ）

式展開を使って作った文字列を変数に代入し、その変数を別の文字列の中で式展開してみましょう。

## p メソッド

__p メソッド__を使うと様々な__オブジェクト__の中身を人間に__わかりやすい形で表示__することができます。

__オブジェクト__とは、これまでに紹介した__数値__や__文字列データ__のことです。

{% highlight text %}
{% raw %}
p 100
p 'abc'
{% endraw %}
{% endhighlight %}


この__ 100 __や__ 'abc' __が__オブジェクト__です。このプログラムを実行すると次のような結果が表示されます。

{% highlight text %}
{% raw %}
100
"abc"
{% endraw %}
{% endhighlight %}


文字列データ（文字列オブジェクト）は " で囲まれて表示されます。
次のようにオブジェクトを変数に代入しても同様に中身を表示することができます。

{% highlight text %}
{% raw %}
a = 100
b = 'abc'
p a
p b
{% endraw %}
{% endhighlight %}


gets メソッドの戻り値を p メソッドで表示してみましょう

{% highlight text %}
{% raw %}
name = gets
p name
{% endraw %}
{% endhighlight %}


実行結果はこうなります。

{% highlight text %}
{% raw %}
dan           # ここで dan と入力する
"dan\n"
{% endraw %}
{% endhighlight %}


入力した文字列が表示されていますが、文字列の最後に__ \n __という文字が付いています。この \n が改行コードです。
改行コードを出力すると、コマンドプロンプト上では改行して表示されます。

chomp メソッドを使って末尾の改行コードを取り除くとこうなります。

{% highlight text %}
{% raw %}
name = gets.chomp
p name
{% endraw %}
{% endhighlight %}


実行結果です。

{% highlight text %}
{% raw %}
dan           # ここで dan と入力する
"dan"
{% endraw %}
{% endhighlight %}


\n がなくなっているのがわかりますね。

p メソッドを使うといろいろなオブジェクトの中身を表示することができます。

## times によるループ

__times メソッド__は前回も紹介しました。 times には便利な機能があるので紹介します。

times を使用したサンプルプログラムです。

{% highlight text %}
{% raw %}
5.times do |n|
  puts n
end
{% endraw %}
{% endhighlight %}


実行結果はこうなります。

{% highlight text %}
{% raw %}
0
1
2
3
4
{% endraw %}
{% endhighlight %}


5.times do の後ろに__ |n| __という見慣れないコードがあります。

この n は変数です。変数 n には 0,1,2,3,4 が順番に n に代入されながらループ処理が実行されていきます。この機能はこの後の配列の解説でも使用するので覚えておいてください。

## エラー

便利な機能の紹介からは話がずれますが、ここではエラーについて簡単に説明します。

いざプログラムを実行してみると、思わぬ__エラー__が発生してプログラムが動かないことがあります。
エラーは単純な入力ミスや誤った文法でプログラムを書けばすぐに発生します。
エラーが発生すると、その原因を調べるための手がかりが__エラーメッセージ__として表示されます。

では、わざとエラーを起こしてエラーメッセージを実際に確認してみましょう。

### エラーになるプログラム

これは変数 a を表示する正常なプログラムです。

{% highlight text %}
{% raw %}
a = 0
puts a
{% endraw %}
{% endhighlight %}


エラーが起こるように 1 行目をわざとコメントにします。

{% highlight text %}
{% raw %}
# a = 0
puts a
{% endraw %}
{% endhighlight %}


このプログラムを実行すると次のようなエラーメッセージが表示されます。

{% highlight text %}
{% raw %}
test.rb:2: undefined local variable or method `a' for main:Object (NameError)
{% endraw %}
{% endhighlight %}


このエラーメッセージは a という名前の変数やメソッドは存在しないということを知らせています。

次のプログラムでは文字列データの「こんにちは」の最後に ' がありません。

{% highlight text %}
{% raw %}
puts 'こんにちは
{% endraw %}
{% endhighlight %}


これを実行すると、文字列が閉じられていないという旨のエラーメッセージが表示されます。

{% highlight text %}
{% raw %}
test.rb:1: unterminated string meets end of file
{% endraw %}
{% endhighlight %}


次のプログラムは if に対応する end をコメントにして消してあります。

{% highlight text %}
{% raw %}
a = 0
if a == 0
  puts 'a は 0 です。'
# end
{% endraw %}
{% endhighlight %}


これもエラーになります。

{% highlight text %}
{% raw %}
test.rb:5: syntax error
{% endraw %}
{% endhighlight %}


「syntax error」は文法が間違っているときに出るエラーメッセージです。

### 行番号に注目

それぞれのエラーメッセージの先頭を見ると __test.rb:数字:__ と表示されています。
test.rb はプログラムのソースファイル名です。その後ろの数字はエラーが発生している場所の__行番号__を示しています。

エラーには他にも種類がありますが、ほとんどの場合は該当する行番号の部分になんらかの間違いがあります。エラーが発生した場合はエラーメッセージを頼りにもう一度ソースファイルをよく確かめてみてください。

基本的にエラーメッセージは英語で表示されるのでつい敬遠したくなるかもしれません。しかし、エラーメッセージはトラブル解決の重要な手がかりになるので、英語が苦手でも注意深く見るようにしてください。

## 配列

多くのプログラミング言語には__配列（はいれつ）__という便利な機能があります。もちろん Ruby でも配列を使うことができます。

配列は少々難しい機能ですが、Ruby プログラミングを修得するうえでは避けて通れません。とても重要な機能なので、ここでは配列についてあせらずじっくりと解説します。

### 配列を作る

配列を使うと複数のオブジェクト（データ）をひとまとめにすることができます。配列を作るにはいくつかの方法がありますが、今回紹介するのはこの形です。

{% highlight text %}
{% raw %}
変数名 = [オブジェクト0, オブジェクト1, オブジェクト2, ……]
{% endraw %}
{% endhighlight %}


オブジェクト（データ）を __,__ で区切ってデータ全体を__ [ __と__ ] __で囲みます。そして作られた配列に変数を使って名前を付けます。

次のプログラムを見てください。ある 3 人の身長データを配列でまとめたものです。

{% highlight text %}
{% raw %}
values = [150, 174, 180]
{% endraw %}
{% endhighlight %}


このプログラムでは 150 と 174 と 180 という 3 つのデータをひとまとめにして、それに values という名前を付けています。values は好きなように決めることができる変数名です。

values の中身は 3 つの数字が順番に並んだ配列です。150 という数値にアクセスするには次のようにします。

{% highlight text %}
{% raw %}
values[0]
{% endraw %}
{% endhighlight %}


これで 150 という数値を取り出すことができます。

{% highlight text %}
{% raw %}
values = [150, 174, 180]
p values[0] # 150 を表示
p values[1] # 174 を表示
p values[2] # 180 を表示
{% endraw %}
{% endhighlight %}


実行結果はこうなります。

{% highlight text %}
{% raw %}
150
174
180
{% endraw %}
{% endhighlight %}


__ = __を使って内容を変更することもできます。

{% highlight text %}
{% raw %}
values = [150, 174, 180]
values[0] = 155
p values[0] # 中身は 150 から 155 に変わっている
p values[1]
p values[2]
{% endraw %}
{% endhighlight %}


実行結果はこうなります。

{% highlight text %}
{% raw %}
155
174
180
{% endraw %}
{% endhighlight %}


ここでひとつ注意があります。上記のコードを見るとわかるように配列内の最初のデータは values[1] ではなく values[0] で得られます。
2 番目のデータは values[1]、3 番目のデータは values[2] です。普段わたしたちはモノを数えるときは 1 から 1, 2, 3, ……と数えますが、コンピュータは 0 から 0, 1, 2, …… と数えるのです。この慣習は少々やっかいですが、慣れればたいしたことはありません。

### 添字（インデックス）

values の 後ろに書いた [0] や [1] の数字部分を__添字（そえじ）__といいます。添字は__インデックス__と呼ばれることもあります。添字には数値を代入した変数を用いることができます。

{% highlight text %}
{% raw %}
values = [150, 174, 180]
index = 1          # 変数 index に 1 を代入
p values[index] # 174 が表示される
{% endraw %}
{% endhighlight %}


これはとても便利です。前回紹介した「じゃんけんロボット」は、配列を使うと次のように書くことができます。

{% highlight text %}
{% raw %}
puts 'じゃんけん'
sleep 1
values = ['グー', 'チョキ', 'パー']
r = rand(3) # r に 0 ? 2 の乱数を代入
puts values[r]
{% endraw %}
{% endhighlight %}


なんと if 文も case 文もなくなってしまいました。プログラム全体が短くなりましたね。

配列の中には数値だけでなく、文字列やその他のオブジェクトを入れることもできます。

### 平均身長

次のプログラムは配列にセットされた身長データから、全員の平均身長を求めるプログラムです。

```ruby
values = [150, 174, 180]

n = values.size
puts "values には #{n} 人分のデータがあります。"

total = 0
n.times do |index|
  puts "身長が #{values[index]} cm の人がいます。"
  total += values[index]
end

puts "全員の身長の合計は #{total} cm です。"
puts "全員の身長の平均は #{total/n} cm です。"

```

3 行目の__ .size __は配列の要素数を返すメソッドです。ここでは変数 n に 3 が代入されます。

7 行目の index は変数です。index には 0, 1, 2 から順に数値が代入されながらループ処理が実行されていきます。

{% highlight text %}
{% raw %}
total += values[index]
{% endraw %}
{% endhighlight %}


この部分は変数 total に values[index] の値を加算する処理です。

この平均身長計算プログラムの実行結果はこうなります。

{% highlight text %}
{% raw %}
values には 3 人分のデータがあります。
身長が 150 cm の人がいます。
身長が 174 cm の人がいます。
身長が 180 cm の人がいます。
全員の身長の合計は 504 cm です。
全員の身長の平均は 168 cm です。
{% endraw %}
{% endhighlight %}


values の中身を変更・追加していろいろ試してみてください。

### 配列もオブジェクト

配列の中にはどんなオブジェクトも入れることもできます。

{% highlight text %}
{% raw %}
values = [0, 5, 'abc', 'あいう']
{% endraw %}
{% endhighlight %}


そして、配列もひとつのオブジェクトとしてあつかうことができます。p メソッドで中身を表示してみましょう。

{% highlight text %}
{% raw %}
values = [0, 5, 'abc', 'xyz']
p values
{% endraw %}
{% endhighlight %}


実行結果はこうなります。

{% highlight text %}
{% raw %}
[0, 5, "abc", "xyz"]
{% endraw %}
{% endhighlight %}


p メソッドを使うといつでも簡単に配列の中身を確認できるのでとても便利です。
__配列全体もひとつのオブジェクト__だったのです。

### 配列データの追加と削除

__push メソッド__で配列の最後にオブジェクト（データ）を追加することができます。

{% highlight text %}
{% raw %}
values = []    # 空の配列を作成
p values       # values の中身を表示
values.push 0  # values に 0 を追加
p values
values.push 1  # values に 1 を追加
p values
{% endraw %}
{% endhighlight %}


実行結果はこうなります。

{% highlight text %}
{% raw %}
[]
[0]
[0, 1]
{% endraw %}
{% endhighlight %}


__pop メソッド__で配列の最後のオブジェクト（データ）を取り出すことができます。取り出したオブジェクトは配列から削除されます。

{% highlight text %}
{% raw %}
values = ['a', 'b']
p values
puts values.pop  # values から 'b' を削除
p values
puts values.pop  # values から 'a' を削除
p values
{% endraw %}
{% endhighlight %}


実行結果はこうなります。

{% highlight text %}
{% raw %}
["a", "b"]
["a"]
[]
{% endraw %}
{% endhighlight %}


### 配列の中に配列（多次元配列）

配列にはどんなオブジェクトでも入れることができます。そして、配列もひとつのオブジェクトなので、配列に配列を入れることもできます。

試してみましょう。 tbl はただの変数名です。

{% highlight text %}
{% raw %}
tbl = [[0,1,2], [3,4,5], ['a','b','c']]
p tbl
{% endraw %}
{% endhighlight %}


このプログラムでは、配列 tbl の中に 3 つの配列オブジェクトが入っています。このように配列の中に配列があるオブジェクトを 2 次元配列といいます。

実行してみましょう。表示結果はこうなります。

{% highlight text %}
{% raw %}
[[0, 1, 2], [3, 4, 5], ["a", "b", "c"]]
{% endraw %}
{% endhighlight %}


p メソッドは、多次元配列の中身も表示してくれます。

tbl から要素を取り出すにはこうします。

{% highlight text %}
{% raw %}
tbl = [[0,1,2], [3,4,5], ['a','b','c']]
p tbl[0]
p tbl[1]
p tbl[2]
p tbl[0][0]
p tbl[0][1]
p tbl[0][2]
p tbl[2][0]
p tbl[2][1]
{% endraw %}
{% endhighlight %}


実行結果です。

{% highlight text %}
{% raw %}
[0, 1, 2]
[3, 4, 5]
["a", "b", "c"]
0
1
2
"a"
"b"
{% endraw %}
{% endhighlight %}


tbl[0] は [0, 1, 2] を指しています。 tbl[0][0] で 0 を取り出すことができます。 tbl[0][1] で 1 を tbl[2][0] で 3 を取り出すことができます。

プログラムと実行結果を照らし合わせて、どのような仕組みになっているのか自分で考えてみてください。

さて、同じ配列定義をこのように書くこともできます。

{% highlight text %}
{% raw %}
tbl = [
  [0,1,2],
  [3,4,5],
  ['a','b','c'],
]
p tbl
{% endraw %}
{% endhighlight %}


実行結果はまったく同じです。要素の数が多い場合はこのように改行を入れた方が見やすくなります。

2 次元配列と先ほど説明した times のループ機能を使ってこのようなプログラムを作ってみました。画面にある文字絵を表示するプログラムです。

```ruby
tbl = [
  [1,1,1,0,0],
  [1,0,0,1,0],
  [1,0,0,1,0],
  [1,1,1,0,0],
  [1,0,1,0,0],
  [1,0,0,1,0],
]

y_max = tbl.size
y_max.times do |y|
  x_max = tbl[y].size
  x_max.times do |x|
    if tbl[y][x] == 1
      print "■"
    else
      print "□"
    end
  end
  print "\n" # 改行する
end

```

2 重ループと 2 次元配列を使ったすこしややこしいプログラムですが、もう特に説明する必要はないでしょう。
パズルゲームを解く気持ちでひとつひとつの処理を自分で追ってみてください。

### やってみよう（その 2 ）

このプログラムを 3 次元配列（ 3 重ループ）に改造して複数の絵を表示するプログラムを作成してください。

## 配列を使ったゲームブック

前回作成したゲームブックプログラムを配列を使って作ってみます。
プログラムを見ただけでは動作をイメージできないので、実際に実行してから次のソースを見てください。

```ruby
msg0 = "３本の分かれ道があります。どの道を進みますか。\n" +
       "  1 左の道\n  2 真ん中の道\n  3 右の道"
msg1 = "あっ！\n落とし穴に落ちてしまいました。\n〜 GAME " +
       "OVER 〜"
msg2 = "真ん中の道をまっすぐ歩いていくと……\n宝箱をみつ" +
       "けました！\n  1 そのままにしておく\n  2 あける"
msg3 = "しばらく歩き続けると　もとの場所にもどってしまい" +
       "ました。\n  1 次へ"
msg4 = "宝箱には見向きもせず　お家に帰りました。\n〜 GAM" +
       "E OVER 〜"
msg5 = "パカッ\nまばゆい光があふれだす……\n１００枚の金" +
       "貨を手に入れました！"

tbl = [
  [msg0,   1,   2,   3],
  [msg1, nil, nil, nil],
  [msg2,   4,   5, nil],
  [msg3,   0, nil, nil],
  [msg4, nil, nil, nil],
  [msg5, nil, nil, nil],
]

scene = 0
while true
  scene_data = tbl[scene]
  message = scene_data[0]
  puts message

  if scene_data[1] == nil
    exit
  end

  print '  数字を入力してください '
  input_value = gets.to_i

  if input_value > 0
    next_scene = scene_data[input_value]
    if next_scene == nil
      puts '不正な値が入力されました'
    else
      scene = next_scene
    end
  else
    puts '不正な値が入力されました'
  end

  sleep 0.5
  print "\n"
end

```

先頭の msg0 ? msg5 はゲームの各場面で表示するメッセージです。スペースの都合で 2 行に渡って文字列を代入しています。

{% highlight text %}
{% raw %}
m0 = "abcxyz"
m1 = "abc" + "xyz"
m2 = "abc" +
     "xyz"
{% endraw %}
{% endhighlight %}


m0, m1, m2 はまったく同じ内容になります。

### tbl のデータ構造

14 行目の tbl は シーンデータの配列です。

{% highlight text %}
{% raw %}
tbl = [
  シーンデータ,
  シーンデータ,
  シーンデータ,
]
{% endraw %}
{% endhighlight %}


シーンデータはそのシーンで表示する「メッセージ」と「ジャンプ先 ID」の配列です。

{% highlight text %}
{% raw %}
["メッセージ", ジャンプ先 ID1, ジャンプ先 ID2, ジャンプ先 ID3 ]
{% endraw %}
{% endhighlight %}


「ジャンプ先 ID 」にはそのシーンで選択された選択肢に対応したジャンプ先の ID （インデックス）を入れておきます。

* __選択肢 1 __が選択されたときは「ジャンプ先 ID1 」へジャンプする
* __選択肢 2 __が選択されたときは「ジャンプ先 ID2 」へジャンプする
* __選択肢 3 __が選択されたときは「ジャンプ先 ID3 」へジャンプする


__nil__ は特別なオブジェクトです。今回は nil について説明しませんが、選択肢がない場合は nil を入れておくことにします。また、__選択肢 1 __が nil だった場合はそのシーンでゲームを終了することにします。

まとめると tbl は以下のような構造の 2 次元配列です。

{% highlight text %}
{% raw %}
tbl = [
  ["メッセージ", ジャンプ先 ID1, ジャンプ先 ID2, ジャンプ先 ID3 ],
  ["メッセージ", ジャンプ先 ID1, ジャンプ先 ID2, ジャンプ先 ID3 ],
  ["メッセージ", ジャンプ先 ID1, ジャンプ先 ID2, ジャンプ先 ID3 ],
]
{% endraw %}
{% endhighlight %}


### シーンデータを取り出す

{% highlight text %}
{% raw %}
scene_data = tbl[scene]
{% endraw %}
{% endhighlight %}


でその場面のシーンデータ（メッセージとジャンプ先 ID）の配列を変数 scene_data に代入しています。変数 scene には場面番号が入っています。場面番号が tbl のインデックスとなり、tbl[scene] でその場面のシーンを取り出すことができます。

### プログラムの終了条件

{% highlight text %}
{% raw %}
if scene_data[1] == nil
  exit
end
{% endraw %}
{% endhighlight %}


という部分は「ジャンプ先 ID」が __nil__ だったらプログラムを終了するという意味です。

### シーンの変更

input_value には選択された数字が代入されます。gets.to_i で入力された文字を数値に変換していますが、to_i メソッドは数字以外の文字が与えられた場合は 0 を返します。

input_value が 0 より大きい値だった場合は正常処理を行い、それ以外（0 以下）の場合は不正な値が入力されたとみなし、シーン変更の処理は行いません。 36 行目がこの場合わけの判定になります。

input_value が 0 より大きい値だった場合は

{% highlight text %}
{% raw %}
next_scene = scene_data[input_value]
{% endraw %}
{% endhighlight %}


で次のシーンの番号を取り出します。ここで問題があります。input_value の値が 4 以上だった場合はシーンデータ配列の範囲外のデータを取り出そうとしてしまいます。Ruby では配列の範囲外のデータを取り出そうとした場合は __nil__ が返ります。38 行目の

{% highlight text %}
{% raw %}
if next_scene == nil
{% endraw %}
{% endhighlight %}


で場合わけをすれば next_scene に正しい値が代入できたかどうかが判定できます。
正しい値だった場合は 41 行目の

{% highlight text %}
{% raw %}
scene = next_scene
{% endraw %}
{% endhighlight %}


で scene を書き換えます。scene が書き換わると場面も移行します。

### 配列の利点

前回は場面をすべて if 文や case 文で場合わけすることで処理していました。
つまり場面が増えるとその分 if 文や case 文の場合わけを追加して制御構造を追加する必要がありました。

しかし、今回のプログラムではシーンデータを配列データにしたことにより、場面を増やす場合は配列内のデータを増やすだけです。シーンをいくつ増やしても制御構造を増やす必要はありません。これはとても大きなメリットです。テーブルデータを変更するだけで新しいシナリオを追加したり、シーンジャンプの仕組みを変更したりできます。

### やってみよう（その 3）

テーブルデータを変更して新しいシナリオのゲームを作成しながら遊んでみてください。
面白いスクリプトができたら、ぜひ [るびま編集部](mailto:magazine@ruby-no-kai.org) まで送ってください。

## まとめ

今回はいくつかの便利な機能と配列について紹介しました。
そして、特に配列に重点を置いて解説しました。

配列を使ってゲームで使用するメッセージやシーンのジャンプデータをテーブル化する方法はとても便利です。
プロジェクトが大きくなればなるほど、このような工夫が開発効率を高めることにつながります。そして、開発効率がよくなれば同じ労力でより優れたアプリケーションが作ることができます。

次回は今回紹介したデータテーブルをより使いやすくする方法を紹介します。

## 著者について

だん (dan at dgames dot jp)

ゲームメーカーに勤めるゲームクリエイター。

最近までずっとコンシューマーゲームソフトの開発という閉じた世界にいた。
Ruby 歴は 2 年と短く、まだまだ勉強中の初心者。

## Ruby ではじめるプログラミング 連載一覧

{% for post in site.tags.FirstProgramming %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}

----


