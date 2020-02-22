---
layout: post
title: Ruby で暦を研究する
short_title: Ruby で暦を研究する
created_on: 2015-09-06
tags: 0051 FebruaryRectangleWithRuby
---
{% include base.html %}


* Table of content
{:toc}


書いた人 : m.sotta (@swallow_life [Twitter](https://twitter.com/swallow_life) [GitHub](https://github.com/swallow-life))

## はじめに

2015 年 7 月 1 日にうるう秒が挿入され、ニュースに取り上げられていました。
とかく暦に関することは皆に影響するためか関心を集めやすいのかもしれません。
暦といえばちょっと前のことになりますが 2015 年 2 月を覚えていますか？
この月は日曜始まりのカレンダーの場合ちょうど 4 週で収まるめずらしい月でした。

{% highlight text %}
{% raw %}
2015/2
SunMonTueWedThuFriSat
1  2  3  4  5  6  7
8  9  10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
{% endraw %}
{% endhighlight %}


このような 2 月が現れるのは 2009 年以来と言う話が Twitter 上で話題になっており、それを見て私はこの事象に気がつきました。
興味を持って Google で調べてみたところ前回が 2009 年という話は見つけられたのですが、次回がいつ来るのかという話は見つけられませんでした。

見つけられないのであれば自分で探してしまえ、ということで前置きが長くなりましたが、本記事では Ruby を使って、この「2 月が 4 週で収まる事象」の性質を解き明かしていきたいと思います。
ひとまずの目標は、この事象がいかなる法則性で出現するのか解き明かすこと、あるいは、発生に法則性がないことを確認することです。
また、それ以外にも この問題を解きながら何かおもしろい発見があればよいなと思います。

本記事の内容は実生活に全く役に立たないと思いますが、知的エンターテイメントとしてお楽しみいただければ幸いです。

最初に 2 月が 4 週で収まる事象に名前を付けたいと思います。 (かなり呼びづらいので……。)
私はカレンダーの形がちょうど四角くなることから Rectangle February Problem と名付けました[^1]。
本記事では省略して RectFeb 問題としました。

## 最初の調査

さて、まずは Ruby を使ってある年の 2 月が RectFeb かどうかを判定させてみたいと思います。
2015 年と 2009 年を見比べてみると、2 つの月に共通する性質は 2 月 1 日が日曜である、ということがわかります。

{% highlight text %}
{% raw %}
2015/2                 2009/2
SunMonTueWedThuFriSat  SunMonTueWedThuFriSat
1  2  3  4  5  6  7    1  2  3  4  5  6  7
8  9  10 11 12 13 14   8  9  10 11 12 13 14
15 16 17 18 19 20 21   15 16 17 18 19 20 21
22 23 24 25 26 27 28   22 23 24 25 26 27 28
{% endraw %}
{% endhighlight %}


これは日曜始まりのカレンダーにキレイに収まるのですから自明なことですね。
出来るだけシンプルに Ruby で表現してみましょう。
ここからのプログラムリストは irb にコピー・ペーストして実行できます。
ぜひお手元でお試しください。

{% highlight text %}
{% raw %}
require "date"

def create_feb_first_day(year=Date.today.year)
  Date.new year, 2, 1
end
alias feb create_feb_first_day

def rectangle_february? (feb)
  feb.sunday?
end
alias rect_feb? rectangle_february?
{% endraw %}
{% endhighlight %}


実行してみましょう。

{% highlight text %}
{% raw %}
rect_feb? feb 2015 #=> true
rect_feb? feb 2009 #=> true
rect_feb? feb 2014 #=> false
{% endraw %}
{% endhighlight %}


良さそうです。

さて次は 2015 年と 2009 年以外の RectFeb を探してみます。
2009 年からさかのぼっていくと 2004 年 2 月が日曜日始まりであることがわかります。
(逆に 2015 年以降を探しにいってしまうと中々見つかりません……。)

{% highlight text %}
{% raw %}
rect_feb? feb 2004 #=> true
{% endraw %}
{% endhighlight %}


しかし、カレンダーを確認すると 2004 年 2 月は四角ではありません。
これはなぜでしょうか？
カレンダーを見ればすぐにわかりますね。

{% highlight text %}
{% raw %}
2004/2
SunMonTueWedThuFriSat
1  2  3  4  5  6  7
8  9  10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 
{% endraw %}
{% endhighlight %}


そうです、うるう年です。
2004 年は 2 月 29 日が存在するため RectFeb ではありません。
つまり、RectFeb は 2 月 1 日が日曜であり、かつ、うるう年ではない場合に出現するようです。
さっそく得られた知見を Ruby コードに反映しましょう。

{% highlight text %}
{% raw %}
def rectangle_february? (feb)
  feb.sunday? && !feb.leap?
end
alias rect_feb? rectangle_february?

rect_feb? feb 2004 #=> false
{% endraw %}
{% endhighlight %}


次はどちらに進みましょう？
RectFeb の法則性を見つけるため、すこし範囲を広げて 2 月 1 日の曜日をチェックしてみましょう。
そのためのコードを書きましょう。

{% highlight text %}
{% raw %}
def convert_febs year_range
  year_range.map {|y| feb y}
end
alias conv convert_febs

def weekday feb
  feb.strftime("%a")
end

def febs_detail febs
  febs.map {|feb| "#{feb.year}:#{weekday (feb)}:#{rect_feb?(feb)}:#{'leap' if feb.leap?}"}
end

puts febs_detail conv(2000..2050)
{% endraw %}
{% endhighlight %}


2000 年から 2050 年の範囲で

* 2 月 1 日の曜日
* RectFeb かどうか
* うるう年かどうか


を表示するコードを追加しています。
実行結果は以下のようになりました。 (少し長いです。)

{% highlight text %}
{% raw %}
2000:Tue:false:leap
2001:Thu:false:
2002:Fri:false:
2003:Sat:false:
2004:Sun:false:leap
2005:Tue:false:
2006:Wed:false:
2007:Thu:false:
2008:Fri:false:leap
2009:Sun:true:
2010:Mon:false:
2011:Tue:false:
2012:Wed:false:leap
2013:Fri:false:
2014:Sat:false:
2015:Sun:true:
2016:Mon:false:leap
2017:Wed:false:
2018:Thu:false:
2019:Fri:false:
2020:Sat:false:leap
2021:Mon:false:
2022:Tue:false:
2023:Wed:false:
2024:Thu:false:leap
2025:Sat:false:
2026:Sun:true:
2027:Mon:false:
2028:Tue:false:leap
2029:Thu:false:
2030:Fri:false:
2031:Sat:false:
2032:Sun:false:leap
2033:Tue:false:
2034:Wed:false:
2035:Thu:false:
2036:Fri:false:leap
2037:Sun:true:
2038:Mon:false:
2039:Tue:false:
2040:Wed:false:leap
2041:Fri:false:
2042:Sat:false:
2043:Sun:true:
2044:Mon:false:leap
2045:Wed:false:
2046:Thu:false:
2047:Fri:false:
2048:Sat:false:leap
2049:Mon:false:
2050:Tue:false:
{% endraw %}
{% endhighlight %}


長いですね……。でも、どうやら次の RectFeb は 2026 年であることがわかりました。
その次は 2037 年、2043 年とつづくようです。

## 二つ目の調査

うーん、ちょっとここから法則性を見つけるのは難しそうです。
別のアプローチを考えましょう。
というわけで先ほど列挙した Feb の中から RectFeb だけを抜き出してながめてみましょう。

{% highlight text %}
{% raw %}
def select_rect_febs febs
  febs.select {|feb| rect_feb? feb}
end

puts febs_detail select_rect_febs conv(2000..2050)
{% endraw %}
{% endhighlight %}


実行結果は下記のようになりました。

{% highlight text %}
{% raw %}
2009:Sun:true:
2015:Sun:true:
2026:Sun:true:
2037:Sun:true:
2043:Sun:true:
{% endraw %}
{% endhighlight %}


さっきよりはよいかもしれません。
2009 年から 2015 年は 6 年の間隔で
2015 年以降は 11 年ごとに RectFeb になるようです。
Ruby のコードでも RectFeb の間隔を確かめてみます。

{% highlight text %}
{% raw %}
def febs_distance rect_febs
  prev = nil
  rect_febs.map do |feb|
    y = feb.year
    year_distance =  "#{y}"
    year_distance += ":#{(y - prev)}" if prev
    prev = y
    year_distance
  end
end

puts febs_distance (select_rect_febs conv 2000..2050)
{% endraw %}
{% endhighlight %}


実行結果は下記のようになりました。

{% highlight text %}
{% raw %}
2009
2015:6
2026:11
2037:11
2043:6
{% endraw %}
{% endhighlight %}


おっと勘違いがあったようです。2037 年から 2043 年の間隔は 6 年でした。
そうすると RectFeb は 6 年もしくは 11 年間隔で発生しているのでは？という仮説がたちます。
試しに 2043 年の 6 年後、11 年後が RectFeb かどうか確かめてみましょう。
(ただし 2049 年は 2050 年まで調べた時に RectFeb として出てきていないので RectFeb ではなさそうですね。)

{% highlight text %}
{% raw %}
rect_feb? feb 2049 #=> false
rect_feb? feb 2054 #=> true
{% endraw %}
{% endhighlight %}


ここでも 11 年後が RectFeb になるようです。
さらにもう一度確かめます。

{% highlight text %}
{% raw %}
rect_feb? feb 2060 #=> false
rect_feb? feb 2065 #=> true
{% endraw %}
{% endhighlight %}


やはり 11 年後が RectFeb になるようです。

最初に比べてだいぶわかったことが増えてきました。
いったんまとめましょう。

* 2009 年、2015 年は RectFeb である
* RectFeb は 2 月 1 日が日曜でその年がうるう年でないことを確認すれば判定できる
* 2015 年以降は 2026 年、2037 年、2043 年に現れる
* RectFeb の発生間隔は 6 年もしくは 11 年である可能性が高い (推測)


## 6 年間隔、11 年間隔の謎に迫る

さて、この次はどうしましょうか。
候補としては

* さらに広範囲を調べてみる
* なぜ 6 年間隔、11 年間隔になるかの謎を調べる


のどちらか、でしょうか。
先に、より難しそうな (そしてよりおもしろそうな) 6 年間隔、11 年間隔の謎を調べてみましょう。
6 年間隔のサンプルとして 2009 年から 2015 年に注目します。

{% highlight text %}
{% raw %}
puts febs_detail conv(2009..2015)
{% endraw %}
{% endhighlight %}


実行結果は下記のようになりました。

{% highlight text %}
{% raw %}
2009:Sun:true:
2010:Mon:false:
2011:Tue:false:
2012:Wed:false:leap
2013:Fri:false:
2014:Sat:false:
2015:Sun:true:
{% endraw %}
{% endhighlight %}


2009 年から 2010 年で Sun → Mon となっていますので曜日が 1 つだけ進んでいることがわかります。
こうなる理由ですが、1 年は 365 日なので 1 週間の 7 で割ると 52 週と余り 1 日になる、ゆえに、同じ月日 (ここでは 2 月 1 日) に着目すると 1 年ごとに曜日が 1 つ進むから、ですね。

でも、そうすると 2009 年の Sun から次の Sun に戻るまでには 7 年必要になるはずです。
なぜならば以下のように Sun → Mon → Tue → Wed → Thu → Fri → Sat → Sun と Sun → Sun に戻ってくるには 7 年分の曜日が進む必要があるからです。
ところが、実際には 6 年後の 2015 年が Sun になっています。
なぜなのでしょうか？

そう思いながら見ていくと 2012 年から 2013 年にかけては Web→Fri と曜日が 2 つ進んでいます。
これは 2012 年がうるう年のため 366 日あり 52 週と余り 2 日で曜日が 2 つ進むからのようです。
したがって RectFeb から次の RectFeb までにうるう年が 1 回だけ発生する場合は、6 年間隔になるということが言えそうです。

2037 年と 2043 年に関して確認してみると同様の結果が得られました。 (2040 年だけがうるう年。)

11 年間隔についてはどうでしょうか？

{% highlight text %}
{% raw %}
puts febs_detail conv(2015..2026)
{% endraw %}
{% endhighlight %}


実行結果は下記のようになりました。

{% highlight text %}
{% raw %}
2015:Sun:true:
2016:Mon:false:leap
2017:Wed:false:
2018:Thu:false:
2019:Fri:false:
2020:Sat:false:leap
2021:Mon:false:
2022:Tue:false:
2023:Wed:false:
2024:Thu:false:leap
2025:Sat:false:
2026:Sun:true:
{% endraw %}
{% endhighlight %}


順に見ていくと 2016 年にうるう年で 2 つ曜日が進み 2020 年にも 2 つ曜日が進んでいます。
特筆すべきは 2020 年は Sat なので次の年が RectFeb になりそうなのですが
うるう年のため 2 つ曜日が進みます。そのため Sun がスキップされ、もう 1 周曜日が進まないと RectFeb が発生しない点です。

{% highlight text %}
{% raw %}
2020:Sat:false:leap
2021:Mon:false:
{% endraw %}
{% endhighlight %}


2021 年以降はうるう年が 1 回発生しておりこれは 6 年間隔と同じ経過のようです。
したがって「2020 年までの 5 年 + 2021 年以降の 6 年 = 11 年間隔」となるようです。

もうひとつの 11 年間隔の期間である 2026 年から 2037 年も見てみましょう。

{% highlight text %}
{% raw %}
puts febs_detail conv(2026..2037)
{% endraw %}
{% endhighlight %}


実行結果は下記のようになりました。

{% highlight text %}
{% raw %}
2026:Sun:true:
2027:Mon:false:
2028:Tue:false:leap
2029:Thu:false:
2030:Fri:false:
2031:Sat:false:
2032:Sun:false:leap
2033:Tue:false:
2034:Wed:false:
2035:Thu:false:
2036:Fri:false:leap
2037:Sun:true:
{% endraw %}
{% endhighlight %}


同じパターンかなと思ったのですが 2032 年が Sun で、かつうるう年のため
RectFeb でなくなっている点が大きな違いです。
こちらは「2032 年までの 6 年 + 2033 年以降の 5 年 = 11 年間隔」となるようです。

また、5 年 + 6 年のパターン (Sat:leap) と 6 年 + 5 年のパターン (Sun:leap) のどちらもうるう年が 3 回発生している点が共通しています。

さて、まとめると RectFeb と次の RectFeb の間には以下のような法則があるようです。

* Sat でうるう年の Feb がある場合、11 年間隔
* Sun でうるう年の Feb がある場合、11 年間隔
* それ以外の場合、6 年間隔


## 意外な伏兵

6 年、11 年間隔の謎がわかったところで広範囲の探索に移りたいと思います。
広範囲と簡単に言ってしまいましたが、その意味するところは、その範囲を探索すれば RectFeb のすべての出現パターンが確実に存在する範囲のことを指しています。

でも、いったいどうやってそんな範囲を決めればいいんでしょう……。
かなり悩んでしまいます。
こういった場合、途方に暮れていても問題は解決しないのですよね。
いろいろ試して使える情報を増やしてみるか今までの情報を整理してみると突破口が開けそうです (筆者の経験則です) 。

ということで試しに 2000 年から 100 年の間を調べてみます。

{% highlight text %}
{% raw %}
puts febs_distance (select_rect_febs conv 2000..2100)
{% endraw %}
{% endhighlight %}


実行結果は下記のようになりました。

{% highlight text %}
{% raw %}
2009
2015:6
2026:11
2037:11
2043:6
2054:11
2065:11
2071:6
2082:11
2093:11
2099:6
{% endraw %}
{% endhighlight %}


6 年、11 年間隔以外のパターンはないようです。
しかし、やはりこれですべてパターンを網羅しているかどうかは確信が持てません。

そこで情報を整理する方向を模索します。
ここまでを振り返ってみると、うるう年が重要な役割を果たしていることがわかりました。
ちょっと調べるとうるう年の定義は以下のようです[^2]。グレゴリオ暦法において、

1. 西暦年号が 4 で割り切れる年をうるう年とする。
1. 例外として、西暦年号が 100 で割り切れて 400 で割り切れない年は平年とする。


これらから、400 年周期で RectFeb の出現するパターンがかわる可能性があるのでは？と推測しました。
なので、少なくとも 400 年以上は調べてみないと RectFeb の出現パターンを網羅したとは言えなさそうです。
ではさっそく調べてみましょう。切りがいいので 2000 年から 3000 年を調べてみます。 (またしても長いです……。)

{% highlight text %}
{% raw %}
puts febs_distance (select_rect_febs conv 2000..3000)
{% endraw %}
{% endhighlight %}


実行結果は下記のようになりました。

{% highlight text %}
{% raw %}
2009
2015:6
2026:11
2037:11
2043:6
2054:11
2065:11
2071:6
2082:11
2093:11
2099:6
2105:6
2111:6
2122:11
2133:11
2139:6
2150:11
2161:11
2167:6
2178:11
2189:11
2195:6
2201:6
2207:6
2218:11
2229:11
2235:6
2246:11
2257:11
2263:6
2274:11
2285:11
2291:6
2303:12
2314:11
2325:11
2331:6
2342:11
2353:11
2359:6
2370:11
2381:11
2387:6
2398:11
2409:11
2415:6
2426:11
2437:11
2443:6
2454:11
2465:11
2471:6
2482:11
2493:11
2499:6
2505:6
2511:6
2522:11
2533:11
2539:6
2550:11
2561:11
2567:6
2578:11
2589:11
2595:6
2601:6
2607:6
2618:11
2629:11
2635:6
2646:11
2657:11
2663:6
2674:11
2685:11
2691:6
2703:12
2714:11
2725:11
2731:6
2742:11
2753:11
2759:6
2770:11
2781:11
2787:6
2798:11
2809:11
2815:6
2826:11
2837:11
2843:6
2854:11
2865:11
2871:6
2882:11
2893:11
2899:6
2905:6
2911:6
2922:11
2933:11
2939:6
2950:11
2961:11
2967:6
2978:11
2989:11
2995:6
{% endraw %}
{% endhighlight %}


これは！？お気付きになられたでしょうか？
気付いておられない方は 2303 年と 2703 年をご覧下さい。
レアキャラの 12 年間隔が出現しています！！
まだ謎が残っているようですね… …。
なんと奥深いことか。

2303 年とその一つ前の RecrFeb を調べてみましょう。

{% highlight text %}
{% raw %}
puts febs_detail conv(2291..2303)
{% endraw %}
{% endhighlight %}


実行結果は下記のようになりました。

{% highlight text %}
{% raw %}
2291:Sun:true:
2292:Mon:false:leap
2293:Wed:false:
2294:Thu:false:
2295:Fri:false:
2296:Sat:false:leap
2297:Mon:false:
2298:Tue:false:
2299:Wed:false:
2300:Thu:false:
2301:Fri:false:
2302:Sat:false:
2303:Sun:true:
{% endraw %}
{% endhighlight %}


2296 年は Sat:leap にも関わらず 2297 年から次の RectFeb まで 7 年になっています。
それに、うるう年が 2 回しかありませんね。
どのうるう年がなくなったのかと見ていくと 2300 年は「100 で割り切れて 400 で割り切れない年」に一致します。
ですので、2300 年はうるう年ではありません。
ここがポイントのようです。
11 年のパターンの最後のうるう年が平年になったため RectFeb まで 1 年余分にかかる、というのが結論のようです。

さらに 2703 年は 2303 年のちょうど 400 年後ですね。
ここから、RectFeb の周期は 400 年であることが示唆されます。
400 年ごとに同じパターンで出現するのであれば、ある 400 年間を調べればすべての出現パターンを網羅できたといえますよね。
このことの確認 (証明？) は読者への宿題とします。 (筆者は体力がつきました……。)

## まとめ

最後にここまでにわかった法則性を整理／検討すると

* ある RectFeb から次の RectFeb の間隔は必ず 6 年、11 年、12 年のどれかになる
* RectFeb は 400 年周期の出現パターンを持つ
* 400 年の間で 6 年間隔は 17 回、11 年間隔は 26 回、12 年間隔は 1 回出現する
* RectFeb は全部で 44 回 / 400 年、平均で 9.09 年に 1 度出現する


ということがわかりました。

以上で RectFeb 問題のまとめとします。
ひとしごとおしまい。
ここまでの長旅ご苦労様でした。

記事中で使用した Ruby コードをまとめておきます。
興味のある方は、[rect_feb.rb]({{base}}{{site.baseurl}}/images/0051-FebruaryRectangleWithRuby/rect_feb.rb) からダウンロードしてください。

## おまけ

RectFeb に法則性があることがわかったので当初の目的のとおり (覚えていますか？) 、法則性を踏まえた上で自分で任意の年の次に来る RectFeb を見つける方法を考えたいと思います。
一応、紙と鉛筆があれば PC を使わずとも計算できるはずです。

まず 400 年周期を 100 年ごとに分割します。
分割方法は以下のようにします。

* 次の RectFeb を調べたい年を y とします
* y を 400 で割った余りを y400 とします
* y400 の値を以下に当てはめて分類します。例: y = 2672 年とすると 2672 / 400 = 6 余り 272、y400 = 272 なので 200 ≦ 272 ≦ 300。よって 2672 年は 200 年期になります。
  * [ 0 ≦ y400 &lt; 100 ] → 400 年期 (0 年期とも名付けられますが 100 年間であることを表すため 400 年期としています)
  * [ 100 ≦ y400 &lt; 200 ] → 100 年期
  * [ 200 ≦ y400 &lt; 300 ] → 200 年期
  * [ 300 ≦ y400 &lt; 400 ] → 300 年期


各 100 年期ごとに最初の RectFeb の年を覚えておきます。
400 年期から 200 年期までは 4 ずつ減っていくと覚えると覚えやすいと思います。
なお、300 年期の初めての RectFeb は 12 年間隔のため 4 ずつ減っていくという法則に当てはまらない模様です。

* 400 年期: 9 年目 (最初の RectFeb は 2009、2409、2809 など)
* 100 年期: 5 年目 (最初の RectFeb は 2105、2505、2905 など)
* 200 年期: 1 年目 (最初の RectFeb は 2201、2601、3001 など)
* 300 年期: 3 年目 (最初の RectFeb は 2303、2703、3103 など)


調べたい年を超えるまで最初の RectFeb の年に 6, 11, 11 の数を繰り返しこの順に加算していきます。
計算した結果が次の RectFeb の年になります。

例: y = 2672 年の次に現れる RectFeb を調べたい場合、2601 + 6 + 11 + 11 + 6 + 11 + 11 + 6 + 11 = 2674 年。

確認してみましょう。

{% highlight text %}
{% raw %}
rect_feb? feb 2674 #=> true
{% endraw %}
{% endhighlight %}


OK ですね。
これで (一生涯で本記事以外では使うことがないであろう) RectFeb の算出方法がわかりました！

## あとがき

暦はある時点の太陽と地球の相対位置を表していると考えられます。
もし、うるう年がないとします。その場合、暦というシステムを実装するには楽なのですが、
それでは全く役に立たないものになってしまうことでしょう。
なぜならば、年を経るごとに、同じ月なのに、太陽と地球の相対位置がずれていってしまうからです。
そうした場合、例えば各月の平均降水量だとか平均気温だとかいった統計を比較することの意味がなくなってしまいます。
意味のある比較にするには暦を使う側がずれを考慮しなければならず、でもそれはとても面倒くさいですね。
暦を使う側が楽を出来るようにうるう年 (あるいはうるう秒) の様な複雑なルールが作られているわけですね。
(と本記事を書きながら理解しました。)

Ruby でも「ある仕事を行なうとき、そのためにプログラミング言語を使う人と、そのためのプログラミング言語を作る人の割合は、言語を作る人のほうが圧倒的に少ない。であれば、苦労すべきはプログラミング言語を作る人だ[^3]」とのことですのでこういった面では似ているのかもしれませんね。

それにしても次の 12 年間隔 RectFeb が出現する 2303 年には私は確実に生きていないです。当然この記事を読んでいるあなたも。
われわれの子供ですら生きていないでしょう。
Ruby は生き残っているのでしょうか？
遠大な気分になりますね。
そんなとりとめのないことを考えながら本記事を終わりといたします。

## 謝辞

本記事は[とちぎ Ruby 会議 06](http://regional.rubykaigi.org/tochigi06/) に参加した影響のもとで書きあげました。
書くにあたって多大なインスピレーションをいただいた、とちぎ Ruby 会議 06 のスタッフの方々、発表者の方々、参加者の方々にお礼を申し上げます。
ありがとうございます。

特に[原信一郎さんの発表](http://www.slideshare.net/sinara.h/toruby2015-hara0621)が本記事を書く直接のきっかけになりました。ありがとうございます。

本記事を書くにあたって使用した Ruby は大変つかいやすく
切れ味のよいナイフで問題を切り分けているような感覚を覚えました。
開発をなされているコミッタの方々に感謝いたします。ありがとうございます。

普段 (というかこれまでの人生で一度も) 感謝したことはありませんが
暦を作った方 (方々？) に感謝いたします。ありがとうございます。

最後になりますが、
いつも陽に陰に支えてくれる妻と本記事が掲載される頃には産まれているはずの子供に
本記事を捧げたいと思います。 (読んでくれるかな？)

## 著者について

ふつうのプログラマ兼ソフトウェアエンジニア兼システムエンジニア。
カウンセリング、リーダーシップ、パターンランゲージなどが好き。
最近読んだおもしろい本は『[火星の人](http://www.hayakawa-online.co.jp/product/books/11971.html)』、感動した本は『[きみは赤ちゃん](http://books.bunshun.jp/ud/book/num/9784163900704)』。

----

[^1]: [RectFeb の命名に関する筆者の一連のツイート](https://twitter.com/swallow_life/status/561879404972765184)。本記事を書いている途中に、私と同じく RectFeb という命名をしている記事「[Cool take: February is a pretty rectangle](http://www.vox.com/2015/2/13/8034855/february-pretty-rectangle)」を見つけました
[^2]: http://www.nao.ac.jp/faq/a0306.html
[^3]: http://ascii.jp/elem/000/000/143/143399/index-4.html
