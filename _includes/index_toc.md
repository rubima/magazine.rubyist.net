{% comment %}
このファイルを各号の表紙の原稿から include して各号目次を生成します。

各号の表紙の原稿のフロントマターに articles_in_volume キーの配列として、下記のような一覧を記載します。この例では号数を 9999 としています。

articles_in_volume:
- id: /articles/9999/9999-Liquid-on-Jekyll
  title: Liquid タグを使ってみた
  authors: liquid さん
  comment: るびまで Jekyll の Liquid タグを勉強する記事です。(難易度：例)
- url: https://www.example.com
  title: 例示用のサイト
  comment: 目次に例示用のサイトを含める例です。

対象の記事がこのレポトリにある場合、
- id キーで記事の ID (原稿のファイルのパスから日付部分を除いたもの) を指定します (必須)
- title キーで目次に使用するタイトルを指定します。指定されていない場合は対象の原稿のフロントマターの title キーを利用します
- authors キーで目次に表示する著者リストを指定します。指定されていない場合は対象の原稿のフロントマターの post_author に日本語の名前が「, 」区切りで列挙されているとして、それぞれの名前に「さん」を追加します。アルファベットの名前の場合は空白を含めて「 さん」を追加して、巻頭言のように「さん」が不要な場合には表紙の原稿のフロントマターで指定してください
- comment キーがある場合は目次に表示します

対象の記事が外部のサイトの場合、
- url キーでURLを指定します (必須)
- title キーで目次に使用するタイトルを指定します (必須)
- authors キーがある場合は目次に表示します
- comment キーがある場合は目次に表示します

対象の記事の ID に号数が含まれる場合は、_includes/sidebar.html によってその記事のサイドバーにその号の目次が表示されます。/articles/first_step_ruby/FirstStepRuby などには表示されません。

{% endcomment %}
{% for x in page.articles_in_volume %}

{%   if x.id # idで指定された記事がこのレポジトリにある場合 %}
{%     assign target = site.posts | find: "id", x.id %}
{%     if target %}
{%       if x.title %}
{%         assign title = x.title %}
{%       else %}
{%         assign title = target.title %}
{%       endif %}
{%       if x.authors %}
{%         assign authors = x.authors %}
{%       else %}
{%         if target.post_author %}
{%           assign authors = target.post_author | replace: ", ", " さん, " | append: " さん" %}
{%         else %}
{%           assign authors = nil %}
{%         endif %}
{%       endif %}
### ![title_mark.gif]({{ base }}{{ site.baseurl }}/images/title_mark.gif) [{{ title }}]({{ base }}{{ target.url }})
{%     else %}
### ![title_mark.gif]({{ base }}{{ site.baseurl }}/images/title_mark.gif) 目次の articles_in_volume に問題があります
id が {{ x.id }} の記事がありません…
{%     endif %}

{%   else # 記事が外部サイトにありurlで指定されている場合 %}
{%     if x.authors %}
{%       assign authors = x.authors %}
{%     else %}
{%       assign authors = nil %}
{%     endif %}
### ![title_mark.gif]({{ base }}{{ site.baseurl }}/images/title_mark.gif) [{{ x.title }}]({{ x.url }})
{%   endif %}

{%   if authors %}
書いた人：{{ authors }}
{%   endif %}

{%   if x.comment %}
{{ x.comment }}
{%   endif %}

{% endfor %}
