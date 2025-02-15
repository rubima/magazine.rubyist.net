---
layout: post
title: 日報が面倒なので、RubyとGoogle Geminiを使って生成するツールを作成しました
short_title: Generating Report Tool With Ruby and Gemini
tags: 0065
post_author: ホアンクアン
created_on: 2024 年 10 月 21 日
---
{% include base.html %}

## はじめに

こんにちは。ベトナム人エンジニアのホアンクアンです。

もう5年ぐらい日本で働いているんですが、私にとって、最も面倒なのは... 日報です。もちろん、管理に関する多くの知識と経験がある今、日報の重要性を理解しています。しかし、外国語、特に漢字で日報を書くのに1〜2時間かかることがよくありました。こんなに時間をかけても、結局クレームを付けられてしまった。ですから、SCANDALの「本を読む」曲の歌詞を引用して、私の困ったことを綴ります：

> 漢字も苦手 見たこともない単語が

> ぐるぐるぐる 目が回りそうだ

ですから、日報を書く作業をより簡単にするために、プロジェクトのタスク、進捗状況、明日の予定作業などを取得するだけで、自動的に日報を生成できるようにしたいと考えています。私は Ruby が大好きで、最新の生成AI技術を適用したいと思い、新しいプロジェクトを始めました。

## ツールを開発しよう
### Google Gemini API キーを準備

Google Gemini(旧：Google Bard)は、2023年12月に発表されました。Googleが「最も強力で汎用的なAIモデル」と呼ぶGeminiは、OpenAIのGPT-4など、他の大規模言語モデルを凌駕する多くの能力を備えています。Googleの様々なサービスと連携しているため、ユーザーはより深い知識や情報を簡単に得ることができます。

以前は、OpenAIアカウントを登録するのが難しく、多くの制約があったため、簡単な登録条件のGoogle Bardを使用していました。 GmailアカウントまたはGoogleアカウントがあればすぐに使用できます。 そのため、BardがGeminiになった今でも、これは私のお気に入りの生成AIツールです。

Google Gemini API キーを取得する方法：

- [Google AI Studio](https://aistudio.google.com/app/apikey)にアクセスして, "Create API key in new project"をクリックする。

<img src="{{base}}{{site.baseurl}}/images/2024-10-21-0064-CreateGeneratingReportToolWithRubyAndGoogleGemini/click-to-get-key.webp">

- キーが表示されたら、キーをコピーして.envファイルに貼り付けてください。

<img src="{{base}}{{site.baseurl}}/images/2024-10-21-0064-CreateGeneratingReportToolWithRubyAndGoogleGemini/copy-key.webp">

### Rubyでプログラミングする理由

このようなツールをPython、Javascript、TypeScript、またはシェルスクリプトで書くと、多くのサポートがあり、作業が簡単すぎるという結果になります。私はRubyプログラミング言語が好きで、「RubyはRailsだけではない」ことを証明したいとも思っています。そのため、今回はRubyを言語として選びました。

### `gemini-ai`というgemを使用

`gemini-ai`とは、Vertex AI、Generative Language API、AI Studio、その他のGoogleの生成AIサービスを介してGeminiと対話するためのRuby gemです。
これはgemのGithubです: [https://github.com/gbaptista/gemini-ai](https://github.com/gbaptista/gemini-ai)

gemのドキュメントから、Googleのサービスを呼び出すための様々な方法があります。上記のようにGoogle Gemini APIを取得したから、次のようにコードを書きます:

```ruby
client = Gemini.new(
  credentials: {
    service: 'generative-language-api',
    api_key: ENV['GOOGLE_GEMINI_TOKEN']
  },
  options: { model: 'gemini-pro', server_sent_events: true }
)
```

### プログラミングする

まずはフォルダを作成する必要があります。その中に Gemfile, Gemfile.lock, .gitignore ファイルを入れます。こちらが私のフォルダ構造の画像です。

<img src="{{base}}{{site.baseurl}}/images/2024-10-21-0064-CreateGeneratingReportToolWithRubyAndGoogleGemini/structure.webp">

このプロジェクトでは、.gitignore に GitHub の標準的なテンプレートを使用しています: [https://github.com/github/gitignore/blob/main/Ruby.gitignore](https://github.com/github/gitignore/blob/main/Ruby.gitignore)。そして、このルールを追加します。

```
/result/*
!/result/.keep
/input/*
!/input/.keep
```

`Gemfile`:

```ruby
# frozen_string_literal: true

source 'https://rubygems.org'

gem 'gemini-ai', '~> 4.2.0'
gem 'dotenv'
```

空の`Gemfile.lock`を作って、`bundle install`を実行するのは、環境設定は完了です。

`lib/main.rb`に、必要なgemを呼びます。

```ruby
# frozen_string_literal: true

require 'dotenv/load'
require 'gemini-ai'
```

Geminiのinputを1つ作成します。この入力テキストは、メールテンプレートの部分と、ファイルを読み込む部分の2つの部分で構成されます。

メールテンプレートの部分はこのようなです。

```ruby
text_request = <<-TEXT
この日報フォーマットに情報を追加てください。

"A様

お疲れ様です。ホアンクアンです。

本日の業務内容を報告していたします。

業務内容：
  1. プロジェクト１
    - タスク１：
      進捗状況: %

課題

明日の予定
  1. プロジェクト１
    プロジェクト１の予定

以上、本日の報告とさせていただきます。"
TEXT
```

テンプレートがなかったら、
```ruby
text_request = '日報メールを書いてください。'
```

ファイルを読み込む部分:
```ruby
Dir.glob('./input/*.txt').each do |file_name|
  text_request += File.read(file_name)
end
```

Geminiにinputを入れます。

- テンプレートがある場合。このこと、創造的な結果をもらいたくないですから、`temperature`を設定する。

```ruby
result = client.stream_generate_content({
  contents: { role: 'user', parts: { text: text_request } },
  generationConfig: { temperature: 0 }
})
```

- テンプレートがない場合。このこと、創造的な結果をもらいたいですから、`temperature`を設定しない。

```ruby
result = client.stream_generate_content({
  contents: { role: 'user', parts: { text: text_request } }
})
```

出力結果はデータの形式です。各テキスト部分を抽出したいので、以下を追加する必要があります。

```ruby
mail_template = result
              .map { |response| response.dig('candidates', 0, 'content', 'parts') }
              .map { |parts| parts.map { |part| part['text'] }.join }
              .join

puts mail_template
```

便利になるために、`run.sh`を書く：

```shell
echo "Job starts"
sleep .5
echo "Processing..."
ruby lib/main.rb > result/out.md
echo "Done"
```

### プロジェクトのREADMEを書く

READMEを書くのも面倒なので、AIを使って簡単に生成します。

<img src="{{base}}{{site.baseurl}}/images/2024-10-21-0064-CreateGeneratingReportToolWithRubyAndGoogleGemini/readme.webp">

## 結果

ソースコード： [https://github.com/BlazingRockStorm/genai-daily-report-generator](https://github.com/BlazingRockStorm/genai-daily-report-generator)

### ツールを実行

例ファイルを３つを作成する：

- ファイル#1

```
プロジェクト1：
タスク1： 
進捗状況: 40%

タスク2：
  進捗状況: 30%。

課題/問題ない

タスク2の優先度が高いので、明日このタスク続きます
```

- ファイル#2

```
プロジェクト2：
タスク1： 
進捗状況: 100%

課題/問題ない

プロジェクト完了
```

- ファイル#3

```
プロジェクト３：
　　進捗状況：0%

課題/問題：まだ設計中

明日設計続く
```

実行の結果:

<img src="{{base}}{{site.baseurl}}/images/2024-10-21-0064-CreateGeneratingReportToolWithRubyAndGoogleGemini/result.webp">

結果を見ると、日報として使えると思います。

### 改善目標

- 出力をMarkdownから`.doc`に変更する。
- rspecテストを書く。

## おわりに

このツールのおかげで、プロジェクトをファイルにまとめるのに5分、レポートを作成するのに1分、レビューするのに5分しかかかりませんでした。レポートを書く時間を費やす代わりに、コーディングやインフラなどの知識を学ぶことに集中する時間ができました。

最近、私は [sentiment-ai](https://github.com/BlazingRockStorm/sentiment-ai) というgemを開発しました。これはテキストの感情分析を簡単に行うためのツールです。Rubyが新しい技術、例えば生成AI（GenAI）ともうまく連携できることを示すために、このgemを作成しました。ぜひご覧ください。

最後までお読みいただき、ありがとうございます。

## 筆者について

ホアン・クアン ([@BlazingRockStorm](https://github.com/BlazingRockStorm/))。ベトナムのハノイから出身。5年ぐらい日本に住んでいる。エンジニア、ドラマー・パーカッショニスト、折り紙のインスタグラマー。