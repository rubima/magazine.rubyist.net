---
layout: post
title: Ruby 初心者の新卒エンジニアが gem パッケージ公開に至るまで
short_title: Ruby 初心者の新卒エンジニアが gem パッケージ公開に至るまで
created_on: 2014-04-05
tags: 0046 RandexMultibyteGem
---
{% include base.html %}


* Table of content
{:toc}


書いた人： @deme0607

## はじめに

Ruby 初心者の筆者が新卒で配属されたのは、凄腕 Rubyist の方々が名を連ねる部署でした。その部署での業務から、脱初心者・ OSS 貢献の第一歩として gem パッケージ "randexp-multibyte" を公開するに至るまでの道のりを解説します。

## 自己紹介

初めまして。 @deme0607 こと清水直樹と申します。
今回は私が Rubyist のひしめく環境に身を置いてから gem パッケージを公開するに至るまでの道のりについての記事ですので、まずは簡単に自己紹介をさせていただきたいと思います。

### 学生時代

まずは私が「どれぐらい初心者だったのか」をご説明するために、学生時代のお話です。

大学ではプログラミングは授業で C 言語に少し触れる程度で、学部生の 4 年間のほとんどはラグビー部での部活動に費やしていました。
どれぐらいラグビー漬けの生活を送っていたかというと、「清水直樹 スクラム」で[Google検索](https://www.google.co.jp/search?q=%E6%B8%85%E6%B0%B4%E7%9B%B4%E6%A8%B9+%E3%82%B9%E3%82%AF%E3%83%A9%E3%83%A0)するとソフトウェア開発プロセスのスクラムではなく、[ラグビーのスクラム](http://www.kurfc.com/TeamDiary/diary/774)の記事が出てくるほどです。

大学院進学後は画像処理系の研究室で、 C++ を使ったプログラムを書きながらスポーツ映像処理に関する理論やアプリケーションを題材にした研究をしていました。

当時書いていたプログラムは自分以外の人が見たり、使ったりすることはほとんどなく、安定性や保守性・拡張性・再利用性などは無視していた (というか概念そのものが欠如していた) ため、ソフトウェアエンジニアとしてのコーディングは全くと言って良いほどできていませんでした。

大学の情報系研究室でのプログラミングと、ソフトウェアエンジニアとしてのプログラミングのギャップについてはそれだけで 1 つの記事が書けてしまうほどの分量があるため、また別の機会で詳しく書きたいと思っていますが、一言で言うと私は「プログラミング経験はあるが、超初心者エンジニア」という状態で新卒エンジニアとして社会人になりました。

### 今やっていること

現在は株式会社ディー・エヌ・エー (DeNA) のプラットフォーム本部システム部 SWET グループという部署で Mobage プラットフォームの品質担保及び向上に関する業務に携わっております。

主な業務の 1 つとして、ゲームデベロッパーの皆様が利用する[Mobage Developers Japan](http://developer.dena.jp/mbga/)の自動システムテストを実装しています。 SWET では Web アプリケーションの自動システムテストには

* Ruby
* RSpec
* Selenium WebDriver
* Capybara


の組み合わせを採用しているため、業務では主に Ruby を使っています。

### SWET とは？

私が所属している部署名にもなっている SWET とは、"Software Engineer in Test"の略称です。
少しでも早く、ユーザの皆様に満足していただける品質のプロダクトをリリースしていくため、従来の開発 (エンジニア) ・ QA (テスター) 分断方式ではなく、

* エンジニアがテストをする
* エンジニアがテストに関する生産活動を行う


というアプローチをとるために生まれた組織です。
SWET について詳しくは [Developers Summit 2014 13-A-6 レポート](http://codezine.jp/article/detail/7666)で紹介されています。

## DeNA への入社・ SWET への配属

### 入社・新卒エンジニア研修

大学院を修了後、2013 年 4 月に DeNA にエンジニアとして入社しました。
新卒エンジニアは私と同様エンジニア経験のない社員が多く、入社後はワークショップ形式の新卒エンジニア研修で Web アプリケーション開発をゼロから学びました。

私が受けた新卒エンジニア研修については当時の講師であった [@ryopeko さんのブログ](http://ryopeko.hatenablog.com/entry/2014/02/13/225714)や [Developers Summit 2014 13-A-4 レポート](http://codezine.jp/article/detail/7663)に詳しく取り上げられているため、ぜひ御覧ください。

### SWET という環境

無事に研修を卒業し、前述の SWET グループに配属となりました。 DeNA は Perl がメインの会社ではありますが、 SWET グループには Ruby コミッターの @shyouhei さんや、書籍「パーフェクト Ruby 」の著者の一人で、新卒研修講師のミッションを終えた @ryopeko さんなど、凄腕 Rubyist の方々が大勢おります。
この SWET という環境で、私の Rubyist 人生がスタートしました。

## 脱初心者・ハッカーへの第一歩: gem パッケージ公開

### 業務で困っていたこと

SWET に所属する私のメインの業務の 1 つはテストを書くことです。
SWET として書くテストは各コンポーネントの開発者が作成するユニットテストではカバーしきれない領域を検証する、 E2E (End to End) のテストが主になります。

例えば「パートナーゲームデベロッパーの方が Mobage Developers サイトでゲームを新規に作成し、そのゲームをユーザに向けて公開する」といったシナリオの全てを自動化し、テストとして実行します。

代表的なテストケースとして、「フォームから入力し保存したゲームのタイトルが、正しく反映されていること」というようなものが挙げられます。

上記テストケースを Capybara と RSpec を使用した擬似コードで表すと、以下のようになります。

```ruby
require "spec_helper"
require "randexp"

describe "Game Title" do
  context "when input valiid value" do
     before :all do
       @input_value = /\w{15}/.gen #randexp でランダムに生成
       edit_game_info(:game_title => @input_value)
     end

     it "is shown in game info" do
       expect(game_info[:title]).to eq(@input_value)
     end
  end
end


```

Mobage Developers に何らかのリリースが入る度、上記のようなテストケース群から成るリグレッションテストを実行しており一定の効果を上げられていたのですが、ある問題に関してはこのリグレッションテストでは検知できないという懸念がありました。

それは、「マルチバイト文字列の文字化け」です。

上記のテストコードでは [randexp](http://rubygems.org/gems/randexp) を用いて入力する文字列をランダムに生成しています。上記の例のゲームタイトルは本来は漢字やひらがななどのマルチバイト文字も入力することができるのですが、 randexp で生成される文字列は英数字のみのため、マルチバイト文字を入力して保存した際、表示される文字列が文字化けを起こしてしまうようなデグレが発生しても検出できないのです。

### 脱初心者に必要なこと

業務で困っていたことは上記の通りなのですが、もう一つ困っていたことがありました。 SWET の凄腕 Rubyist の方々の実力を目の当たりにして、どのようにしてその人たちに追いつき、追い越せばよいかのイメージが湧かない、ということです。

しばらくは上記の悩みを抱えながらの日々が続いておりましたが、私の上司でもある [@ikasam_a](http://ikasama.hateblo.jp/) さんから今回の記事を執筆するきっかけにもなったアドバイスをいただきました。

それは「業務外のエンジニア活動にも積極的に取り組む」ということです。

できるエンジニアに近づくために今の私に足りていないのは、業務に直接関係ない活動 (勉強会・コーディング etc) での成長であり、そういった成長があるからこそ、業務でも大きな活躍ができるのだという指摘でした。

私自身エンジニア経験が非常に浅いということもあり、業務外でのエンジニア活動はしていきたいとは思っていたものの、なかなか実行には移せないでいるといった状態でしたが、この @ikasam_a さんのアドバイスで私に足らないものは何か、今すべきことは何かをはっきりと知ることができました。

### 自分で gem パッケージを作って解決しよう

上記のきっかけから、真っ先に思い浮かんだのが前述の「業務で困っていたこと」を解決するような gem パッケージを作って公開してしまおう、ということでした。

正確には業務で感じた課題点を解決するための gem パッケージになるため、完全に業務外のエンジニア活動とは言えないのかもしれません。

しかしこの課題は自分だけではなく社内外多くの方々に影響するものであり、その解決には大きな意味があると感じたため、脱初心者そして凄腕 Rubyist への第一歩として gem パッケージ "randexp-multibyte" の作成に取り掛かりました。

## 今回作成した gem: "randexp-multibyte"

ここでは前述の「マルチバイト文字のランダム文字列を生成できない」という課題を解決するために作成した [randexp-multibyte](https://rubygems.org/gems/randexp-multibyte)について簡単にご紹介します。

### 既存の gem パッケージでできること・できないこと

「業務で困っていたこと」に記述したテストコードにあるように、これまではテスト用のランダムな入力パラメータの生成には [randexp](http://rubygems.org/gems/randexp)を使用していました。

```ruby
require "randexp"
 
/\w{10}/.gen               #=> "breastwood" 英数字 10 文字から生成された文字列を返す
/[:email:]/.gen            #=> "chint@phasma.example.org" ランダムな文字列から生成されたメールアドレスを返す
/[:phone_number:]{10}/.gen #=> "862-229-5689" ランダムな数字から生成された電話番号を返す


```

重複を許可しない入力パラメータの生成などに非常に便利な gem パッケージなのですが、やはり日本語対応のプロダクトのテスト用途としては日本語文字列のランダム生成ができないことが課題でした。

### "randexp-multibyte" で何ができるか

randexp では補いきれなかった日本語のランダム文字列生成を、 randexp を拡張する形で実装しました。

```ruby
require "randexp-multibyte"

/[:hiragana:]{3}/.gen #=> "けさぎ"    ひらがな 3 文字から生成された文字列を返す
/[:katakana:]{2}/.gen #=> "ドヘ"      カタカナ 2 文字から生成された文字列を返す
/[:kanji:]{5}/.gen    #=> "脈菌握亭村" (常用) 漢字 5 文字から生成された文字列を返す
/[:japanese:]{5}/.gen #=> "シど敷キ飾" 漢字+ひらがな+カタカナ 5 文字から生成された文字列を返す
/\w{7}/.gen           #=> "lapwork"  randexp の機能は継承


```

また、私は韓国向けの [Mobage Developers Korea](https://developer.dena-seoul.kr/) のテストも担当しているため、韓国語の生成にも対応しました。

```ruby
/[:hangeul:]{7}/.gen #=> "콃콿텤헔혓튿혓" ハングル文字 7 文字から生成された文字列を返す
/[:korean:]{5}/.gen  #=> "핫콂쾐컮퍊"    hangeul のエイリアス


```

## gem パッケージの作成・公開

ここでは実際に私が gem パッケージ を作成した手順を解説します。

### gem パッケージの命名規則

コードを書き始める前にまず、 gem パッケージの名前をどうするかを決めなければなりません。 gem パッケージの命名規則に関しては [RubyGems.org のガイド](http://guides.rubygems.org/name-your-gem/)を参考にしました。
こちらでは RubyGems.org に記載されている内容を要約します。

* 単語の区切りにはアンダースコアを使用する
  * 例: multi_json, thread_safe
* 既存の gem パッケージの拡張にはダッシュを使う
  * 例: rack-test, net-http-persistent
  * 今回作成した gem パッケージは既存の randexp を拡張するものであるため、 randexp-multibyte としました
  * ディレクトリ構成は"-"を"/"に置き換えたもの
    * net-http-persistent =&gt; net/http/persistent
  * メインのクラス名は"-"を"::"に置き換えたもの
    * rack-test =&gt; Rack::Test
  * 他の言語のモジュール・ライブラリの Ruby 版もこちらの命名規則を使うことが多い
    * 例: matlab-ruby, sqllite-ruby
* アンダースコア、ダッシュは混合して使用できる
  * 例: net-http-digest_auth
  * パス: net/http/digest_auth
  * クラス名: Net::HTTP::DigestAuth
* 大文字は使わない
  * OSX や Windows は case-insensitive なため、意図せずプラットフォーム依存なコードを書いてしまうことを避けるためです


Ruby の gem パッケージの名前を見ていると、「名前を見ても何をするモジュールかわからない！」となることが多いです。有名なものだと[nokogiri](https://rubygems.org/gems/nokogiri)や[poltergeist](https://rubygems.org/gems/poltergeist)など、 Rubyist でない人にその働きは全くわかりません。一説によると、 Ruby の普及と Google 検索の普及がほぼ同時期であったため、 googlability を高めるためにユニークな名前の gem が数多く生まれたのだそうです。

私個人としては、可能な限り名前から役割が推測できる gem パッケージ作成を心がけていきたいな、と思っています。

### bundle gem

gem パッケージの名前を決めたら、いよいよ gem パッケージの実装に着手します。
今回は以下の環境で gem パッケージを作成しました。

* OSX Mavericks 10.9.2
* Ruby 2.1.0 (rvm)
* Bundler 1.5.3


まずは Bunlder のコマンドで gem パッケージのひな形を作成します。

{% highlight text %}
{% raw %}
$ bundle gem randexp-multibyte -t
     create  randexp-multibyte/Gemfile
     create  randexp-multibyte/Rakefile
     create  randexp-multibyte/LICENSE.txt
     create  randexp-multibyte/README.md
     create  randexp-multibyte/.gitignore
     create  randexp-multibyte/randexp-multibyte.gemspec
     create  randexp-multibyte/lib/randexp/multibyte.rb
     create  randexp-multibyte/lib/randexp/multibyte/version.rb
     create  randexp-multibyte/.rspec
     create  randexp-multibyte/spec/spec_helper.rb
     create  randexp-multibyte/spec/randexp/multibyte_spec.rb
     create  randexp-multibyte/.travis.yml
Initializing git repo in /Users/shimizu.naoki/hobby/randexp-multibyte
{% endraw %}
{% endhighlight %}


randexp-multibyte の部分は適宜作成する gem パッケージ名に置き換えてください。

上記コマンドで指定している __-t__ オブションは、 rpsec のテストのひな形も同時に生成するものです。
このオプションを指定しない場合は randexp-multibyte/spec ディレクトリや .rspec ファイル、.travis.yml は作成されません。

次に作成したひな形を github に登録しておきます。 [github.com](http://www.github.com) にアクセスしリポジトリを作成後、以下の要領でひな形を push します。

{% highlight text %}
{% raw %}
$ cd randexp-multibyte
$ git commit -am "first commit"
$ git remote add origin git@github.com:{user_name}/randexp-multibyte.git
$ git push -u origin master
{% endraw %}
{% endhighlight %}


github への登録が終われば、 Bundler で生成したひな形を編集して gem パッケージを実装していきます。
まず、 randexp-multibyte.gemspec ファイルを編集します。

```ruby
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'randexp/multibyte/version'

Gem::Specification.new do |spec|
  spec.name          = "randexp-multibyte"
  spec.version       = Randexp::Multibyte::VERSION
  spec.authors       = ["Naoki Shimizu"]
  spec.email         = ["deme0607@gmail.com"]
  #spec.summary      = %q{TODO: Write a short summary. Required.}
  spec.summary       = %q{randexp extension for multibyte characters}
  #spec.description  = %q{TODO: Write a longer description. Optional.}
  spec.description   = %q{randexp extension for multibyte characters}
  #spec.homepage     = ""
  spec.homepage      = "https://github.com/deme0607/randexp-multibyte"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  #追記
  spec.add_dependency "randexp"
end


```

ひとまず TODO の summary と description の項目を埋めれば OK です。 homepage には先ほど登録した github のリポジトリの URL を記入すると良いでしょう。

また、作成する gem パッケージが既存の gem パッケージに依存する場合は __add_dependency__ オプションを追加します。 randexp-multibyte は randexp に依存しているので、

{% highlight text %}
{% raw %}
spec.add_dependency "randexp"
{% endraw %}
{% endhighlight %}


を追記しています。

次にバージョンナンバーの定義です。 lib/randexp/multibyte/version.rb ファイルを編集しバージョンナンバーを記述します。 __bundle gem__ コマンドで作成したひな形は以下のようになっています。

```ruby
module Randexp
  module Multibyte
    VERSION = "0.0.1"
  end
end


```

今回のバージョンナンバーは初期状態の 0.0.1 のままにしてあります。

バージョンナンバーを定義すると、具体的な実装に取り掛かります。 randexp-multibyte は require されると lib/randexp/multibyte.rb が読み込まれます。

あとは通常の Module や Class を実装するのと同じ要領で、 gem パッケージの機能を実装していきます。

```ruby
require "randexp/multibyte/version"
 
module Randexp
  module Multibyte
    # 機能を実現するコード
  end
end


```

Bundler で gem パッケージを作る際の注意点として、 Bundler で生成されるひな形は名前空間が Module として定義されるということが挙げられます。

上記のように randexp/multibyte.rb では Module として Randexp::Multibyte が定義されています。

しかし拡張元の Randexp は Class として定義されているため、 Bundler のひな形ファイルから randexp を require すると Class と Module の Randexp を二重に定義することになるためエラーが発生します。

```ruby
require "randexp/multibyte/version"
require "randexp" # class Randexp
 
module Randexp #=> TypeError: Randexp is not a module
  module Multibyte


```

Bundler には Class による定義のひな形を生成するオプションは現状ないようなので、 Class を定義したい場合は Bundler が生成したファイルの module という記述を class に置換する必要があります。

```ruby
require "randexp/multibyte/version"
require "randexp"
 
class Randexp
  class Multibyte


```

作成中の gem パッケージをローカルで試したい場合は、

{% highlight text %}
{% raw %}
$ bundle install # 依存モジュール (rake など) のインストール
$ bundle exec rake install   # gem パッケージの build と install
{% endraw %}
{% endhighlight %}


を実行すると gem パッケージがビルドされ、インストールされます。

### RubyGems への公開

gem パッケージの機能を満たす実装が済んだら、いよいよ RubyGems.org への公開です。 gem パッケージの公開も、 Bundler の rake タスクで簡単に実行することができます。

まずは [RubyGems.org のサインアップページ](https://rubygems.org/sign_up)でアカウントを作成しておきます。

アカウントを作成後、 gem パッケージを RubyGems.org にアップロードするための API Key を ~/.gem/credentials に登録する必要があります。 RubyGems.org の[プロフィールページ](https://rubygems.org/profile/edit)に API Key が記載されています。 API Key を記述した設定ファイルをダウンロードするための API も用意されているので、今回はそれを利用します。以下のコマンドを実行すると、 ~/.gem/credentials に API Key を登録することができます。

{% highlight text %}
{% raw %}
$ curl -u [ユーザ id] https://rubygems.org/api/v1/api_key.yaml > ~/.gem/credentials; chmod 0600 ~/.gem/credentials
{% endraw %}
{% endhighlight %}


コマンドを実行すると、途中でパスワードを求められるので RubyGems.org で登録したアカウントのパスワードを入力します。また、 Ruby 2.0 以降にバンドルされている RubyGems の 2.0 系は ~/.gem/credentials のパーミッションが 600 でないとエラーになるように変更されているため、パーミッションの変更も同時に行っています。

API Key の登録を終えたら、加えた変更を全て commit した後、

{% highlight text %}
{% raw %}
$ bundle exec rake release
{% endraw %}
{% endhighlight %}


コマンドを実行することで

* 設定したバージョンナンバーでのタグ付け
* gem パッケージのビルド
* github と RubyGems.org への push


が実行されます。

以上で RubyGems への公開が完了しました。

ここまでの作業が完了すると、ついに作成した gem パッケージを全世界に向けて公開したことになりました！

{% highlight text %}
{% raw %}
$ gem install randexp-multibyte
{% endraw %}
{% endhighlight %}


で RubyGems.org から gem パッケージをインストールすることができます。

## "randexp-multibyte"を公開してわかったこと

ここでは初心者 Rubyist が gem パッケージを作成・公開してみて新たにわかったことを記載したいと思います。

### Ruby のバージョン依存

自分で作成した gem パッケージを公開すると、多くの方々がその gem パッケージを利用することになります。
多くの方々が利用するということは、多くの環境でその gem パッケージが動作するということです。

今回の randexp-multibyte は Ruby 2.1.0 の環境で作成し、好調に動作しているように見えていたのですが、ある時「 Ruby 1.9.3 環境では randexp-multibyte がエラーを起こし動作しない」というフィードバックを受けました。

エラーの内容は以下のようなものです。

{% highlight text %}
{% raw %}
$ ruby -v
ruby 1.9.3p484 (2013-11-22 revision 43786) [x86_64-darwin13.0.2]
$  ruby -r randexp-multibyte -e 'p /[:japanese:]/.gen'
/Users/shimizu.naoki/.rvm/rubies/ruby-1.9.3-p484/lib/ruby/site_ruby/1.9.1/rubygems/core_ext/kernel_require.rb:55:in
 `require': /Users/shimizu.naoki/.rvm/gems/ruby-1.9.3-p484/gems/randexp-multibyte-0.0.2/lib/randexp/multibyte/randexp_ext/randgen.rb:5:
 invalid multibyte char (US-ASCII) (SyntaxError)
{% endraw %}
{% endhighlight %}


これは Ruby のバージョン 2.0 未満のデフォルトのスクリプトエンコーディングが US-ASCII であることを考慮していないために発生したバグでした。(バージョン 2.0.0 以降は UTF-8 に変更)

randexp-multibyte には以下のようなコードが含まれていたため、 Ruby 2.0.0 未満で require するとコードに不正な文字列が含まれていると解釈され、エラーとなります。

```ruby
def self.hiragana(options = {})
  length = options[:length] || 1
  length.of { ('ぁ'..'ん').to_a.pick }.join # invalid multibyte char (US-ASCII) 
end


```

こちらのバグは既に修正済みのバージョン 0.0.3 をリリースしました。
修正方法としては

* 該当するファイルに Magic Comment を追記し、スクリプトエンコーディングを UTF-8 にする
* gemspec ファイルの required_ruby_version オプションを指定して対応する Ruby のバージョンを狭める


といった選択肢が考えられますが、 randexp-multibyte は Ruby の新しいバージョン固有の機能を使用しているわけではなく、今回のバグはスクリプトエンコーディング指定の問題に過ぎないため、 Magic Comment を追記する方法を採用しました。

今回の経験で、多くの方が使用するようなコードを書く際は、

* 使用する言語のバージョン
* 動作するプラットフォーム


なども考慮に入れて設計・実装を行うことが重要であるという気付きを得ることができました。

また randexp-multibyte では未導入ですが、[Travis CI](https://travis-ci.org/) を gem パッケージのリポジトリに仕掛けておくと github に push される度に Ruby の各バージョンでテストを実行する、といったことも可能です。

### 新たな機能要望

コードが多くの方の目に触れることで、多くの機能要望をいただくことができました。

当初から実装したいと考えていたが、手が回らず実装できていない機能もあれば、自分では思いもよらなかったような要望もあります。

特に私自身と似た業務に携わっている SWET の方々からはテストの考え方に根ざしたフィードバックを数多く得ることができ、 gem パッケージを作成する Rubyist としての技術だけでなく、「どういったテストが効果的で、そのテストを実行するにあたり理想的な gem パッケージはどのようなものか」といった知見も得ることができました。

### その他、 gem パッケージを公開することで得たもの

上述のチュートリアルをご覧になるとわかるのですが、 gem パッケージの公開というのは本当に簡単です。
誰でも簡単に公開できてしまうので、世に出ている gem パッケージは決して完璧なものではありません。
私のような超初心者が書いた gem パッケージも少なくありません。

だからこそ、普段使用している gem パッケージも単なるブラックボックスとしておくのではなく、何らかの問題が含まれている可能性を常に意識しておくという感覚を身につけることができました。

そして何より、これは gem パッケージだけに限らず OSS 全てに言えることではありますが、「コードを公開してしまうと後にはひけなくなる」ということはスキルアップ・脱初心者に向けて非常に大きな意味があると思います。

## まとめ

### randexp-multibyte の今後

上記「新たな機能要望」にもある通り、皆様の目に触れるようにしたことで多くの改善点・新機能の要望が見えてきました。直近で取り組む予定の新機能として、「多言語対応に向けた設計の見直し」と「文字コードの境界値を突ける仕組みの追加」があります。

特に後者の「文字コードのエッジケースを突ける仕組みの追加」に関しては、普段からテストに深く関わっておられる SWET の方々から得られた非常に重要なフィードバックです。

プロダクトの文字化け問題に悩まされた経験のある方ならご存じかもしれませんが、文字化けが起こるのは「JIS X 0213 には定義されているが JIS X 0208 には定義されていない文字」といったような、文字コード上のエッジケースであることがほとんどです。

しかし randexp-multibyte では漢字とハングルは定義ファイルにベタ書きしたものからランダムに取得するという非常に原始的な作りになっています。

このような設計では文字化け問題を未然に防ぐテストを書く (文字コードのエッジケースを突く文字列を生成する) ことはできません。

「ひとまずランダムな文字列を生成できるようになった」にすぎない randexp-multibyte を、こういった多言語対応アプリケーションも文字化け対策に広く利用できるようにするため、利用者が文字コードのエッジケースを突いた文字列を生成できるような機能を追加したいと考えています。

## 最後に

この度は SWET の先輩 Rubyist の方々のご協力のもと、私のような初心者 Rubyist がるびまの記事を執筆することができました。 randexp-multibyte の改善はもちろんですが、凄腕 Rubyist の方々に囲まれた今の環境を 120% 活用し、業務内外問わず Ruby 界、そしてインターネット全体のお役に立てるようなコードをどんどん書いていきます。

次にるびまに記事を寄稿させていただく際には、初心者 Rubyist としてではなく、凄腕の Rubyist として成長した姿をご報告できればと思います。


