---
layout: post
title: なるほど Erlang プロセス
short_title: なるほど Erlang プロセス
tags: 0056 naruhodo_erlang_process
---
{% include base.html %}


## なるほど Erlang プロセス

[なるほど Unix プロセス ― Ruby で学ぶ Unix の基礎](http://tatsu-zine.com/books/naruhounix)という本があります。

この本は私にとって謎が多く触れにくかった Unix プロセスというものを、 Ruby からのプロセス操作を通じて馴染みのあるものにしてくれました。

今回はみなさんにとっても謎の多い ( かもしれない ) Erlang プロセスと、それを利用したプログラミングというものを、 Ruby に少し似た Elixir からの操作を通じてより良く理解してみましょう。

オンライン上でコンパイル・実行ができるサービス [wandbox](https://wandbox.org/) 上では Elixir が動作するため、Elixir を手元の PC にインストールしなくてもコードを編集、実行できます。今回のコードへのリンクを貼っておくのでもし興味があればコードを書き換えてオンラインで試してみてください。( 書き換えて実行しても他の人やリンクには影響が出ないので安心してください )

## Erlang とは

「[Rubyist のための他言語探訪 【第 10 回】 Erlang]({{base}}{% post_url articles/0017/2006-11-26-0017-Legwork %})」によい記事があるので省略します。

## Elixir とは

「[書籍紹介「プログラミング Elixir」]({{base}}{% post_url articles/0054/2016-08-21-0054-ElixirBook %})」によい記事があるので省略します。

## Erlang プロセスは ID を持っている

Erlang プロセスは、 ID を持っています。 PID と呼ばれています。 _self()_ という関数で自身の PID を返します。

以下のプログラムでは Ruby の _p_ に相当する Elixir の関数 _IO.inspect_ を使って _self()_ の値を表示しています。

{% highlight text %}
{% raw %}
   IO.inspect self()
   # => #PID<0.73.0>
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/KY0OmfkBWbS3uB6a)

## Erlang プロセスは別のプロセスを作れる

Erlang プロセスは、別の Erlang プロセスを作ることができます。 _spawn_ という関数を利用します。

Ruby で lambda を _-&gt; do ... end_ や _-&gt; x do ... end_ と書けるように、
Elixir では無名関数を _fn -&gt; ... end_ や _fn x -&gt; ... end_ と書けます。

_spawn_ は引数に無名関数を取り、作成した Erlang プロセスの上でその関数を実行します。

ですから、以下のプログラムではメインの Erlang プロセスの PID と、 spawn で生成した Erlang プロセスでの PID が異なっています。

{% highlight text %}
{% raw %}
   IO.puts "プロセス #{inspect self()}"
   spawn(fn ->
     IO.puts "別プロセス #{inspect self()}"
   end)
   # => プロセス #PID<0.73.0>
   # => 別プロセス #PID<0.76.0>
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/XdMnsoTvT4uQEhh5)

## Erlang プロセスは別の Erlang プロセスとやりとりできる

Erlang プロセスは、別の Erlang プロセスとの間でやりとりができます。プロセスとプロセスの間でやりとりする値のことはメッセージと呼ばれています。

あるプロセスから別のプロセスへメッセージを送るには _send_ という関数を利用します。_send_ の引数は送り先の PID と送りたいメッセージです。

プロセスへと送られてきたメッセージを取り出して読むには _receive_ という関数を利用します。_receive_ の _do ... end_ の中でメッセージを受けとることができます。

以下のプログラムでは Ruby の _Object#inspect_ に相当する Elixir の関数 _inspect_ と Ruby の _puts_ に相当する Elixir の関数 _IO.puts_ を使って、送られてきたメッセージの値を表示しています。

{% highlight text %}
{% raw %}
   IO.puts "プロセス #{inspect self()}"

   other_pid = spawn(fn ->
     IO.puts "別プロセス #{inspect self()}"
     receive do
       message ->
         IO.puts "#{inspect self()} が #{inspect message} を受け取りました。"
     end
   end)

   send(other_pid, "こんにちは")
   Process.sleep(100)
   # => プロセス #PID<0.73.0>
   # => 別プロセス #PID<0.76.0>
   # => #PID<0.76.0> が "こんにちは" を受け取りました。
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/8OxwzVa7cP24PGtN)

## Erlang プロセスはメッセージボックスを持つ

_send_ でメッセージが送られてきたとき、受け手のプロセスでは明示的な処理は不要です。もちろんメッセージを __取り出して読む__ には先ほどの例のように _receive_ を使わなければいけませんが、メッセージを __受けとる__ には何も必要ありません。全てのプロセスは、プロセスと一対一で結びついたキューを持っており、プロセスへ送られたメッセージはそのキューへと蓄積されます。この、プロセスに結びついたメッセージを格納するためのキューのことはメッセージボックスと呼ばれています。

以下のプログラムではプロセスの状態を調べられる _Process.info_ を使って、プロセスのメッセージボックスの内容を表示しています。

{% highlight text %}
{% raw %}
   message_receiver_pid = self()
   spawn(fn ->
      send(message_receiver_pid, "メッセージ0")
      send(message_receiver_pid, "メッセージ1")
      send(message_receiver_pid, "メッセージ2")
      send(message_receiver_pid, "メッセージ3")
      send(message_receiver_pid, "メッセージ4")
      {_, messages} = Process.info(message_receiver_pid, :messages)
      IO.puts "メッセージボックスには #{inspect messages} が入っています"
   end)
   Process.sleep(100)
   # => メッセージボックスには ["メッセージ0", "メッセージ1", "メッセージ2", "メッセージ3", "メッセージ4"] が入っています
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/X0IFXSaId23qelUo)

## Erlang プロセスは並列に動ける

Erlang プロセスは並列に動作します。ハードウェアによる限りはありますが、プロセスそれぞれが同時に別の計算を行えるということです。

ある処理を 1 つだけ実行したときと、複数 ( 今回は 2 つ ) 実行したときの、結果が得られるまでの時間を比較して検証しましょう。例えば 2 つ並列に動かして、_1 つ動かしたときの時間 * 2_ より小さいなら、並列に動いているといえるでしょう。

以下のプログラムでは Ruby の _sleep_ のように処理をスリープさせられる Elixir の関数 _Process.sleep_ を使って、処理に 5 秒かかるようにしています。時間は Ruby の _DateTime.now_ に似た Elixir の _DateTime.utc_now_ で測ることにしました。

また、 1 回の _receive_ で受けとれるメッセージは常に 1 つなので、ここでは 2 つのメッセージを受けとるため 2 回 _receive_ しています。

{% highlight text %}
{% raw %}
   IO.puts "#{DateTime.utc_now} 直列スタート"
   Process.sleep(5000)
   IO.puts "#{DateTime.utc_now} 1番目完了"
   Process.sleep(5000)
   IO.puts "#{DateTime.utc_now} 直列エンド"

   IO.puts "================"
   me = self()
   IO.puts "#{DateTime.utc_now} 並列スタート"
   spawn(fn ->
     Process.sleep(5000)
     send(me, DateTime.utc_now)
   end)
   spawn(fn ->
     Process.sleep(5000)
     send(me, DateTime.utc_now)
   end)

   receive do
     date_time ->
       IO.puts "#{date_time} 1番目完了"
   end
   receive do
     date_time ->
       IO.puts "#{date_time} 並列エンド"
   end
   # => 2017-08-17 11:41:12.254579Z 直列スタート
   # => 2017-08-17 11:41:17.368968Z 1番目完了
   # => 2017-08-17 11:41:22.384862Z 直列エンド
   # => ================
   # => 2017-08-17 11:41:22.385204Z 並列スタート
   # => 2017-08-17 11:41:27.400778Z 1番目完了
   # => 2017-08-17 11:41:27.400848Z 並列エンド
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/1D3W9tI4FKA2ItGL)

直列だと約 10 秒 (5 秒 * 2 回 ) かかって、並列だとほぼ 5 秒で終わっていますね。

## Erlang プロセスは軽量

Erlang プロセスを作るのには、プロセスのヒープ領域込みで 2.5k バイト程度しか要しません。この記事のここまでの文字を UTF-8 として計算すると 7.8k バイトであるようなので、これでプロセス 3 つ分作れてしまうようです。

Ruby の _Enumerable#reduce_ に似た Eliixr の関数 _Enum.reduce_ を使って 10 万プロセスを畳み込み、生成と処理にかかる時間を計測しましょう。また、 Elixir からは Erlang の関数を直接呼び出せるので、 Erlang の関数 _:erlang.memory(:total)_ で 10 万プロセスが生きているときのメモリ使用量も計測しましょう。

{% highlight text %}
{% raw %}
   IO.puts "#{DateTime.utc_now} 計測開始"
   last_pid = Enum.reduce(1..100_000, self(), fn (_prev, send_to) ->
     spawn(fn ->
       receive do
         x ->
           # 受けとったメッセージの数値に1を足し、次のプロセスへメッセージを送る
           send(send_to, x + 1)
       end
     end)
   end)

   memory = :erlang.memory(:total)
   send(last_pid, 0) # n個の子プロセスの最初の1個を動かす
   receive do
     final_answer ->
       IO.puts "#{DateTime.utc_now} 計測終了。数値:#{final_answer}。メモリ量:#{memory}"
   end
   # => 2017-08-16 16:16:29.249655Z 計測開始
   # => 2017-08-16 16:16:33.040399Z 計測終了。数値:100000。メモリ量:282859376
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/Jdddis6yA9QHH2ac)

プロセスを 10 万個生成して 1 ずつ足したので数値が計算結果が 10 万になっており、そのときの生成と実行にかかった時間は 4 秒程度、メモリ使用量は約 2.8 G バイトだったことがわかりますね。

## Erlang プロセス同士のかかわり

ここまでは Erlang プロセス自身の性質を見てきました。ここからは Erlang プロセス同士の関係に関する性質を見ていきましょう。

プロセスを作り、そのプロセス上でエラーを起こしても、元のプロセスでは何も検知しません。

Ruby の _raise_ に似た、 Elixir の _raise_ でエラーを起こしてみましょう。

{% highlight text %}
{% raw %}
   IO.puts "#{DateTime.utc_now} start"
   spawn(fn ->
     raise "boom!"
   end)

   Process.sleep(1000)
   IO.puts "\n#{DateTime.utc_now} done"
   # => 2017-08-16 16:23:20.787436Z start
   # =>
   # => 01:23:20.926 [error] Process #PID<0.76.0> raised an exception
   # => ** (RuntimeError) boom!
   # =>     prog.exs:3: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
   # =>
   # => 2017-08-16 16:23:21.804186Z done
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/4ZoIEU5Q1sZxZldD)

エラーログはコンソールに出力されているものの、処理は正常に終わって done が表示されています。

## Erlang プロセスは link できる

Erlang プロセス同士を link する方法があります。プロセス同士を繋げると、片方のプロセスで異常が起きたとき、もう一方へと知らせてくれます。

Elixir でプロセスを生成してすぐ link するには _spawn_link_ という関数を使います。

{% highlight text %}
{% raw %}
   IO.puts "#{DateTime.utc_now} start"
   spawn_link(fn ->
     raise "boom!"
   end)

   Process.sleep(1000)
   IO.puts "\n#{DateTime.utc_now} done"
   # => 2017-08-16 16:25:15.395832Z start
   # =>
   # => ** (EXIT from #PID<0.73.0>) an exception was raised:
   # =>     ** (RuntimeError) boom!
   # =>         prog.exs:3: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
   # =>
   # =>
   # => 01:25:15.525 [error] Process #PID<0.76.0> raised an exception
   # => ** (RuntimeError) boom!
   # =>     prog.exs:3: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
   # =>
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/owTt3cyR8nrhK3X6)

先程とは異なり done がコンソールに表示されていませんね。

生成してリンクしたプロセスにてエラーが発生、そのエラーが元のプロセスへ伝えられ、元のプロセスでもエラーハンドリングしていないため、元のプロセスもエラーになりました。

## Erlang プロセスのエラーハンドリング

エラーを知らせてくれるのは便利ですけれども、エラーハンドリングしないと自分もエラーになってしまうのは不便ですね。

ある Erlang プロセスから別の Erlang プロセスへエラーを伝えるのは、特別なメッセージを送ることで行われています。そのメッセージの名前を _exit シグナル_ といいます。ErlangVM には _exit シグナル_ を通常のメッセージとして受け付ける仕組みがあるので、それを利用してエラーハンドリングします。

あるプロセスに _Process.flag(:trap_exit, true)_ と書くと _exit シグナル_ を通常のメッセージとして扱えるようになります。

{% highlight text %}
{% raw %}
   IO.puts "#{DateTime.utc_now} start"
   Process.flag(:trap_exit, true)
   spawn_link(fn ->
     raise "boom!"
   end)

   Process.sleep(1000)
   receive do
     message ->
       IO.puts "exitシグナルを受信しました: #{inspect message}"
   end
   IO.puts "\n#{DateTime.utc_now} done"
   # => 2017-08-16 16:26:58.615378Z start
   # =>
   # => 01:26:58.680 [error] Process #PID<0.76.0> raised an exception
   # => ** (RuntimeError) boom!
   # =>     prog.exs:4: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
   # => exitシグナルを受信しました: {:EXIT, #PID<0.76.0>, {%RuntimeError{message: "boom!"}, [{:elixir_compiler_0, :"-__FILE__/1-fun-0-", 0, [file: 'prog.exs', line: 4]}]}}
   # =>
   # => 2017-08-16 16:26:59.741148Z done
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/JEbFgmjGixoZ0rDZ)

exit シグナルを通常のメッセージとして受信し、その後 done になっていますね。

## Erlang プロセスを link するとどう嬉しいのか

こうしてプロセスを link しておくことにはどのような意味があるのでしょうか。この記事の最後に紹介している、『すごい Erlang ゆかいに学ぼう！』という本の「第 12 章 - エラーとプロセス (P151)」 には以下のように記述がありました。

> もしエラーのあるプロセスがクラッシュしたけれど、それに依存しているプロセスが動き続けているとしたら、それら依存プロセスすべては依存先がなくなったことに対処しなければならなくなります。


link しておけば処理を実装するプログラマが考えなければいけない状態が一つ減ります。

また、 link したプロセスが死んだことをすぐに検知できると、時間をおかずに新しいプロセスを作りなおすことができます。エラー検知/再開を素早く行えると、一部の処理で不具合が起きても全体の動作には影響をほぼ与えずに復元することができ、全体の安定動作向上に寄与します。

## Erlang プロセスは monitor できる

Erlang プロセス同士を link するのではなく、片方がもう片方を見ておく方法があります。 monitor といいます。先程の link は link 元と link 先が対等の立場でしたが、 monitor は monitor 元と monitor 先で立場が異なります。

Elixir でプロセスを生成してすぐ monitor するには _spawn_monitor_ という関数を使います。

{% highlight text %}
{% raw %}
   IO.puts "#{DateTime.utc_now} start"
   spawn_monitor(fn ->
     raise "boom!"
   end)

   Process.sleep(1000)
   receive do
     message ->
       IO.puts "メッセージを受信しました: #{inspect message}"
   end
   IO.puts "\n#{DateTime.utc_now} done"
   # => 2017-08-16 16:29:49.030618Z start
   # =>
   # => 01:29:49.072 [error] Process #PID<0.76.0> raised an exception
   # => ** (RuntimeError) boom!
   # =>     prog.exs:3: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
   # => メッセージを受信しました: {:DOWN, #Reference<0.2290368879.2564030465.30809>, :process, #PID<0.76.0>, {%RuntimeError{message: "boom!"}, [{:elixir_compiler_0, :"-__FILE__/1-fun-0-", 0, [file: 'prog.exs', line: 3]}]}}
   # =>
   # => 2017-08-16 16:29:50.086205Z done
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/ams6gsRUJcQUdKbe)

link の際とは異なり _Process.flag(:trap_exit, true)_ を使っていないプロセスでも受け取れていることに注意してください。_exit シグナル_ ではない、単なるメッセージが送られてきます。

## Erlang プロセスを monitor するとどう嬉しいのか

こうしてプロセスを monitor しておくことにはどのような意味があるのでしょうか。『すごい Erlang ゆかいに学ぼう！』「第 12 章 - エラーとプロセス (P158)」 には以下のように記述がありました。

> モニターは、プロセスが下位のプロセスで何が起きているかを知りたいけれど、お互いが致命的な影響を及ぼしてほしくないときに便利です。( 略 ) 他のプロセスで何が起きているかを知る必要があるライブラリを書くときに活躍します。


私があまり monitor を使いこなしていないせいか、 monitor がバチッとハマりそうな例はうまく思いつきませんでした。すみません m(_ _)m みなさんでよい例を知っていたり、おもいついたらブログなどに書いていただけると嬉しいです。

## Erlang プロセス同士の結びつきまとめ

以上のように、プロセス同士の結びつきの強度に応じていくつかの方法が提供されています。

* A が B を link した場合、 A がエラーになったら B へ _exit シグナル_ が行く。 B がエラーになったら A へ _exit シグナル_ が行く。
* A が B を monitor した場合、 A がエラーになっても B は影響を受けない。 B がエラーになったら A へ通常のメッセージが行く。
* それ以外の場合、他のプロセスで何が起きようと影響を受けない


## 壊れやすいタイマー

さてここまでプロセスの性質やプロセスのインタラクションについて説明してきたので、これらを組み合わせて簡単なアプリケーションを作ってみましょう。

壊れやすいタイマーというものを考えてみます。毎秒時刻を出力し、 30% の割合で壊れてしまうタイマーを考えましょう。

Ruby の _module_ に似た、 Elixir の _defmodule_ でモジュールを定義、Ruby の _def_ に似た、 Elixir の _def_ で関数を定義します。また Elixir には while のようなループがなく、ループは関数の中で自身の関数を呼び出す、いわゆる再帰で表現します。

{% highlight text %}
{% raw %}
   defmodule FragileTimer do
     def loop do
       case :rand.uniform() do
         x when x < 0.3 ->
           exit("ガシャ")
         _x ->
           IO.puts "#{DateTime.utc_now}"
       end
       Process.sleep(1000)
       loop()
     end
   end

   FragileTimer.loop
   => 2017-08-16 16:33:14.767947Z
   => 2017-08-16 16:33:15.785176Z
   => 2017-08-16 16:33:16.786127Z
   => 2017-08-16 16:33:17.787063Z
   => 2017-08-16 16:33:18.788181Z
   =>
   => ** (exit) "ガシャ"
   =>     prog.exs:5: FragileTimer.loop/0
   =>     (elixir) lib/code.ex:376: Code.require_file/2
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/7a8Tu7aK85jD5Q2p)

ここまでは意図通りに動くようです。とはいえ、壊れてしまいタイマーが動かなくなると困るので、タイマーが壊れたのを検知してすぐに新しいタイマーを起動する見張り役のプロセスを作り、タイマーを安定動作させることを目指します。

{% highlight text %}
{% raw %}
   defmodule FragileTimer do
     def loop do
       case :rand.uniform() do
         x when x < 0.3 ->
           exit("ガシャ")
         _x ->
           IO.puts "#{DateTime.utc_now}"
       end
       Process.sleep(1000)
       loop()
     end
   end

   defmodule FragileTimerSupervisor do
     def loop(times) when 3 < times do
       IO.puts "3回壊れたのであきらめます"
     end

     def loop(times) do
       spawn_monitor(fn ->
         FragileTimer.loop
       end)
       IO.puts "#{DateTime.utc_now} にタイマー起動しました"
       receive do
         _down_message ->
           IO.puts "#{DateTime.utc_now} に壊れたのを検知しました"
           loop(times + 1)
       end
     end
   end

   FragileTimerSupervisor.loop(1)
   => 2017-08-16 16:35:34.013130Z にタイマー起動しました
   => 2017-08-16 16:35:34.017548Z
   => 2017-08-16 16:35:35.027242Z に壊れたのを検知しました
   => 2017-08-16 16:35:35.027497Z にタイマー起動しました
   => 2017-08-16 16:35:35.027560Z
   => 2017-08-16 16:35:36.028080Z
   => 2017-08-16 16:35:37.029087Z
   => 2017-08-16 16:35:38.030102Z に壊れたのを検知しました
   => 2017-08-16 16:35:38.030352Z にタイマー起動しました
   => 2017-08-16 16:35:38.030422Z
   => 2017-08-16 16:35:39.031359Z
   => 2017-08-16 16:35:40.033239Z
   => 2017-08-16 16:35:41.034229Z
   => 2017-08-16 16:35:42.035212Z
   => 2017-08-16 16:35:43.036179Z に壊れたのを検知しました
   => 3回壊れたのであきらめます
{% endraw %}
{% endhighlight %}


[コード](https://wandbox.org/permlink/1dWaw0nNjBlgQO8B)

壊れやすいタイマーと、見張り役を組み合わせることで多くの時間にはきちんと動くタイマーを作ることができましたね。

このコードではランダムで表現した「壊れやすい」部分というのは現実的なプログラミングだとどの部分になるでしょうか？　私は例えば TCP コネクションがそうだと考えています。 TCP コネクションは相手先の都合やネットワークでいつ切れるかわかりません。 HTTP サーバーや Websocket サーバーはこういった特色を持ちます。そして複数の TCP コネクションを持っているサーバーが、 1 つの TCP コネクションのエラーの悪影響を受けることを避けたいですよね。こういったケースには ErlangVM のプロセスの性質が生かされます。

## Erlang プロセスを扱うライブラリ Erlang//OTP

これまで挙げたようなプロセスの協調動作を駆使するのが ErlangVM のプログラミングの面白く難しいところですが、これらのプリミティブな性質を直接使うのではなく、便利に利用するためのライブラリ OTP というものが Erlang に標準添付されています。

説明ではわかりやすさのために、_spawn_ や _link_ や _monitor_を直接利用していましたが、私がこれまで眺めたことのある Erlang/Elixir ライブラリたちではそれらはほとんど使われず、 OTP を使うものが多かったです。

プロダクションで利用するコードには OTP を利用しましょう。

## 最後に

私が最初に Erlang を学びはじめたとき、よくわからなかったのは「ErlangVM でのプログラミングは Ruby に比べてどういう利点があるのだろう？」というところでした。学んでいくうちに、それは Erlang プロセス上の処理について着目していたから、利点がよくわからなかったのだという感想にいたっています ( 今のところ )。 ErlangVM プログラミングは、__プロセス上の処理__ より、 __プロセスとプロセスのつながり方__ をどうデザインするかいう視点で捉えてみると利点がよく見えてくる気がしました。

Erlang プロセスや OTP について深く知りたければ私は『[すごい Erlang ゆかいに学ぼう！](http://shop.ohmsha.co.jp/shopdetail/000000003873/) 』という本をおすすめします。この本、特に「第 12 章 - エラーとプロセス」を読んで得た知識を元にこの記事に書きました。

また Elixir に興味が湧いた方には 『[プログラミングElixir](http://shop.ohmsha.co.jp/shopdetail/000000004675/)』をおすすめします。 この本にも当然 Erlang プロセスや OTP のことがしっかりと書かれているので Rubyist の方はこちらの本から読み始める方がとっつきやすいかもしれません。 私は最初この本から入りました。 

## 著者について

ヽ（´・肉・｀）ノ [@niku_name](https://twitter.com/niku_name)

札幌に住んでいて、お仕事や趣味で Ruby を書いています。だいたい毎週木曜日に開催されている[サッポロビーム](http://sapporo-beam.github.io/)という ErlangVM について話す集まりに参加しています。たまに RubySapporo.beam というイベント ( [#1](https://rubysapporo.doorkeeper.jp/events/50956), [#2](https://rubysapporo.doorkeeper.jp/events/57253) ) を開催しています。


