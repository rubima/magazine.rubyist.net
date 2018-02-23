---
layout: post
title: Rubyist Magazine 九周年
short_title: Rubyist Magazine 九周年
tags: 0044 EditorComment
---
{% include base.html %}


著者： 郡司啓 ([@gunjisatoshi](https://twitter.com/gunjisatoshi))

## はじめに

おかげさまで、Rubyist Magazine は 9 周年を迎えました。そこで、今年 1 年間、およびこれまでのるびまについてまとめ、今後について考えてみたいと思います。

## 今年一年を振り返って

今年一年を振り返ってみると、号外の「Ruby 2.0.0 Release special articles (「[Ruby 2.0.0 リリース特集]({% post_url articles/0041/2013-02-24-0041-200Special %})」の英訳号)」を含めると 6 回、リリースしています。

* [0040](0040)
* [0041](0041)
* [Ruby200SpecialEn](Ruby200SpecialEn)
* [0042](0042)
* [0043](0043)
* [0044](0044) &lt;- 今ここ


昨年が号外を含めて 5 回のリリースでしたので、今年は 1 回リリース回数が増えています。これは「RubyKaigi 効果」で、RubyKaigi での発表内容を記事にしていただけた方がいらっしゃったおかげで記事数が稼げたためにリリース回数を増やすことができました。

こうしてカンファレンスでの発表内容を記事にしていただけると発表では伝えきれなかったことを補足していただけたり、発表を見ることのできなかった人にも読んでいただけたりもしますので、今後も「カンファレンス発表内容を記事として投稿」というパターンは継続していけたらと考えています。カンファレンスで発表された方、是非るびまに投稿してみてください。

それでは、9 年目の記事を見てみましょう。

まずは高橋編集長による巻頭言ですが、今年も継続して毎号掲載されています。内容は、最近のカンファレンスでの高橋編集長の発表をご覧になられた方にはおなじみの mruby についてや、Ruby 20 周年に寄せた「この 20 年の振り返り」、カンファレンスに外国からスピーカーを呼ぶ際のノウハウ、「自由なソフトウェア」について、そして一般社団法人日本 Ruby の会の活動報告など、様々な話題に触れられています。

* [0040 号 巻頭言]({% post_url articles/0040/2012-11-25-0040-ForeWord %})
* [0041 号 巻頭言]({% post_url articles/0041/2013-02-24-0041-ForeWord %})
* [0042 号 巻頭言]({% post_url articles/0042/2013-05-29-0042-ForeWord %})
* [0043 号 巻頭言]({% post_url articles/0043/2013-07-31-0043-ForeWord %})
* [0044 号 巻頭言]({% post_url articles/0044/2013-09-30-0044-ForeWord %})


そして「内容が古い」というご指摘をずいぶん頂いておりました Rubyist Magazine 常設記事の「Ruby の歩き方」ですが、[@satococoa](https://twitter.com/satococoa) さん、[@hsbt](https://twitter.com/hsbt) さんに最近の Ruby 界隈の流行などを踏まえた内容にリニューアルいただきました。またこうした内容は流行り廃りが激しいため、今後も継続的に内容を更新し続けられるよう、GitHub などにコンテンツを移行して Pull Request ベースで誰でも気軽に内容の改善を提案できるようにしていこうという話も挙がっています。継続して今後もうまく回していけるようになるといいですね。

* [FirstStepRuby](https://github.com/rubima/rubima/blob/master/first_step_ruby/first-step-ruby-2.0.md)


インタビュー記事の Rubyist Hotlinks は、昨年に続いて Ruby コミッタの樽家昌也さん、卜部昌平さんと続きましたが、ここで長年インタビュアーとして活躍されていたささださんから卜部さんにインタビュアーがバトンタッチし、心機一転ということで大場光一郎さん、大場寧子さんへのインタビューへと繋がっています。今後はしばらく Ruby コミッタではない方へのインタビューが継続しそうな予感がします。

編集者の立場としては、相変わらずインタビュー記事の作成に結構な負担がかかるという問題を抱えています。もうちょっと楽にできる方法はないものか、と毎回思うものの、ついつい前回のやり方を踏襲してまた大変な作業が、という繰り返しになってしまっているので、今までのインタビュー記事の良さも受け継ぎつつ、もう少し楽に回していける方法を考えていく必要がありそうです。

* [Rubyist Hotlinks 【第 31 回】 樽家昌也さん]({% post_url articles/0041/2013-02-24-0041-Hotlinks %})
* [Rubyist Hotlinks 【第 32 回】 卜部昌平さん]({% post_url articles/0042/2013-05-29-0042-Hotlinks %})
* [Rubyist Hotlinks 【第 33 回】 大場さん夫妻 前編]({% post_url articles/0044/2013-09-30-0044-Hotlinks %})


シリーズ物としては、今年から始まった新連載「Ruby コードの感想戦」があります。文通形式のコード添削は、もともとのコードの意図とそれを改善していく意図を明らかにすることで、コーディングをする上での「他人の思考」を見ることができ、勉強になるとともに大変面白い「プログラマのエンターテイメント」となっていますので、まだ読んでいない方は是非どうぞ。また今後も連載として続けていきたいと思いますので、「添削したい・されたい」コードをお持ちの方はぜひ Rubyist Magazine 編集部までご連絡ください。

* [Ruby コードの感想戦 【第 1 回】 WikiR]({% post_url articles/0040/2012-11-25-0040-CodePostMortem %})
* [Ruby コードの感想戦 【第 2 回】 WikiR]({% post_url articles/0041/2013-02-24-0041-CodePostMortem %})


また 1 年に 1 回というペースですが何とかつながったシリーズ「他言語からの訪問」、今回は Rubyist Magazine 編集者としてもおなじみの、たなべさんによる Perl 編です。Ruby でオブジェクト指向の考え方を身に着けていれば、ともすれば「後付け」と批判される Perl のオブジェクト指向の成り立ちを見て「なるほど」と思うのではないでしょうか。複数の言語を学ぶと「プログラミングというものの本質」をつかむきっかけとなり、より良いプログラムを書くことができるようになりますので、Perl と聞いて敬遠せずに是非お読みいただければと思います。また引き続き他のプログラミング言語にて連載を続けていけたらと思いますので、複数言語使いの方は是非ともるびままで投稿をお願いいたします。

* [他言語からの訪問 【第 3 回】 Perl]({% post_url articles/0044/2013-09-30-0044-GuestTalk %})


そしてこちらは 2 年ぶりとなる、Ruby 1.9 以降の Ruby VM 作者であり、Rubyist Magazine 編集者でもあるささださんによるシリーズ「YARV Maniacs」。Ruby のユーザーは爆発的に増えましたが、Ruby のコア開発者はそれに比較すると少数精鋭となっており、こうした Ruby の中身を解説する記事は貴重ですね。今後とも (Ruby 自体の開発に差し障りない範囲で) 連載を継続いただけたら嬉しいなあと思っています。

* [YARV Maniacs 【第 11 回】 最近の YARV の事情]({% post_url articles/0041/2013-02-24-0041-YarvManiacs %})


そしてシリーズ物としては毎号掲載されている「Regional RubyKaigi レポート」。岡山 Ruby 会議が 2 回開催されているのを始めとして、北は北海道から南は九州まで、各地の Ruby コミュニティによる地域 Ruby 会議が活発に開催されていることが分かりますね。こうしたレポートを見て興味を持ったら、ぜひ各地域の地域 Ruby 会議に足を運んでみてください。地域 Ruby 会議の開催予定は「[地域Ruby会議のサイト](http://regional.rubykaigi.org/)」や「[RubyKaigi 日記](http://rubykaigi.tdiary.net/)」、「[これから開催される地域Ruby会議](https://github.com/ruby-no-kai/official/wiki/Upcomingregionalrubykaigi)」といったサイトをチェックしてみてください。

* [RegionalRubyKaigi レポート (30) 岡山 Ruby 会議 01]({% post_url articles/0040/2012-11-25-0040-OkayamaRubyKaigi01Report %})
* [RegionalRubyKaigi レポート (31) 松江 Ruby 会議 04]({% post_url articles/0040/2012-11-25-0040-MatsueRubyKaigi04Report %})
* [RegionalRubyKaigi レポート (32) 札幌 Ruby 会議 2012]({% post_url articles/0040/2012-11-25-0040-SapporoRubyKaigi2012Report %})
* [RegionalRubyKaigi レポート (33) 東京 Ruby 会議 10]({% post_url articles/0041/2013-02-24-0041-TokyoRubyKaigi10Report_1st %})
* [RegionalRubyKaigi レポート (34) 福岡 Ruby 会議 01]({% post_url articles/0042/2013-05-29-0042-FukuokaRubyKaigi01Report %})
* [RegionalRubyKaigi レポート (35) 東京 Ruby 会議 10 中断後の 3 日目]({% post_url articles/0042/2013-05-29-0042-TokyoRubyKaigi10Report_2nd %})
* [RegionalRubyKaigi レポート (36) ぐんま Ruby 会議 01]({% post_url articles/0042/2013-05-29-0042-GunmaRubyKaigi01Report %})
* [RegionalRubyKaigi レポート (37) 大江戸 Ruby 会議 03]({% post_url articles/0042/2013-05-29-0042-OoedoRubyKaigi03Report %})
* [RegionalRubyKaigi レポート (38) 九州 Ruby 会議 02]({% post_url articles/0043/2013-07-31-0043-KyushuRubyKaigi02Report %})
* [RegionalRubyKaigi レポート (39) Tokyu Ruby 会議 06]({% post_url articles/0044/2013-09-30-0044-TokyuRubyKaigi06Report %})
* [RegionalRubyKaigi レポート (40) 岡山 Ruby 会議 02]({% post_url articles/0044/2013-09-30-0044-OkayamaRubyKaigi02Report %})


シリーズ物ではないものの、各種カンファレンスの参加レポートやスタッフによる裏話などの Ruby 関連カンファレンス記事も多数掲載されています。かくいう私も「EuRuKo 2013 参加レポート」を投稿させていただきましたが、国内だけでなく海外の Ruby カンファレンスレポートが増えてきたのも嬉しいですね。

かねてより日本の Ruby コミュニティと海外の Ruby コミュニティとの断絶の話は何度も話題に上っており、日本の Ruby コミュニティはもっともっと海外の Ruby コミュニティと交流が必要だと個人的には思っていますので、こうした記事を読んで興味を持ったらぜひ海外の Ruby カンファレンスへも足を運んでみてください。また海外に行くのが無理という方も、日本国内で海外の著名な Rubyist が講演するイベントも最近は増えてきましたので、そうした機会を見つけてぜひ海外の Rubyist と交流してみてください。

国内および海外の Ruby カンファレンスの開催情報については、[RubyEventCheck](https://github.com/ruby-no-kai/official/wiki/RubyEventCheck) をご参照ください。

* [レポートチーム史上最大の作戦]({% post_url articles/0040/2012-11-25-0040-HowToBuildSprk2012ReportTeam %})
* [Euroko 2012 参加レポート]({% post_url articles/0041/2013-02-24-0041-Euroko2012 %})
* [RubyConf Taiwan 旅行記]({% post_url articles/0041/2013-02-24-0041-RubyTaiwan2012 %})
* [Ruby 20 周年記念パーティーレポート ―― プログラミング初心者の運営スタッフが見た Ruby コミュニティ]({% post_url articles/0042/2013-05-29-0042-Ruby20thAnniversaryPartyReport %})
* [RubyKaigi 2013 レポート]({% post_url articles/0043/2013-07-31-0043-RubyKaigi2013 %})
* [Railsberry 2013 And RailsConf 2013]({% post_url articles/0043/2013-07-31-0043-Railsberry2013AndRailsConf2013 %})
* [RubyMotion Kaigi 2013 レポート]({% post_url articles/0043/2013-07-31-0043-RubyMotionKaigi2013Report %})
* [RedDotRubyConf 2013 旅行記]({% post_url articles/0043/2013-07-31-0043-RedDotRubyConf2013 %})
* [EuRuKo 2013 参加レポート]({% post_url articles/0043/2013-07-31-0043-EuRuKo2013 %})


そしてこの一年で一番の目玉は「Ruby 2.0.0 リリース特集」でしょう。Ruby の 20 歳を記念してリリースされた Ruby 2.0.0 の情報を、Ruby コミッタの方々を中心に詳細に解説いただきました。リリースバージョンが上がった際にこうした情報がまとまっていると、とても有用ですね。今年のクリスマスには Ruby 2.1.0 がリリース予定ですが、是非またリリースのタイミングでこうした特集が組まれると嬉しいなあと思います (が、見ているとなかなか大変そうでしたので、難しそうではあります) 。

* [Ruby 2.0.0 リリース特集]({% post_url articles/0041/2013-02-24-0041-200Special %})
  * [Ruby 2.0.0 リリースを振り返って]({% post_url articles/0041/2013-02-24-0041-200Special-release %})
  * [Ruby 2.0.0 のキーワード引数]({% post_url articles/0041/2013-02-24-0041-200Special-kwarg %})
  * [無限リストを map 可能にする Enumerable#lazy]({% post_url articles/0041/2013-02-24-0041-200Special-lazy %})
  * [Refinementsとは何だったのか]({% post_url articles/0041/2013-02-24-0041-200Special-refinement %})
  * [Ruby 2.0.0 の DTrace の紹介]({% post_url articles/0041/2013-02-24-0041-200Special-dtrace %})
  * [Ruby 2.0.0 の GC 改善]({% post_url articles/0041/2013-02-24-0041-200Special-gc %})
  * [Ruby 2.0.0 の require]({% post_url articles/0041/2013-02-24-0041-200Special-require %})
  * [Ruby 2.0.0 の注意点やその他の新機能]({% post_url articles/0041/2013-02-24-0041-200Special-note %})
  * [Ruby 安定版の今後の保守の見通し]({% post_url articles/0041/2013-02-24-0041-200Special-193 %})


これらの記事は海外においても有用ということもあり、「Ruby 2.0.0 リリース特集」を英訳した号外「Ruby 2.0.0 Release special articles」もリリースされました。多大な労力をかけて英訳に関わられた皆さま、大変ありがとうございました。

* [Ruby200SpecialEn](Ruby200SpecialEn)
  * [Ruby200SpecialEn-release](Ruby200SpecialEn-release)
  * [Ruby200SpecialEn-kwarg](Ruby200SpecialEn-kwarg)
  * [Ruby200SpecialEn-lazy](Ruby200SpecialEn-lazy)
  * [Ruby200SpecialEn-refinement](Ruby200SpecialEn-refinement)
  * [Ruby200SpecialEn-dtrace](Ruby200SpecialEn-dtrace)
  * [Ruby200SpecialEn-gc](Ruby200SpecialEn-gc)
  * [Ruby200SpecialEn-require](Ruby200SpecialEn-require)
  * [Ruby200SpecialEn-note](Ruby200SpecialEn-note)
  * [Ruby200SpecialEn-193](Ruby200SpecialEn-193)


個別記事は次のとおりです。

* [Ruby on Rails: The Bad Parts]({% post_url articles/0041/2013-02-24-0041-RailsTheBadParts %})
* [エンドツーエンドテストの自動化は Cucumber から Turnip へ]({% post_url articles/0042/2013-05-29-0042-FromCucumberToTurnip %})
* [クックパッドを Ruby 2.0.0 に対応させた話]({% post_url articles/0042/2013-05-29-0042-MigratingARailsApplicationToRuby200 %})
* [桐島、Rubyやめるってよ]({% post_url articles/0042/2013-05-29-0042-FollowUpKirishimaRuby %})
* [Rubyist Magazine 移行後記]({% post_url articles/0042/2013-05-29-0042-RubimaMigrationToRuby2.0 %})
* [Ruby でナゾ解き？ 任天堂 Code Puzzle 解説＆裏話]({% post_url articles/0043/2013-07-31-0043-CodePuzzle %})
* [TRICK2013 開催報告＆入賞作品紹介]({% post_url articles/0043/2013-07-31-0043-TRICK2013 %})
* [ライブラリー開発者になろう]({% post_url articles/0043/2013-07-31-0043-BeALibraryDeveloper %})
* [Fluentd v11 の噂]({% post_url articles/0044/2013-09-30-0044-FluentdV11NewFeatures %})
* [CRuby Committers Who's Who in 2013]({% post_url articles/0044/2013-09-30-0044-CRubyCommittersWhosWho2013 %})
* [【九周年記念企画】 Rubyist Magazine へのたより]({% post_url articles/0044/2013-09-30-0044-Comments %})
  * [Rubyist Magazine 九周年]({% post_url articles/0044/2013-09-30-0044-EditorComment %})


本稿の冒頭でも少し触れましたが、個別記事のほとんどが RubyKaigi や地域 Ruby 会議の発表後に「記事にしませんか？」とお願いして生まれた記事となります。カンファレンスで発表するだけでなく、ぜひ記事という形で残してみてはいかがでしょうか。

また「パーフェクト Ruby」の書籍紹介記事がありました。Ruby に関する書籍を執筆された方は、書籍紹介記事を投稿いただけると Rubyist への宣伝になりますので、是非るびまへの投稿をお待ちしております (るびま読者プレゼント向けの献本も受け付けておりますので、その際はるびま編集部までご相談ください) 。

* [書籍紹介 『パーフェクト Ruby』]({% post_url articles/0043/2013-07-31-0043-BookPerfectRuby %})


最後に、新企画としてアクセスランキングの記事があります。ランキングを見ると「書かれた時期はけっこう前なのに、未だに関心の高い記事」が見えてきますので、最新の状況を踏まえてそうした記事のアップデート版を執筆したいという方は、ぜひるびま編集部までご連絡ください。

* [0044 号 アクセスランキング]({% post_url articles/0044/2013-09-30-0044-RubyistMagazineRanking %})


9 年間で 44 号ということで、平均 4.889 回リリース/年（去年は 4.875 回リリース/年）。特別号や号外、エイプリルフールを入れると 51 回リリースなので、5.667 回リリース/年。記事数は特別号を入れて 597 記事で、66.333 記事/年ということになります。

## 今後

各記事のふりかえりは以上になりますが、それ以外に大きく変わったのが編集体制です。今までのるびまの編集体制は主にメーリングリストにより行われていましたが、0041 号からは [GitHub Issues を活用した編集](https://github.com/rubima/rubima/issues)へと移行しました。これにより今まで埋もれてしまいがちであった課題がきちんと見えるようになり、編集も進めやすくなったのではないでしょうか。

万年編集者不足の状況については相変わらずですが、ここ一年でメーリングリストに協力を申し出ていただける方が数名いらしたのと、今年の RubyKaigi にて声掛けを行ったところ、数名の方に編集に参加していただけることになりました。今後の活躍に期待したいところです。

進捗管理は GitHub Issues ベースとなったものの、るびま自体は Hiki で動いているため、記事の執筆については最終的には Hiki フォーマットにする必要があるのが悩ましい所です。GitHub を使い慣れた方であれば Markdown を利用したいでしょうし、最後の仕上げは複数人で仕上がり状況を見ながら共同編集したいということもあるでしょうし、まだまだシステム上で解決すべき課題がいくつかありますが、手が回っていないという状況です。こうしたことも引き続き走りながら解決していくしかなさそうですね。

[るびまで利用している Hiki 自体](https://github.com/rubima/hiki)や [Hiki のテーマ](https://github.com/rubima/hiki-theme)、[Hiki のプラグイン](https://github.com/rubima/hiki-plugin)といったコードは GitHub 上でオープンソースとして公開していますので、不具合などを見つけたり改善の提案をされたいという方は、ぜひ Pull Request を送っていただけると助かります。

そんな感じで以前と比べてだいぶるびまへの貢献はカジュアルにできるようになりつつありますので、「編集者になる」とまではいかなくても、気軽に Rubyist Magazine に関わる人が増えていくといいなあ、と思いつつ、今後の展望の結びにしたいと思います。

## おわりに

るびまは 9 周年を迎えました。ありがたいことです。あと 1 年で 10 年となります。なかなか上手くいかないこともありますが、今後とも続けていけるといいですね。

というわけで、こんなるびまに、記事書いてみませんか？　もしくは、編集者になって、記事を編集してみませんか？

## 著者について

### 郡司啓 ([@gunjisatoshi](https://twitter.com/gunjisatoshi))

ふつうの Rubyist Magazine 編集者。今年は編集ばかりしていてあまり記事を投稿できなかったので、次の 1 年はもっと記事を投稿できるように頑張ります。


