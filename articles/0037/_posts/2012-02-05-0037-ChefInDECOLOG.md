---
layout: post
title: Chef でサーバ管理を楽チンにしよう！ (第 2 回)
short_title: Chef でサーバ管理を楽チンにしよう！ (第 2 回)
tags: 0037 ChefInDECOLOG
---


* Table of content
{:toc}


書いた人：諸富　洋 ([@164c](https://twitter.com/#!/164c))

## 最初に

前回の「[Chef でサーバ管理を楽チンにしよう！ (第 1 回)]({% post_url articles/0035/2011-09-26-0035-ChefInDECOLOG %})」では、Chef の紹介とカンタンなレシピの書き方とテストの方法を紹介しました。今回は次の一歩を紹介したいと思います。

ひとたび Chef を導入したならば、その後はレシピを書くことが Chef に関わるタスクの大半になります。ですので、今回も引き続き、レシピの書き方についてお伝えしていきます。今回のテーマは「○○したら、それを受けて××する」という手続きのレシピの書き方です。

## 対象読者

Chef を導入したばかりでレシピの書き方に迷っている人

## 今回の課題

前回では、ミドルウェアなどの設定ファイルの管理を想定した「一定の内容が書かれたファイルを指定の場所に指定の状態に保つ」ことを実現しました。

さて、この設定ファイルの内容を変える必要が出てきたとします。ただテキストを変更するだけなら、とてもカンタンです。テンプレートを修正して chef-solo を実行するか、chef-client の実行をすれば変更後の内容に置き換わります。

ところが、大抵のミドルウェアでは設定ファイルの内容を置き換えるだけでは変更内容は反映されません。だいたい後の処理として再起動など (reload とか restart) が必要になります。
このような「○○したら、それを受けて××する」というのはレシピを書く上での超頻出パターンです。

今回はこの「○○したら、それを受けて××する」について挑戦してみたいと思います。[Chef Wiki の Resources のページ](http://wiki.opscode.com/display/chef/Resources)を参考にしながら進めます

また、前回の続きということで、cookbook "test" がすでにある状態から始めます。

## 設定ファイルを変更したらサービスを再起動

「httpd.conf を修正したら apache 再起動」をイメージしてみます。
これは前述の参考サイトにほとんどそのまんま書いてあります。

```ruby
# test/recipes/default.rb

template "/tmp/test.conf" do
  notifies :restart, "service[httpd]"
end

service "httpd"

```

これだけです。Service リソースは引数と同名の init スクリプトを探して実行します。service コマンドと同じですね[^1]。

[http://wiki.opscode.com/display/chef/Resources#Resources-Service](http://wiki.opscode.com/display/chef/Resources#Resources-Service)

設定ファイルに変更がないときのログ

{% highlight text %}
{% raw %}
〜
[Thu, 19 Jan 2012 22:22:37 +0900] DEBUG: template[/tmp/test.conf] content has not changed.
[Thu, 19 Jan 2012 22:22:37 +0900] DEBUG: Processing service[httpd] on hoge
[Thu, 19 Jan 2012 22:22:37 +0900] INFO: Processing service[httpd] action nothing (test::default line 32)
〜
{% endraw %}
{% endhighlight %}


"content has not changed." で "Processing service[httpd] action nothing" とでています。実際の動作も何もしません。

設定ファイルに変更があった時のログ

{% highlight text %}
{% raw %}
[Thu, 19 Jan 2012 22:24:46 +0900] INFO: Processing template[/tmp/test.conf] action create (test::default line 24)
[Thu, 19 Jan 2012 22:24:46 +0900] DEBUG: Current content's checksum:  15b601f97b98f27fc0e209408fa88366544286d13987c4a6cf87b0734396add8
[Thu, 19 Jan 2012 22:24:46 +0900] DEBUG: Rendered content's checksum: 2e0390eb024a52963db7b95e84a9c2b12c004054a7bad9a97ec0c7c89d4681d2
〜〜〜〜
[Thu, 19 Jan 2012 22:24:46 +0900] INFO: template[/tmp/test.conf] sending restart action to service[httpd] (delayed)
{% endraw %}
{% endhighlight %}


"Processing template[/tmp/test.conf] action create" ということでファイルが置き換えられます。
その後 "sending restart action to service[httpd] (delayed)" ということで httpd に対して restart が送られます。
最後に (delayed) というのがあります。

変更時に処理を指定する際に "notifies" を使いますが、notifies のデフォルトは delayed となり、キューに貯められて Chef の処理の最後にまとめて実行されます。
今回は、処理がひとつしかないので特に困りませんが、依存関係のある複数の処理が走る場合に、即時実行したい場合は、:immediately を指定しましょう。

```ruby
# test/recipes/default.rb

template "/tmp/test.conf" do
  notifies :restart, "service[httpd]", :immediately
end

service "httpd"

```

これで実行してログを確認すると、先程 (delayed) になっていた部分が (immediate) に変わっているはずです。

先ほどの Service リソースのマニュアルに書いてあるとおり、service 名は別名で指定できますし、start、stop、restart などの処理に対してコマンドを明示することもできます。

つまり、

```ruby
# test/recipes/default.rb

template "/tmp/test.conf" do
 owner "root"
 group "root"
 mode "0644"
 notifies :restart, "service[hoge]"
end

service "hoge" do
  service_name "httpd"
  restart_command "service httpd restart"
end

```

こう書くことができます。

こういった具合に DSL を使ってやりたいことがカンタンに書けちゃいますので、柔軟に実現することができます。

## もっといろいろ実行してみる

Service リソースは service の制御しかできません (十分有用ですけど) 。

さらに自由度が高いリソースとして [Execute リソース](http://wiki.opscode.com/display/chef/Resources#Resources-Execute)があります。これを使って、メールを送ってみることにしましょう。

この流れなので「設定ファイルに変更があったら、メール送信」ということにしたいと思います。

```ruby
# test/recipes/default.rb

execute "sendmail" do
  command 'echo "Cook me something tasty." | mail -s "Hello! Chef!" 164c@example.com'
end

template "/tmp/test.conf" do
 owner "root"
 group "root"
 mode "0644"
# notifies :restart, "service[hoge]"
 notifies :run, resources(:execute => "sendmail")
end

```

こんな感じに書いてみます。execute のブロックは呼び出す前に記述しておく必要があります。

これを実行するとメールが送られてくると思います[^2]。ところが、これだとファイルに変更がなくても実行されてしまい、メールが送られてきます。

Execute リソースのアクションは run と nothing で、デフォルトが run になっているためです。ファイルが変更されたときだけ、実行させるためには nothing にしておきます。

```ruby
# test/recipes/default.rb

execute "sendmail" do
  command 'echo "Cook me something tasty." | mail -s "Hello! Chef!" morotomi@328w.co.jp'
  action :nothing
end

template "/tmp/test.conf" do
 owner "root"
 group "root"
 mode "0644"
# notifies :restart, "service[hoge]"
 notifies :run, resources(:execute => "sendmail")
end

```

これで完成です。実行してログとメールを確認してみてください。

ちなみに Script リソースを使えばこれと同じようなことは Perl や Python、Ruby などの言語で書くこともできます。

[http://wiki.opscode.com/display/chef/Resources#Resources-Script](http://wiki.opscode.com/display/chef/Resources#Resources-Script)

ところで、マニュアルによると「Execute や Script リソースは "idempotent" を保証してないよ！　だからあなたが "idempotent" になるように記載するよう注意してね！」ということが書かれています。"idempotent" とは、何回行なっても同じ結果が得られることを指す概念だそうです[^3]。今回はなんでもできる度をアピールするためこういった例を出しましたが、Chef はサーバ環境などを "idempotent" に保つために設計されたものであり、その思想から外れるものは別のツールに頼るのが後の幸せを買うことになるのかもしれません。

## 最後に

というわけで、今回は以上です。

いきなりですが、ミツバチワークスではプログラマーやインフラエンジニアなど、Web サービスの開発・運用メンバーを募集しています。みんな大好き Rails を使ったプロジェクトも近々開始されます (というかこれが公開されるころには開始されているはず。。) 
Chef以外にも様々な取り組みを行なっていますので、興味があるかたはぜひ、「[仲間募集のお知らせ](http://tech.dclog.jp/2010/10/blog-post.html)」をご覧ください！

## 著者について

諸富　洋。モバイル向けブログサイト「[DECOLOG](http://dclog.jp/)」を運営する[ミツバチワークス株式会社](http://www.328w.co.jp/)の中の人。[@164c](https://twitter.com/#!/164c)。[DECOLOG TECH BLOG](http://tech.dclog.jp/)。

[^1]: というか、chef-solo のログを見ていたら内部的にも service コマンドが実行されていました
[^2]: sendmail コマンドで外部にメールが送れる環境が必要です
[^3]: 日本語では冪等性 (べきとうせい) と言ったりする
