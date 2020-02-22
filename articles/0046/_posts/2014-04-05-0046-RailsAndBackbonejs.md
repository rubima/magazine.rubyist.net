---
layout: post
title: Backbone.js on Rails 始めの一歩
short_title: Backbone.js on Rails 始めの一歩
created_on: 2014-04-05
tags: 0046 RailsAndBackbonejs
---
{% include base.html %}


* Table of content
{:toc}


書いた人: joker1007 ([@joker1007](https://twitter.com/joker1007))

## はじめに

るびまへの記事リクエストで Backbone.js と Rails についての記事が読んでみたい、という話がありました。
どちらもそれなりに利用した経験があるので、今回記事を書かせていただくことになった @joker1007 です。

今回は、 Backbone.js の簡単な紹介と、 Rails で利用するための環境の整え方、そして Backbone.js の基本的な書き方について、紹介していきます。

また、サンプルとして簡単な CRUD アプリにちょっと機能を追加したアプリケーションを用意しておきました。実装サンプルが見てみたい方は参考にしてみてください。

[joker1007/simple_note](https://github.com/joker1007/simple_note/)

## Backbone.js について

最初に、 Backbone.js について簡単に説明します。 Backbone.js は JavaScript をより良く構造化するためのフレームワークです。基本的な考え方は MVC をベースにしていると言われていますが、 Rails 等のサーバーサイドフレームワークにおける MVC とは少し勝手が違います。どちらかというと GUI アプリケーションの考え方に近いと言えるのではないかと思います。

Backbone.js の特徴は、非常にシンプルであることです。最近は、 JavaScript のフレームワークが数多く登場しており、 Angular.js や Ember.js 等も注目を集めていますが、 Backbone.js は Angular.js や Ember.js 等に比べて、それ自体が提供する機能がとてもコンパクトです。そのため、 Backbone.js は単体で利用すると、自分自身でイベントバインディングを定義したりビューの切り替えを制御する処理を実装しなければならない機会が沢山あります。しかし、一方ではこういった Backbone.js のコンパクトさは、ブラックボックスが少ないという利点でもあります。自分の理解していない所で勝手に色々な処理が進むことがありません。また本体のソースコード自体も非常にコンパクトで、 JavaScript に慣れた人なら半日もかからずに全てを読み切ることができるでしょう。

こういったシンプルさから、 Backbone.js は初期学習コストが低く済むため、 JavaScript のフレームワークの概要を掴むための入口として最適なフレームワークだと思います。

### Backbone.js の構成要素

Backbone.js の基本的な構成要素は以下の通りです。

| コンポーネント   | 役割|
|---|---|
|  Model/Collection |  サーバーとの通信や、 LocalStorage とのデータのやり取り、データに関するロジックを扱う |
|  View             | DOM で発生したイベントのハンドリングを行ったり、テンプレートエンジンにレンダリングに必要なデータを受け渡す等の処理を行う。 |
|  Router           |  URL の変更を検知して何らかの処理をディスパッチする|


テンプレートエンジンは用意されていないため、好きなものを利用します。

Backbone.js の各構成要素の役割を Rails における MVC の役割と無理矢理対応付けると、以下のような形になります。

| Backbone.js         |  Rails      |
|  Model/Collection |  Model    |
|  Template         |  View       |
|  View             |  Controller |


Model/Collection や Template の役割は、 Rails とそれ程変わりませんが、 Backbone.js における View は Rails のそれとは少し違ったものです。

名前から誤解を生みそうですが、 Backbone.js における View は Rails における Controller に近いポジションです。 Backbone.js では View はモデルへの参照を持っており、ユーザーの操作によるイベントの発生をモデルに対して伝える橋渡しの役割も果たします。テンプレートのレンダリングを指示するのも View の仕事です。

そして、利用用途に依りますが、 Backbone.js では比較的 View に書くコード量が多くなる傾向にあります。何故なら JavaScript が活用されるポイントの多くは、ユーザーの操作に対応して DOM を変化させる事だからです。

それでは、 Backbone.js の概要と構成要素についての説明はこのぐらいにして、 Rails で実際に Backbone.js を利用するにはどうすれば良いのかを見ていきましょう。

### Rails アプリに Backbone.js を導入するいくつかの方法

Rails アプリケーションに JavaScript ライブラリを導入する方法はいくつかあります。

1. ダウンロードして vendor / assets 以下に直接配置する
1. JavaScript ライブラリが組み込まれた gem を探して導入する
1. bower 等の JavaScript ライブラリ管理ツールを利用する
1. rails-assets.org を利用して、 bower パッケージを gem としてインストールする


Backbone.js を組込んだ gem はいくつかありますが、代表的なのは [rails-backbone](https://github.com/codebrew/backbone-rails) と [backbone-on-rails](https://github.com/meleyal/backbone-on-rails) です。
rails-backbone は GitHub のプロジェクト名としては backbone-rails です。ちなみに gem の名前として backbone-rails を指定してインストールすると違う gem がインストールされてしまいますので注意してください。Backbone.js を利用するだけなら大して差は無いのですが、微妙にバージョンや同梱されているものに差異があります。

私が最近活用しているのは 4 の rails-assets.org の利用です。主な理由は以下の四つです。

* ライブラリのバージョンアップが容易である
* 依存関係が自動的に解決される
* 余計なものがインストールされない
* gem のアップデートサイクルに縛られずに済む


JavaScript ライブラリのバージョンアップにどうやって追従するか、というのは中々悩ましい問題です。最近は、 bower の登場によりかなり楽になってきました。しかし、できるだけ Rails のエコシステムだけで完結してくれる方が Rails 開発者にとっては楽です。その折衷案として rails-assets.org を利用するのは、今の所中々良いのではないかと感じています。

というわけで、今回は rails-assets を利用して Backbone.js を Rails アプリケーションに組み込んでみましょう。 Rails プロジェクトの Gemfile を以下のように編集します。

{% highlight text %}
{% raw %}
source 'https://rubygems.org'
source 'https://rails-assets.org'  # rails-assets.org を source として指定しておく

# .. 省略 ..

# rails-assets
gem 'rails-assets-lodash'
gem 'rails-assets-backbone'
{% endraw %}
{% endhighlight %}


bundle install を行えば、 JavaScript のライブラリが gem としてインストールされます。
lodash というライブラリも一緒にインストールしていますが、これは underscore.js の代替となるライブラリです。 underscore.js と互換性があり、更に多機能化、高速化された実装になっています。 Backbone.js は underscore.js に依存しているのですが、 lodash も利用できます。今回はこちらを利用してみます。

インストールが完了したら、アセットパイプラインのマニフェストファイルを編集します。

{% highlight text %}
{% raw %}
//= require jquery
//= require jquery_ujs
//= require lodash
//= require backbone
//= require_tree .
{% endraw %}
{% endhighlight %}


これで Rails アプリケーション内で Backbone.js を利用できるようになります。

## サンプルアプリの解説

冒頭で紹介しましたが、 Backbone.js を利用した簡単なアプリケーションを用意しました。 markdown を即座にプレビューしながら編集できるメモアプリケーションです。
このアプリケーションを元に Backbone.js でアプリケーションを書くとどんな感じになるのかを解説していきます。
Heroku にホストしているので、どういった動作をするか確認したい方は[こちら](http://simple-note.herokuapp.com/)を見てください。

全てを解説すると余りに長くなってしまうので、要所に絞って解説していきます。 Backbone.js コンポーネントのメソッドの詳細については、分量もそれ程多くないため、ここで解説するよりも、公式のリファレンスとソースコードを読むのが最も良い資料になります。

Backbone.js の API リファレンスは[こちら](http://backbonejs.org/)

### Rails 側の実装

今回は、 Rails 側はほぼ API サーバーとしての役割だけを担っています。 json を返すレスポンスは scaffold で作成した jbuilder テンプレートに任せています。 html テンプレートはレイアウトだけを描画し、何も返していません。ブラウザに表示する内容も含めて、全て JavaScript で処理しています。

Rails 側で実装したのは、 markdown をパースした結果の html を返す API だけです。

{% highlight text %}
{% raw %}
# app/controllers/notes_controller.rb:17
def rendering
  @note = Note.new do |n|
    n.raw_body = params[:raw_body]
  end
end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
# app/views/notes/rendering.json.jbuilder
json.body @note.render_markdown
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
# app/models/note.rb:19
def render_markdown
  markdown_processor.render(raw_body)
end

private
def update_body_by_render_markdown
  self.body = render_markdown
end

def markdown_processor
  @markdown_processor ||= Redcarpet::Markdown.new(
    Redcarpet::Render::HTML.new(
      filter_html:  true,
      hard_wrap:    true,
    ),
    autolink:            true,
    tables:              true,
    underline:           true,
    highlight:           true,
    fenced_code_blocks:  true,
  )
end
{% endraw %}
{% endhighlight %}


### Backbone.js 側のモデルの実装

Backbone.js 側の実装を見ていきましょう。まずはシンプルなモデルからです。

モデルの主な仕事はサーバーサイドとの通信です。今回のアプリケーションだと一覧の取得と、サーバーサイドにデータを永続化すること、そして保持している markdown を元に html のレンダリングをサーバーサイドに依頼し、結果を受け取ることです。

{% highlight text %}
{% raw %}
s = @SimpleNote
s.Models ?= {}

s.Models.Note = Backbone.Model.extend
  urlRoot: '/notes'

  initialize: ->
    @listenTo @, 'change:raw_body', _.debounce =>
      @renderBody()
    , 300

  previewText: (length = 140) ->
    @get("raw_body")?.substring(0, length)

  renderBody: ->
    $.ajax("/notes/rendering", 
      type: "POST"
      dataType: 'json'
      data: {raw_body: @get('raw_body')}
    ).done (data) =>
      @set('body', data.body)

s.Collections.NoteCollection = Backbone.Collection.extend
  model: s.Models.Note
  url: '/notes'
{% endraw %}
{% endhighlight %}


Backbone.js のモデルはサーバーサイドに対する基本的な CRUD 操作の機能を既に用意してくれているため、基本的な処理はエンドポイントとなる URL を定義するだけで完了します。

markdown のレンダリングをサーバーサイドに依頼する部分が Note クラスの実装のメインです。といっても、単純に ajax でリクエストを送って、結果を body 属性に格納しているだけです。

そして、コンストラクタでメモ内容の本文が更新されたら、 300ms 待ってからサーバーに自動でリクエストを送るようにイベントハンドラを定義しています。 debounce でラップしているのは、高速で値が変化した時にリクエストが重複されないための工夫です。

### Backbone.js 側のビューの実装

Backbone.js のビューを考える時に重要なのは、入れ子の構造を意識する事です。例えばノートの一覧を表示する画面には、ノートの集合を扱うビューがあり、その中に一つ一つのノートに対応したビューがある、という感じです。

サンプルアプリケーションのノートの一覧を表示するためのビューの実装を見てみましょう。

{% highlight text %}
{% raw %}
# app/assets/javascripts/views/notes/index_view.js.coffee
s = @SimpleNote
s.Views.Notes ?= {}

s.Views.Notes.IndexView = Backbone.View.extend
  template: JST['notes/index']

  events:
    'click a.new-note-btn' : 'navigateToNewNote'

  initialize: (@options) ->
    @listenTo @collection, "reset", =>
      @render()

  render: ->
    @$el.html(@template())
    @collection.each (note) =>
      view = new s.Views.Notes.IndexItemView(model: note)
      @$(".notes").append(view.render().el)
    @$("#note-menu")
    this

  navigateToNewNote: ->
    Backbone.history.navigate('notes/new', true)
{% endraw %}
{% endhighlight %}


こちらはコレクションに対する描画を行うビューです。このビューのレンダリングを行う中で、個別のノートに対応したビューを構築しそれぞれをレンダリングして自身の管理している DOM の中に追加しています。

ポイントは、 initialize メソッドの中で実行している listenTo メソッドです。与えられたコレクションオブジェクトが再同期されたら、 render を再度実行するようにイベントハンドラを定義しています。

このようにモデルやコレクションに変化が発生した時に適切にビューを更新するために、各操作に連動してトリガーされるイベントを経由して処理を実行するのが、 Backbone.js の基本的な考え方になります。

続いて、個別のノートに対応したビューを見てみましょう。

{% highlight text %}
{% raw %}
# app/assets/javascripts/views/notes/index_item_view.js.coffee
s = @SimpleNote
s.Views.Notes ?= {}

s.Views.Notes.IndexItemView = Backbone.View.extend
  tagName: 'li'
  id: -> "note-#{@model.id}"
  className: 'note'
  template: JST['notes/index_item']

  events:
    'click .note-title' : 'navigateToNote'
    'click .delete-note' : 'deleteNote'

  initialize: ->
    @listenTo @model, 'destroy', =>
      @remove()

  render: ->
    context = @model.toJSON()
    _.extend(context, previewText: @model.previewText())
    @$el.html(@template(context))
    this

  navigateToNote: (e) ->
    e.preventDefault()
    Backbone.history.navigate("notes/#{@model.id}", true)

  deleteNote: (e) ->
    e.preventDefault()
    if confirm('ノートを削除しますか？')
      @model.destroy()
{% endraw %}
{% endhighlight %}


こちらのポイントはテンプレートを使った描画とユーザーの操作に対するイベントハンドラの定義です。

このアプリケーションでは JavaScript で利用するテンプレートに Sprockets によってコンパイルされる JST を利用しています。このテンプレートに対して、描画に必要な情報をシリアライズして渡す事で、描画を行っています。

Backbone.js のビューでは、 events プロパティにオブジェクトを渡すことで、ユーザーの操作で発生するイベントに対するハンドラを定義します。キーがイベント名と DOM のセレクタを指定し、値がハンドラメソッドの名前を指定します。このイベントがキャッチされるのは、 this.el に含まれる DOM に対してだけです。

またモデルが削除された時に、ノートの描画を画面から削除するためのイベントハンドラも定義されています。

### データバインディング

JavaScript のフレームワークではビュー側で行われた変更とモデル側で行われた変更を上手く同期させる事がとても重要です。この同期処理が必要になるケースは頻繁に存在します。 Angular.js や Ember.js はフレームワーク自体が、そのための機能を提供していますが、 Backbone.js にはそういった機能は組み込まれていません。そこで Backbone.js を利用する場合は、 Backbone.js を拡張するライブラリを利用します。データバインディングのためのライブラリで良く利用されているのが[backbone.stickit](http://nytimes.github.io/backbone.stickit/)です。

backbone.stickit を利用することで、ユーザーがフォームに入力したデータをモデルに反映させたり、逆にモデルが変更された時にビューの描画を即座に更新する、といった処理が簡単に定義できるようになります。ノートの入力フォームを表示しているビューの実装を見てみましょう。

{% highlight text %}
{% raw %}
# app/assets/javascripts/views/notes/note_view.js.coffee
s = @SimpleNote
s.Views.Notes ?= {}

s.Views.Notes.NoteView = Backbone.View.extend
  className: 'new-note'
  template: JST['notes/note']

  events:
    'click .submit-note-form' : 'submit'
    'click .back' : 'navigateToNoteIndex'

  bindings:
    '#input-note-title' : 'title'
    '#input-note-raw_body' : 'raw_body'

  render: ->
    @listenTo @model, 'sync', _.bind(@_onModelSynced, @)
    @listenTo @model, 'error', _.bind(@_onModelErrored, @)

    @$el.html(@template(@model.toJSON()))
    preview = new s.Views.Notes.PreviewView(model: @model, el: @$('.preview-col'))
    preview.render()
    @stickit()
    this

  submit: (e) ->
    e.preventDefault()
    @trigger('clickSubmit')

  navigateToNoteIndex: (e) ->
    e.preventDefault()
    Backbone.history.navigate('notes', true)

  _onModelSynced: ->
    @$('.submit-note-form').notify("Success!", className: 'success', position: "right")

  _onModelErrored: ->
    @$('.submit-note-form').notify("Error!", className: 'error', position: "right")
{% endraw %}
{% endhighlight %}


bindings プロパティの定義に注目してみてください。オブジェクトを返すようになっています。キーが入力フィールドのセレクタ、値が対応するモデルの属性名です。そして、 render メソッドの最後で実行している stickit メソッドで bindings の定義を有効化しています。

これだけで、#input-note-title が示す入力フィールドに入力された値がモデルの title 属性に即座に反映されるようになります。また逆も然りです。

stickit メソッドの呼び出しを忘れると、バインディングのためのイベントハンドラが定義されないので注意してください。

この様にフォームと組み合わせて利用するのが典型的ですが、 PreviewView によるタイトルの表示で利用しているように実際にはフォームに関わらず利用する事ができます。

{% highlight text %}
{% raw %}
s = @SimpleNote
s.Views.Notes ?= {}

s.Views.Notes.PreviewView = Backbone.View.extend
  template: JST['notes/preview']

  bindings:
    '#note-title' : 'title'

  initialize: ->
    @listenTo @model, 'change:body', _.bind(@_updatePreview, @)

  render: ->
    @$el.html(@template(@model.toJSON()))
    @_updatePreview()
    @stickit()

  _updatePreview: ->
    @$('#note-body').html(@model.get("body"))
    @$("code").each (i, e) ->
      hljs.highlightBlock(e)
{% endraw %}
{% endhighlight %}


### ルーターによるディスパッチ

これまでに定義してきたビューを画面に描画するためのディスパッチ処理を行っているルーターについても知っておきましょう。

ディスパッチにおいて重要なのは、 JS の読み込みとアプリケーションの起動を分けておくことです。そうしておかないと、 JavaScript の単体テストのコードを書くのが非常に難しくなってしまいます。

Backbone.js のルーターは URL のパターンを定義し、それにマッチする URL であれば定義してあるメソッドを呼び出す仕組みになっています。ルーターは定義しただけでは動作しません。ルーターを実際に利用するには、ルーターのインスタンスを作成してから_Backbone.history.start ()_;を実行します。

URL を JS から遷移させたい時は、_Backbone.history.navigate_を呼び出します。イベントをトリガーするかどうかは、オプションで指定できます。

{% highlight text %}
{% raw %}
# app/assets/javascripts/routers/note_router.js.coffee
s = @SimpleNote
s.Routers ?= {}

s.Routers.NoteRouter = Backbone.Router.extend
  routes:
    "notes/new" : "newNote"
    "notes/:id" : "showNote"
    "notes" : "indexNotes"
    ".*" : "indexNotes"

  initialize: (options) ->
    @layout = new s.Views.LayoutView(el: $("body"))
    @notes = new s.Collections.NoteCollection()

  indexNotes: ->
    indexView = new s.Views.Notes.IndexView(collection: @notes)
    @layout.setView(indexView)

    @notes.fetch(reset: true)

  newNote: ->
    @note = new s.Models.Note()
    @__renderNoteView()
    @listenTo @note, 'sync', =>
      @navigate("notes", true)

  showNote: (id) ->
    @note = @notes.get(id)
    if @note
      @__renderNoteView()
    else
      @note = new s.Models.Note(id: id)
      @note.fetch
        success: => @__renderNoteView()

  __renderNoteView: ->
    noteView = new s.Views.Notes.NoteView(model: @note)
    @layout.setView(noteView)
    @listenTo @currentView, 'clickSubmit', =>
      @note.save()
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
# app/assets/javascripts/simple_note.js.coffee
window.SimpleNote =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @router = new SimpleNote.Routers.NoteRouter()
    Backbone.history.start(pushState: true)
{% endraw %}
{% endhighlight %}


pushState API に対応しているブラウザであれば、 URL のパス部分を直接利用してマッチするかどうかを判別できます。 pushState を利用しない場合は、 URL の末尾にハッシュを付与して、ハッシュ部分にパスを擬似的に設定しマッチするかどうかの処理に利用します。

今回は簡単なアプリケーションなので、 pushState を前提にしていますが、古い IE 等に対応しなければならない場合は、 pushState が利用できなくても適切にディスパッチが行われるように工夫する必要があります。

Rails と組み合わせる場合、 pushState が利用できないと、ブラウザのリロードが発生した時に、実行されるアクションが固定されてしまうので、どういったアクセスパターンがあるかを考え、ディスパッチの動作を設計しなければいけません。

例えば、パフォーマンスにこだわる場合は、 Rails に対してアクセスが来た際に、その URL に対応したリソースを JSON にシリアライズした値を直接テンプレートに埋め込んで、 JavaScript のディスパッチ処理に渡す場合があります。それによって初回の無駄なリクエストを減らす事ができます。しかし、この場合 URL がどのように遷移しているか、ブラウザのリロードや特定の URL へのダイレクトアクセスに対してどのように対応するか、を考えておく必要があります。

ちなみに URL を遷移する必要が無く、アプリケーションのエンドポイントが固定できるなら、ルーターを使わずに直接ディスパッチのためのメソッドを呼び出すことも一つの手段です。

## まとめ

Backbone.js を始めとする JavaScript のフレームワークで守っておくべき基本的な事項は、レイヤーの責任を守る、ということです。

ここまでで紹介してきたように、モデルはデータを取り扱い保持すること、そしてサーバーサイドと通信する事等が主な役割です。そしてビューは DOM の操作や DOM で発生したイベントを受け取って処理を行うことがその役割です。

モデルクラスが DOM の要素について知らなければいけなかったり、ビュークラスから直接 ajax の通信が実行されている様な状況になっていると、境界が守れていないサインです。

また、ビュークラスが扱う DOM は el 属性として渡された DOM の内部に限定して処理を行うべきです。でないと、イベントの定義が分散して、どの処理がどこに実装されているかが分からなくなる事に繋がります。ビューの担当範囲についても責任範囲を守ることが大事です。
更に、 el 属性内部にのみ限定して処理を行うようにしておくと、テストコードを記述する際に親になる DOM を用意する必要が無くなり、テストが容易になるというメリットもあります。

各コンポーネントが連携して動作しなければならない場合は、できるだけイベントを拾って処理するのが基本です。イベントを経由する形にすることで、各コンポーネントはお互いの詳細や自身に依存する対象の存在を知る必要が無くなります。

### 本格的に Backbone.js を利用するなら

さっきのアプリケーションではいくつかイケてない部分があります。
例えば、ルータークラス自体が、アプリケーション全体の画面切り替えを兼ねています。簡単なアプリケーションならそこまで見通しに影響はありませんが、複雑なアプリケーションになると、ルータークラスが肥大化する危険性があります。
また、全体の画面を切り替える処理等の様に、汎用的に利用されそうな部分まで色々と自分で実装しなければならないのは少し面倒です。段階的に機能拡張していくと継ぎ接ぎな実装になる危険もあります。

この様に Backbone.js はそのシンプルさ故に、よくある処理を何度も実装する必要があったり、アプリケーションが複雑になると、実装が混乱して上手く構造化できなくなったりする場合があります。

そのため、本格的に Backbone.js を利用してアプリケーションを開発する場合は、 Backbone.js を拡張するライブラリや、 Backbone.js の上に色々な機能を追加した機能強化版のフレームワークを利用するのが良いでしょう。

Backbone.js を基に機能を追加したフレームワークはいくつかありますが、その中でもメジャーなものは以下の二つだと思います。

* Marionette.js
* Chaplin.js


この二つを比べると、 Marionette.js の方がシンプル寄りで、 Chaplin.js の方が多機能です。私は比較的覚える事が少なく、通常の Backbone.js の延長感覚で利用できる Marionette.js を利用しています。

これらのライブラリはコントローラー層を記述するためのコンポーネントを用意してくれていたり、アプリケーションの名前空間を定義して、アプリケーション全体の開始や設定をまとめる場所を用意してくれたり、サーバーサイドでレンダリングされた初期 HTML を利用して画面を切り替えるためのレイアウト機能等を持っています。

こういったフレームワークを利用する事で、より複雑なアプリケーションにも対応できる指針を得ることができるでしょう。

その他にも Backbone.js を拡張するライブラリは大量に存在します。 JavaScript のライブラリ管理ツールである bower で backbone という単語で検索してみましょう。数え切れないぐらいヒットします。気になるライブラリがあったら試してみると良いでしょう。特に以下のライブラリが有名な所だと思います。

* backbone-relational (モデル同士の関連を定義する機能を提供する)
* backbone-validation (モデルの典型的なバリデーションの定義を簡単に行う機能を提供する)
* backbone.stickit (データバインディング)
* backbone.localStorage (localStorage にモデルのデータを保存する)
* backbone.paginator (ビューのページネーション機能を提供する)
* backbone-forms (モデルと紐付いたフォームを生成する)


### Rails 開発における JavaScript のテストについて

最後に、 Backbone.js と直接関係ありませんが、 Rails で JavaScript の単体テストを書くための環境の整え方を紹介しておきましょう。
Backbone.js 等の JavaScript のフレームワークを利用するようになると、 JavaScript の単体テストを書きたくなる機会も増えてくると思います。

Rails で JavaScript を書く時は、アセットパイプラインの機能を利用して CoffeeScript を記述する場合が多いと思います。しかし、 CoffeeScript をそのままテストすることはできないため、一旦アセットパイプラインを通してコンパイルしたものに対して、テストを実行する必要があります。

そういった処理を助けてくれる gem がいくつかあります。

* [teaspoon](https://github.com/modeset/teaspoon)
* [konacha](https://github.com/jfirebaugh/konacha)
* [jasmine-rails](https://github.com/searls/jasmine-rails)


これらの gem は概ね似たような動作をします。実行すると、テスト用に Rails のサーバープロセス自体を立ち上げてアセットパイプラインにアクセスできるようにした上で、ヘッドレスブラウザや Selenium を利用して起動済みのサーバープロセスにアクセスし、そこでテスト用のスクリプトを読み込みます。
また、自分が普段利用しているブラウザからテストを実行するためのエンドポイントも用意してくれます。

ちなみに、 konacha は mocha というテスティングフレームワークと chai というアサーションライブラリを利用します。 jasmine-rails は jasmine を利用します。 teaspoon は mocha と jasmine と qunit を切り替えて利用できます。

最近の私は、比較的フレームワーク選択の自由度が高い teaspoon を利用しています。

今回のサンプルアプリケーションでは teaspoon を利用して記述したテストコードも同梱しているので参考にしてみてください。

## 著者について

### 橋立 友宏 ([@joker1007](https://twitter.com/joker1007))

(株) ウサギィ所属の Rails プログラマー。Rails を利用した中小規模の受託開発を中心に仕事をしている。最近は Rails 以外にも JavaScript や Scala を書く機会が多くなってきた。『[パーフェクト Ruby]({{base}}{% post_url articles/0043/2013-07-31-0043-BookPerfectRuby %})』の著者の一人。


