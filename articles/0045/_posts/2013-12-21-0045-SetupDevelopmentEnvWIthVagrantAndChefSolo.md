---
layout: post
title: vagrantとchef-soloを使った開発環境の構築
short_title: vagrantとchef-soloを使った開発環境の構築
tags: 0045 SetupDevelopmentEnvWIthVagrantAndChefSolo
---
{% include base.html %}


## vagrant と chef-solo を使った開発環境の構築

* Table of content
{:toc}


----

対象読者
: 初心者〜中級者

### はじめに

開発環境の構築は、アプリを作る上で重要ですが、楽をしたい作業です。<br />
ただし、開発環境構築で手を抜き、チームメンバー間で環境の差異がでてしまった場合、問題があった時の切り分けが困難になってしまいます。<br />
そこで、チームのメンバーが同じ環境を簡単に作れるように、vagrant と chef-solo を使った開発環境の構築についてご紹介したいと思います。

### vagrant について

[vagrant](http://www.vagrantup.com/) は、仮想マシン (バーチャルマシン、以降は VM とします) をプログラマブルに作成/破棄できるツールです。<br />
vagrant はプラグイン機構をもっており、プラグインにより vagrant を拡張することができます。<br />
操作出来る VM は VirtualBox が基本なのですが、有料ですが VMware をサポートしている vagrant も公開されています ([VMware Vagrant Environments](http://www.vagrantup.com/vmware))。<br />
その他にも色々なプラットフォームが操作できるようなプラグインが配布されています
([Available Vagrant Plugins](https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Plugins))。

### chef-solo について

chef-solo は [chef](http://www.opscode.com/chef/) というツールに同梱されている、プロビジョニングツールです。<br />
プロビジョニングツールとは、サーバー構築・管理を自動化するツールです。<br />
chefはサーバークライント構成をとって、サーバーの構成管理をおこなっていますが、chef-soloはサーバークライント構成を使わず、単体でプロビジョニングを行うことができるツールです。<br />
プロビジョニングツールには、chef以外にも、puppetなどが挙げられます。<br />

#### なぜchef-soloを採用したのか

上記でも紹介したとおり、プロビジョニングツールはchef以外にも色々ありますが、その中でchefを選んだ理由は、

* 私自身がchefに慣れていたこと
* 私の周りにchefを知っている人が多かったこと


くらいです。<br />
ですので、特にchefを勧めるわけではありません。<br />
chef以外に慣れているプロビジョニングツールがあれば、それを採用することをおすすめします。<br />
ただし、vagrantと連携できるプラグインがあるかどうかは確認しておいて下さい。(もしなければ、自分でプラグインを書くことになるでしょう)<br />
vagrantには、chefとpuppetを実行するためにプラグインが予め同梱されています。<br />

#### Berkshelfについて

Berkshelfは、chefで使うクックブックを管理するgemです。<br />
必要なクックブックを、設定に従って集めて来てくれます。  <br />
設定はBerksfileというファイルに下記のように書きます。

{% highlight text %}
{% raw %}
cookbook 'sudo', git: 'git@github.com:opscode-cookbooks/sudo.git'
cookbook 'hoge', git: 'git@github.com:SpringMT/hoge.git'
{% endraw %}
{% endhighlight %}


bundlerとGemfileと同じような関係ですね。<br />
ここに、使用するクックブックを列挙しておくと、プライベートgit、chef server、ローカルのファイルなどからBerkshelfが自動的にクックブックを集めてきてくれます。<br />
Berkshelfを使うことによって、クックブックを分割して管理することができ、再利用性が高まるので、chefを使う際はオススメです。<br />

### vagrantとchef-soloを使った環境構築を行う前に

まず、vagrantとchef-soloを使う前に、これらツールを使う理由を整理しましょう。

#### なぜvagrant、chef-soloを使って環境構築を行うのか

開発環境を構築するために、なぜvagrant、chef-soloを使うのでしょうか。<br />
vagrantを使うということは、自分のマシンにVMを立ち上げることになり、もう一台マシンが走っていることになります。<br />
その分だけ、ホストマシンに負荷がかかり動作が重くなるのは明白です。<br />
ですので、私個人の意見としては、開発環境構築にvagrantを使ってVMを立ち上げるよりは、ホストマシンだけで開発環境を構築できるのであれば、そうするべきだと思っています。<br />

現在、Macを使っていれば、Homebrewなどを使って様々なミドルウェアをインストールすることができます。<br />
また、Macであればローカルマシンの環境構築には[boxen](http://boxen.github.com/)を使うこともできます。

ではなぜ、今回vagrantを使ってVMを立ち上げることを選択したのでしょうか。<br />
それには、下記のようなローカルの環境では設定しにくい要因があったためです。

* 特定のユーザーでなければ動かないアプリ
* 特定のホスト名を設定しておかないと動かないアプリ
* rootユーザーでしか作れないような、特定のディレクトリ構造が必要なアプリ


上記のようなことをローカルマシンで実現できないわけではないのですが、ローカルマシンへの影響が大きすぎるため、vagrantとchef-soloを使ってVM上に環境構築することにしました。<br />

#### vagrantとchef-soloを使うための前提条件

vagrantは、Mac、windows、Linuxの環境全て動きます。<br />
ただし、今回私が試した環境はMacのみなので、それ以外のOSでは動作確認をしていません。

### vagrantとchef-soloを使った環境構築の準備

まず、vagrantとchef-soloを動かす設定を作ります。

#### ローカルマシンの環境を整える

##### Rubyのインストール

ここではRubyのインストールの仕方については細かく説明しません。<br />
rbenvやrvmを使ってインストールすることをおすすめします。<br />
るびまでも紹介されているので参考になると思います。

* [FirstStepRuby]({{base}}{% post_url articles/first_step_ruby/2000-01-01-FirstStepRuby %})


##### vagrantのインストール

gemで配布されているvagrantは__使ってはいけません__。(rubygemsに登録されているvagrantはバージョンがかなり古いです) <br />
vagrantは、下記ページからOSにあったファイルをダウンロードしてインストールして下さい。<br />
Macの場合はdmgですね。  

* [http://downloads.vagrantup.com/](http://downloads.vagrantup.com/)


vagrantのインストールが完了すれば、vagrantコマンドが使えます。<br />
vagrantコマンドを使って、Berkshelfと連携するプラグインをインストールしておきましょう。

{% highlight text %}
{% raw %}
vagrant plugin install vagrant-berkshelf
{% endraw %}
{% endhighlight %}


chef-soloと連携するプラグインはvagrantに同梱されているので、特にプラグインのインストールは不要です。<br />
他にも使いたいプラグインがあれば、各々インストールしてください。

##### boxファイルの準備

boxファイルは、vagrantでVMを立ち上げるためのベースとなるファイルです。<br />
vagrantのサイトで公開されているものもありますが、その中に自分が使いたいboxファイルがない場合や、個人で公開している野良boxファイルしか見つからず、自前でboxファイルを用意する必要がある場合があるかと思います。

boxファイルを作ることになる場合、[veewee](https://github.com/jedi4ever/veewee)というツールを使うことがお勧めです。<br />
boxファイルを作る際は、boxファイルは極力シンプルにしておくと良いと思います。<br />
多くの人が使える状態にしておき、あとで、chef-soloで自分の好きな状態にするのが良いでしょう。

さて、作ってboxファイルの共有はどうしましょう。<br />
コピーして渡すには容量がそれなりに大きく、会社によってはUSBを使った共有もできない場合もあります。<br />
実は、ここが結構困ったところですが、結局自分はチームの全員がアクセスできるファイルサーバーにおいて、そこからダウンロードしてもらっています。<br />

#### vagrantの準備

vagrantがインストールできていれば、vagrantコマンドが使えると思います。<br />
まず、vagrantの設定ファイルを格納するディレクトリを作って、そこでvagrant initを行います。<br />
更に、boxファイルをvagrantに登録します。

{% highlight text %}
{% raw %}
mkdir [vagrant dir]
cd [vagrant dir]
vagrant init
vagrant box add 'vagrantに登録する名前' 'boxファイルのパス'
{% endraw %}
{% endhighlight %}


ここで、_Vagrantfile_というファイルができていることを確認してください。<br />
Vagrantfileのサンプルは下記のとおりです。

{% highlight text %}
{% raw %}
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "vagrant box addで登録したboxファイルの名前"
  # berkshelfを使うのでtrue
  config.berkshelf.enabled = true
  # hostnameの設定が必要であれば設定可能
  config.vm.hostname = 'test'
  # chefの設定
  config.vm.provision :chef_solo do |chef|
      chef.run_list = [
      # 使うクックブックを列挙しておく
      "sample",
    ]
  end
end
{% endraw %}
{% endhighlight %}


他にも、私の場合は、ネットワークの設定やsynced_folderの設定をしていますが、上記の設定だけでも十分に稼働可能です。　　

#### chef-soloの準備

まず、chefを使うための準備を行います。
chef本体と、chefのクックブックを作るためのツールknife-soloをインストールします。

{% highlight text %}
{% raw %}
gem install chef
gem install knife-solo
{% endraw %}
{% endhighlight %}


もちろん、bundler経由からインストールしても問題ありません。<br />
インストールが完了したら、vagrant initしたディレクトリで下記コマンドを実行します。

{% highlight text %}
{% raw %}
knife solo init .
{% endraw %}
{% endhighlight %}


そうすると、

{% highlight text %}
{% raw %}
.
├── Berksfile
├── Vagrantfile
├── cookbooks
├── data_bags
├── environments
├── nodes
├── roles
└── site-cookbooks
{% endraw %}
{% endhighlight %}


こんな感じにディレクトリが作られると思います。<br />
それぞれの説明はchefを解説しているブログ等に譲りますが、ここで幾つか自分が取った方針について紹介しようと思います。

##### クックブックの分割

クックブックの再利用が困難になるため、site-cookbooksの中にはクックブックをほとんど入れませんでした。<br />
なるべく最小の単位でクックブックで作り、クックブックはそれぞれレポジトリを作って管理しました。<br />
それらを、Berkshelfでまとめて使えるようにしています。  <br />
クックブックは、誰でも使える場所に公開しておき、再利用可能な状態にしておくことで、他に使いたい人が再発明しなくてすみます。

site-cookbooksに入れたクックブックは、作りたい環境特有の設定を行うためのクックブックのみになっています。(このクックブックも、あとでシェアできるようになるべく分割しています)

##### 暗号化

chefには、data_bagという仕組みを使って、公開したくないデータを暗号化して配布する方法があります。(パスワードなど)
しかし、今回はその方法を採用しませんでした。
その理由としては、下記二点がありました。

* 鍵の配布が手間
* 開発環境の構築のみなので、パスワード等の暗号化は特に必要ないものだった


鍵の配布は特に手間になるので暗号化したい場合は、鍵の配布の方法も合わせて考える必要があります。<br />
しかし、チームのほとんどが同じ鍵を持つことになるので、特に暗号化する必要がないと思い、今回は特に暗号化をしませんでした。

#### クックブックの書き方

ほとんどのクックブックは出回ってるクックブックと同じ書き方をしていますが、GH:EのリポジトリやGitHubのプライベートリポジトリをcloneしてくる部分が大分ハマったので、ここで紹介できればと思います。

###### GH:EのリポジトリやGitHubのプライベートリポジトリからクローンしてくる

これは、ローカルマシンとvagrantとの連携技になります。  
まず、Vagrantfileの設定で、sshのforward_agentをtrueにしてください。

{% highlight text %}
{% raw %}
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  .
  config.ssh.forward_agent = true
  .
end
{% endraw %}
{% endhighlight %}


次に、ローカルマシンの``ssh/config``の設定を行ってください。

{% highlight text %}
{% raw %}
Host [GH:Eのhostやgithub.com]
ForwardAgent yes
{% endraw %}
{% endhighlight %}


ローカルマシンで、ssh-agentにGH:EもしくはGitHubで使ってる鍵を登録してください。

{% highlight text %}
{% raw %}
ssh-add ~/.ssh/id_rsa
# 登録できているか確認
ssh-add -l
{% endraw %}
{% endhighlight %}


この設定で、VMから__vagrantユーザー__が、ローカルマシンのssh agent経由でGH:EやGitHubのプライベートリポジトリからgit cloneすることができます。<br />
ただし、このままだとVMからcloneするときにwarnningメッセージがでて実行が止まってしまうので、vagrantユーザーの.ssh/configに下記の設定を反映できるようなクックブックを書いて実行できるようにしておいてください。<br />
サンプルはこちらです。

* recipie


{% highlight text %}
{% raw %}
directory "#{node['vagrant']['tmp_vagrant_path']}" do
  owner "vagrant"
  group "vagrant"
  mode  "2775"
  recursive true
end
template "/home/vagrant/.ssh/config" do
  source "ssh.config.erb"
  mode   "0600"
  owner  "vagrant"
  group  "vagrant"
end
{% endraw %}
{% endhighlight %}


* template


{% highlight text %}
{% raw %}
Host [GH:Eのhostやgithub.com]
  StrictHostKeyChecking no
{% endraw %}
{% endhighlight %}


ここまで行うと、vagrantユーザーでgit cloneすることができます。<br />
ただ、このままでは、cloneしたディレクトリがvagrantユーザーになってしまうので、一旦git cloneした後に、cloneしてきたリポジトリをmvで移動したり、ユーザーを変えたりする必要があります。<br />
クックブックで表現すると下記のようになるかと思います。

{% highlight text %}
{% raw %}
git "#{tmp_vagrant_path}/test" do
  repository "git@github.hoge.jp:test/test.git"
  revision   "master"
  user       "vagrant"
  group      "vagrant"
  action     :checkout
  not_if     "test -d /home/user/test"
end
execute "chown hoge at test" do
  command "chown -R hoge:hoge #{tmp_vagrant_path}/test"
  not_if "test -d /home/user/test"
end
execute "mv test" do
  command "mv #{tmp_vagrant_path}/test /home/hoge/"
  not_if "test -d /home/user/test"
end
{% endraw %}
{% endhighlight %}


この他に方法が無いかと色々試したのですが、この方法以外しか見つからず。。。<br />
他にいい方法があれば、ぜひご教授頂きたいです！！

#### 作ったクックブックをberkshelfに登録し、VMを立ち上げる

ここまで、準備ができたら、Berksfileに作成したクックブックを設定し、``berks install``を実行してください。<br />
その後に、

{% highlight text %}
{% raw %}
vagrant up
{% endraw %}
{% endhighlight %}


を行えば、VMが立ち上がります。

### 実際に環境を構築してもらう

ここまでできたら、他に人にも使ってもらえる準備が整いました。<br />
以下には、使ってもらったときに起きたトラブルとその解消方法を紹介します。

#### 起こりえるトラブル

##### SEGV

vagrant upを実行中、結構な頻度でSEGVで落ちます。
![vagrant-dot_error.jpeg]({{base}}{{site.baseurl}}/images/0045-SetupDevelopmentEnvWIthVagrantAndChefSolo/vagrant-dot_error.jpeg)

この場合は、vagrant provisionを実行して再度chefを実行しましょう。<br />
(クックブックは冪等性を担保していることが前提となります。)

##### クックブックを修正した場合

環境を更新するために、クックブックを修正することが多々あると思います。<br />
クックブックを修正したら、vagrantを管理しているディレクトリで``berks update`` を実行してBerksfile.lockを更新しましょう(よく忘れます。。。。)。<br />
Berksfile.lockを更新したら、使ってる人たちに連絡してberks installしてもらい、vagrant provisionを実行してもらい新しいクックブックを適用しましょう。

##### 立ち上げた仮想マシンのシャットダウン、ホストマシンのシャットダウン

vagrant haltすると、VMがsymbol lookup errorがでて立ち上がらなくなることがあります。一旦止めたいときはvagrant suspendで行うことを推奨します。<br />
また、いきなりホストマシンを落とすと恐らくvagrant haltと同じ現象が起こり、立ち上がらなくなる場合があります。<br />
ホストマシンを落とすときは、一旦vagrant suspendしてからホストマシンを落とすとよいでしょう。

##### git cloneが終わらない(巨大なリポジトリの場合)

ウンGレベルまで肥大化した深淵なリポジトリをcloneする場合、timeoutすることがあります(デフォルトは300 sec)。<br />
この場合、boot_timeoutの値を伸ばしてあげましょう。

{% highlight text %}
{% raw %}
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  .
  config.vm.boot_timeout = 3600
  .
end
{% endraw %}
{% endhighlight %}


もともとはssh.timeoutだったのですが、名前が変わってハマりました。。。  

* [変更されたコミット](https://github.com/mitchellh/vagrant/commit/5a4c06f75e2fc727a17152a959a7a64992049137)


### まとめ

開発環境構築はチームで開発を行う上で重要ではありますが、あまり時間を掛けたくないものです。<br />
この記事で、少しでも開発環境構築が楽になればと思います。

### 筆者について

春山 誠 ([@Spring_MT](https://twitter.com/Spring_MT))<br />
Fukuoka.rb所属(だったんですが、東京に引っ越したので現在は不定)<br />
Perlがメインの会社にいますが、今は主にRuby書いてます。


