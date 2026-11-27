---
layout: post
title: RegionalRubyKaigi レポート (90) 関西 Ruby 会議 08
short_title: RegionalRubyKaigi レポート (90) 関西 Ruby 会議 08
post_author: ydah
tags: KansaiRubyKaigi08Report regionalRubyKaigi
created_on: 2025-10-26
---
{% include base.html %}

## RegionalRubyKaigi レポート (90) 関西 Ruby 会議 08

* 日時：2025 年 6 月 28 日 (土) 10:00〜18:40
* 場所：先斗町歌舞練場
* 主催：AKASHI.rb (アカシアールビー)、Hirakata.rb (ヒラカタアールビー)、KOBE.rb (コウベアールビー)、Kyobashi.rb (キョウバシアールビー)、Kyoto.rb (キョウトアールビー)、naniwa.rb (ナニワアールビー)、Ruby 関西 (ルビーカンサイ)、Ruby 舞鶴 (ルビーマイヅル)、Ruby Tuesday (ルビーチューズデイ)、Shinosaka.rb (シンオオサカアールビー)、Wakayama.rb (ワカヤマアールビー)
* 後援：日本 Ruby の会
* 公式タグ・ Twitter：[#kanrk08](https://x.com/hashtag/kanrk08)
* オフィシャルグッズ：[https://suzuri.jp/kyobashirb](https://suzuri.jp/kyobashirb)

![全体写真.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/全体写真.jpg)

## 関西 Ruby 会議 08 について

関西 Ruby 会議 08 は、2025 年 6 月 28 日 (土) に京都の[先斗町歌舞練場](https://www.kamogawa-odori.com/kaburenjou/) で開催された関西地域の Ruby 技術カンファレンスです。[関西 Ruby 会議 2017](https://regional.rubykaigi.org/kansai2017/) 以来、8 年ぶりに「関西 Ruby 会議」の名称で復活を果たしました。この間、「大阪 Ruby 会議」として開催されていましたが、今回は関西の他府県の地域 Ruby コミュニティとの共催という形での再開となりました。
AKASHI.rb、Hirakata.rb、KOBE.rb、Kyobashi.rb、Kyoto.rb、naniwa.rb、Ruby 関西、Ruby 舞鶴、RubyTuesday、Shinosaka.rb、Wakayama.rb の 11 のコミュニティが主催団体として名を連ねました。参加費は無料で、300 名を超える参加登録がありました。

今回のテーマは「Ruby と作ろう」。これまで Ruby で作ってきたもの、作っているものを大小問わず共有し、知的好奇心を刺激し、新たなつながりを生む場となることを目指して開催されました。

## 関西 Ruby 会議 08 Day0 晩餐会について

本編前日の 6 月 27 日 (金) 19:00 から 21:30 まで、株式会社アンドパッド様が Drinkup スポンサーとして主催する「Day0 晩餐会」が開催されました。会場は京都市下京区四条大橋西詰にある[東華菜館本店](https://www.tohkasaikan.com/) さんでした。

東華菜館は、京都でも有数の歴史ある中華料理の老舗で、建物はアメリカの著名な建築家ウィリアム・メレル・ヴォーリズが設計したスパニッシュ・バロック様式の 5 階建てです。ヴォーリズは、アニメ「けいおん！」の聖地として知られる豊郷小学校旧校舎群の設計も手がけた建築家で、東華菜館の建物は部屋ごとに装飾や家具の意匠が異なり、どの部屋も素晴らしい空間となっています。

また、建物には日本最古のエレベーター (現役で稼働中) があり、鴨川のすぐ横という立地も相まって、京都らしい特別な雰囲気を味わえる場所です。森見登美彦氏の小説「有頂天家族」にも登場する名所で、運営スタッフからは「京都に馴染みのない方にぜひ行ってもらいたいお店の 1 つ」として紹介されていました。

前日から関西 Ruby 会議 08 に参加する方々が集まり、交流を深める場となりました。和やかな雰囲気の中で美味しい中華料理とお酒を楽しみながら、前日から関西 Ruby 会議 08 の雰囲気を堪能できる特別なイベントとなりました。

![晩餐会.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/晩餐会.jpg)

## 前夜祭 RejectKaigi について

本編の前日となる 6 月 27 日 (金) 19:00 から、株式会社はてな様の京都オフィスで「関西 Ruby 会議 08 前夜祭 RejectKaigi」が開催されました。想定を大きく超える数のプロポーザルをいただき、不採択とするにはあまりにも惜しい「この話を聞きたい！」と感じるものが多数ありました。そこで、関西 Ruby 会議 08 では前夜祭として、RejectKaigi を開催することを決定しました。

![RejectKaigi.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/RejectKaigi.jpg)

### RejectKaigi 発表

#### Ruby でやりたい駆動開発

* 発表者
  * Miyuki Koshiba 氏 ([@ksbmyk](https://x.com/chobishiba))
* スライド
  * https://speakerdeck.com/chobishiba/ruby-driven-development

「Ruby でやりたい」という純粋な衝動にかられて、紆余曲折しながらも作りきった個人開発事例を 2 つ紹介する発表でした。電子工作で[PicoRuby](https://github.com/picoruby/picoruby) を動かすところから始まり、気づいたら C を書いていて「Ruby で書きたいだけなのになぜ C を書いているのか」という状況に陥った経験も語られました。

個人開発だからこそ許される「その技術要素が好きだから」という動機から始まり、いろいろな壁にぶつかってもすべてを学びに変えて突き進んでいく様子が圧巻で、聞いていて非常におもしろい内容でした。クリエイティブコーディングと Ruby を組み合わせた開発事例も含まれており、「Ruby でやりたい」の力の偉大さを示す発表でした。

![ksbmyk.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/ksbmyk.jpg)

#### RubyGem 開発で鍛えるソフトウェア設計力

* 発表者
  * joker1007 氏 ([@joker1007](https://x.com/joker1007))
* スライド
  * https://speakerdeck.com/joker1007/rubygemkai-fa-deduan-erushe-ji-li

抽象的になりがちな「設計力」という概念を、rubygem 開発という具体的な実践方法と結びつけて説明している発表でした。

印象的だったのは、「IT システムとはデータ入出力の集合体」という割り切った定義です。一見単純に見えますが、この視点に立つことで、複雑なシステムも「何を入力して何を得たいのか」という本質に立ち返って考えられるようになります。joker さん自身も「異論はあると思う」と前置きしていましたが、思考の出発点としては非常に有用だと思います。

![joker1007.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/joker1007.jpg)

#### ruby.wasm で多人数リアルタイム通信ゲームを作ろう

* 発表者
  * lni_T / ルニ 氏 ([@lnit](https://x.com/lni_T))
* スライド
  * https://speakerdeck.com/lnit/kansairubykaigi08-wasm-websocket

[ruby.wasm](https://github.com/ruby/ruby.wasm) を使ってリアルタイム通信機能を実装した多人数ゲームの事例を紹介する発表でした。実際に作った多人数リアルタイム通信ゲームのデモをその場で実演されました。

Canvas + Web Audio API + αを組み合わせてブラウザ上でデモが動作し、参加者がゲームに夢中になっていました。ただし、iOS では「Maximum call stack size exceeded」のエラーが発生して動作せず、iOS では wasm が動かないという既知の課題も共有されました ( https://github.com/ruby/ruby.wasm/issues/532 )。Ruby で作れるものが増えていくのはとても楽しいことですし、自分も wasm に触って何かやってみよう！　と思える内容でした。

![lnit.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/lnit.jpg)

#### DJ on Ruby Ver.0.1

* 発表者
  * クドウマサヤ 氏 ([@msykd](https://x.com/masaya_dev))
* スライド
  * https://speakerdeck.com/msykd/250627-guan-xi-rubyhui-yi-08-qian-ye-ji-rejectkaigi-dj-on-ruby-ver-dot-0-1

CFP 駆動開発で DJ ソフトウェア「Vibes(バイブス)」を作ったお話とデモの発表でした。LLM ( Claude Code ) の助けを借りながら Ruby + Rust を使って Mac の GUI アプリケーションを開発しました。

音声ファイルの取り扱いや、DJ というユースケースでは音が途切れることを絶対避けたいという要求から、厳格なスループットを求めて GC のある Ruby ではなく Rust を技術選択した理由が説明されました。参加者に DJ 経験者が数名いらっしゃったこともあり、盛り上がる内容でした。[RubyKaigi 2025](https://rubykaigi.org/2025/) で関西 Ruby 会議 08 の存在を知り、「なんか楽しそう」という衝動に突き動かされて登壇を決意。RejectKaigi がなければ開発はここまで進めていなかったとのことで、さまざまな kaigieffect が連鎖した結果だと語られていてとても良い話だなと感じました。

![msykd.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/msykd.jpg)

## 関西 Ruby 会議 08 会場について

会場となった先斗町歌舞練場は、大正 14 年 ( 1925 年) 着工、昭和 2 年 ( 1927 年) 完成という歴史ある建物です。普段は鴨川をどりの会場として使用される格式高い空間で、桟敷席も含む和の風情が漂う特別な場所でした。ちょうど映画「国宝」のロケ地としても使用されたばかりで、非常に話題となっていました。

歌舞練場前に設置したのぼり旗や、寄席文字書家の[春亭右乃香先生](http://yose-moji.jp/) による「めくり」(登壇者名表示) や出囃子など、和の演出も凝らし、京都らしい雰囲気の中で Ruby について語り合う特別な一日となりました。

![会場写真.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/会場写真.jpg)

![のぼり旗.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/のぼり旗.jpg)

![提灯.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/提灯.jpg)

### Opening Talk

* 発表者
  * ydah ([@ydah](https://x.com/ydah_))
* 出囃子
  * Living In My Skin / HEY-SMITH

関西 Ruby 会議 08 の開催の挨拶をいたしました。法被を着用して飴を撒きながら登場するという伝統的な大阪スタイルのオープニングをさせていただきました。

![OpeningTalk.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/OpeningTalk.jpg)

#### Witchcraft for Memory (基調講演)

* 発表者
  * Masataka Kuwabara 氏 ([@pocke](https://x.com/p_ck_))
* スライド
  * [https://speakerdeck.com/pocke/witchcraft-for-memory](https://speakerdeck.com/pocke/witchcraft-for-memory)
* 出囃子
  * 魔法の人 / 奥華子

pocke さんによる基調講演で、[RBS](https://github.com/ruby/rbs) と[Steep](https://github.com/soutaro/steep) におけるメモリ使用量削減の取り組みについて詳細に解説されました。発表は大きく 2 つのパートに分かれており、前半ではメモリプロファイリングツール「[Majo](https://github.com/pocke/majo)」の開発について、後半では Steep における Refork 機能によるメモリ削減の取り組みについて紹介されました。

従来の[memory_profiler](https://github.com/SamSaffron/memory_profiler) gem では、steep check コマンドのピーク時のメモリ使用状況を正確に把握することが困難でした。そこで pocke さんは、生存期間が長いオブジェクトにフォーカスした新しいメモリプロファイラー「Majo」を自作しました。Majo の特徴は、GC を一定回数生き残ったオブジェクト (長生きしているオブジェクト) のメモリ使用状況を出力することで、ピーク時のメモリ使用量をより正確に把握できる点です。
実装面では、TracePoint API を利用して GC 実行開始をフックし、GC 実行中は GC を走らせてはいけないという制約があるため、C 言語の構造体に情報を保持し、結果表示時にはじめて Ruby オブジェクトに変換するという工夫が施されています。この手法により、RBS のメモリ使用状況を調査し、Hash の重複生成削除で 13%のメモリ使用量削減などの成果が得られました。

後半では、Steep のメモリ使用量をさらに削減するための Refork 機能について解説されました。Refork 機能では、worker プロセスからさらに worker プロセスを fork する方式に変更することで、親プロセス－子プロセス－孫プロセスの 3 層構造となりました。これにより、Copy on Write が効果的に機能し、メモリ使用量を 55%、約 4.1GB もの削減に成功されたとのことです。自身のユースケースを満たすためにメモリプロファイラーを自作し、実際にメモリ使用量削減まで達成されているのは素晴らしいなと感じました。

![pocke.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/pocke.jpg)

#### 「富岳」と研究者を Ruby でつなぐ：シミュレーション管理ツール OACIS

* 発表者
  * 村瀬洋介 氏 ([@yohm](https://x.com/yohm13))
* 出囃子
  * 笑点のテーマ

本発表では、スーパーコンピューター「富岳」と研究者をつなぐシミュレーション管理ツール「OACIS」について紹介されました。OACIS は、Ruby on Rails で構築されたシミュレーションや数値計算の実行・結果管理を行うツールとのことです。Web サービスというよりも GUI ソフトウェア的な位置づけで、研究者が手元で実行できる設計となっているそうです。

OACIS はあくまでシミュレーション管理のためのツールであり、実際のシミュレーション実行環境や言語 ( C、C++、Fortran など) はさまざまです。そのため、実際の実行時にはシェルスクリプトを動的に生成して実行する仕組みが採用されています。
発表の中でとくに印象的だったのは、「Ruby をシミュレーションに使うことは実行速度の関係であまりないが、Ruby の柔軟性と生産性が研究者とスパコンを繋いでくれる」という言葉でした。計算処理そのものではなく、管理ツールとしての Ruby の強みが活かされている事例で凄くいい話だなと感じました。

![yohm.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/yohm.jpg)

#### 「1 ヶ月で Web サービスを作る会」で出会った rails new、そして今に至る rails new

* 発表者
  * 桐生あんず (kiryuanzu) 氏 ([@Kiryuanzu](https://x.com/anzu_mmm))
* スライド
  * [https://speakerdeck.com/kiryuanzu/kansai-rubykaigi08-kiryuanzu](https://speakerdeck.com/kiryuanzu/kansai-rubykaigi08-kiryuanzu)
* 出囃子
  * 閃光少女 / 東京事変

桐生あんずさんによる個人開発の実践的な発表です。過去の「1 ヶ月で Web サービスを作る会」での経験から、現在進行形のポッドキャスト配信サービス開発まで、個人開発を継続するための心構えと実践的なアプローチが語られました。
2025 年 1 月の東京 Ruby 会議 12 の後夜祭で、関西 Ruby 会議 08 の運営メンバーから「関西にいるこれからエンジニアになろうとしているような人にも響くような発表がほしい」という話を聞き、自身の個人開発の経験を話すことを決意されたとのことです。

発表の核心は「小さく、速く、そして個人的なローンチ」という考え方です。完璧を求めすぎず、自分が使いたいものを作り、まずリリースすることの重要性が強調されました。具体的には、自分が本当に使いたいものを作る (モチベーション維持)、完璧を求めすぎず動くものを早くリリースする、登壇駆動開発で締切を作ることで開発を進める、技術選定も自分の好みを優先してよい (個人開発だから)、といったポイントが共有されました。Web サービスを作りきってリリースすることで語ることができる話であり、個人開発の醍醐味が伝わるお話でした。

![kiryuanzu.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/kiryuanzu.jpg)

#### mruby と micro-ROS が繋ぐロボットの世界

* 発表者
  * 影山勝彦 氏 ([@kishima](https://x.com/kishima))
* スライド
  * [https://speakerdeck.com/kishima/mrubyto-micro-rosgaxi-gurobotutonoshi-jie](https://speakerdeck.com/kishima/mrubyto-micro-rosgaxi-gurobotutonoshi-jie)
* 出囃子
  * 魔導研究所 / Final Fantasy VI より

本発表では、組み込みデバイス向けの Ruby 実装である mruby と、ロボット制御システムで使われる ROS 2 のマイコン対応版である micro-ROS を組み合わせたロボット開発について紹介されました。
micro-ROS は、ROS 2 ( Robot Operating System 2 ) をマイコン上で動作させるためのミドルウェアとクライアントライブラリとのことです。従来、ロボット制御システムとマイコンの世界は分離していましたが、micro-ROS の登場により、マイコンも ROS 2 のエコシステムに統合できるようになったそうです。

発表では、mruby と micro-ROS を組み合わせることで、Ruby の記述性の高さと ROS の分散制御の利点を両立させる取り組みが紹介されました。ロボット制御という実用的な分野で、組み込みシステム特有の制約 (メモリ、リアルタイム性など) と向き合いながら開発を進める様子が語られました。普段知らないロボット制御の世界を垣間見ることができ、興味深く聞かせていただきました。

![kishima.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/kishima.jpg)

#### ふだんの WEB 技術スタックだけでアート作品を作ってみる

* 発表者
  * Akira Yagi 氏 ([@akira888](https://x.com/w_e_b_coffee))
* スライド
  * [https://speakerdeck.com/akira888/hutuunoji-shu-sutatukudeatozuo-pin-wozuo-tutemiru](https://speakerdeck.com/akira888/hutuunoji-shu-sutatukudeatozuo-pin-wozuo-tutemiru)
* 出囃子
  * 花に亡霊 / ヨルシカ

本発表では、普段使い慣れた Web 技術スタック ( JavaScript、HTML、CSS 等) を使用してアート作品を制作する試みが紹介されました。Processing 等の専門的なツールではなく、日常的に業務で使用している技術で創造的な表現に挑戦する様子が紹介されました。発表では、具体的なアート作品の制作過程や技術的な実装方法が示されました。

Humans since 1982 の時計アート作品をオマージュして、アナログ時計の針の動きでパターンやデジタル時刻を表現するという作品を制作した事例が紹介されました。一見シンプルに見えますが、その裏には時計の位置によって役割を分け、マップを生成して配置を決定し、アニメーションとサーバー側の計算を分離するといった綿密な設計思想があり非常に興味深い内容でした。業務で触れない技術を存分に味わい、Rails を入れてもユーザーアクションを取らないアプリを作ってもいい――そんな自由な発想で物作りを楽しむ姿勢は非常に素敵だなと感じました。

![akira888.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/akira888.jpg)

#### Ruby と💪を作り込む - PicoRuby とマイコンでの自作トレーニング計測装置を用いたワークアウトの理想と現実

* 発表者
  * bash 氏 ([@bash0c7](https://x.com/bash0c7))
* スライド
  * [https://speakerdeck.com/bash0c7/gong-kai-ban-picorubytomaikontenozi-zuo-toreninkuji-ce-zhuang-zhi-woyong-itawakuautonoli-xiang-toxian-shi](https://speakerdeck.com/bash0c7/gong-kai-ban-picorubytomaikontenozi-zuo-toreninkuji-ce-zhuang-zhi-woyong-itawakuautonoli-xiang-toxian-shi)
* 出囃子
  * 恋の大三角関係 / 寺嶋由芙

本発表は、ウェイトトレーニングと Ruby の意外な共通点である「計測と改善の継続」をテーマに、ESP32 を搭載したマイコン ATOM Matrix 上で動作する PicoRuby で開発した自作トレーニング計測装置についての発表がありました。

Velocity Based Training (VBT) に基づく重量設定のために、トレーニングの挙上速度・挙上加速度という客観的データをリアルタイムに計測・分析するシステムの開発過程が共有されました。ウェイトトレーニングの分野では歴史的に「限界まで挙げる」といった主観的指標が用いられてきましたが、近年のセンサー技術の発展により「0.4m/秒で動く」といった客観的な動作データを扱えるようになりました。しかし専用機器は高価で個人レベルでは手が届きにくい状況にあるとのことです。

Ruby の柔軟性とマイコンの手軽さを組み合わせることで、高価な専用機器なしでも VBT を実現できると考え、実際に開発に取り組んだとのことです。試行錯誤しながら問題に直面しても分析して再挑戦する姿勢はとても勇気をもらえる内容だったなと感じました。

![bash0c7.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/bash0c7.jpg)

#### 分散オブジェクトで遊ぼう！　〜dRuby で作るマルチプレイヤー迷路ゲーム〜

* 発表者
  * yumu 氏 ([@myumura](https://x.com/myumura3))
* スライド
  * [https://speakerdeck.com/yumu/fen-san-obuziekutodeyou-bou-drubydezuo-rumarutipureiyami-lu-gemu-guan-xi-rubyhui-yi-08](https://speakerdeck.com/yumu/fen-san-obuziekutodeyou-bou-drubydezuo-rumarutipureiyami-lu-gemu-guan-xi-rubyhui-yi-08)
* 出囃子
  * 青空のラプソディ / fh á na

本発表では、Ruby 専用の分散オブジェクトシステムである dRuby を使用して、ブラウザで遊べるマルチプレイヤー迷路ゲームを作成した取り組みが紹介されました。
dRuby と WebSocket を組み合わせたリアルタイム通信や、マルチスレッドを使った効率的な処理など、Ruby ならではの書きやすさと読みやすさを活かした実装のポイントが紹介されました。発表では、シンプルなコードだけで複数プレイヤーが同時に遊べるゲームの基盤が作れることが示されました。

dRuby の「プロトコルを意識せず、Ruby のメソッド呼び出しとして書ける」という特徴が、ゲーム開発という複雑なドメインでどう活きるのか、その実例として非常に興味深い内容でした。

![myumura.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/myumura.jpg)

### Ruby で世界を作ってみる話

* 発表者
  * Akira Matsuda 氏 ([@amatsuda](https://x.com/a_matsuda))
* 出囃子
  * Legyőzhetetlen / Solaris

本発表は、Ruby のオブジェクト指向表現を用いて「世界」をモデリングし直すという、遊び心と技術的探究心に満ちたチャレンジでした。`class Atom`から始まり、電子や分子といった構成要素を定義していく中で、Ruby のクラスやモジュールを通じて現実世界を抽象化していく過程が示されました。まさにオブジェクト指向の原点に立ち返るような体験です。
中でも印象的だったのが、InChI 記法で記述された複雑な化学構造式を Ruby でパースする実装でした。構文と意味の「橋渡し」としてのプログラムの美しさがあり、DSL 的な発想としても非常に刺激的な内容となりました。さらに、Git の履歴を使って世界の始まり (ビッグバン) まで遡ろうと試みるも、1970 年が技術的な限界だったというオチには、会場から笑いが起こりました。

業務アプリの枠を超え、Ruby という言語の表現力を最大限に活かして「世界を再構築する」という視点は、コードを書く楽しさや、創造する喜びをあらためて思い出させていただきました。

![amatsuda.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/amatsuda.jpg)

### Regional.rb and the Kyoto City

* パネリスト
  * 無双、sago35 from AKASHI.rb
  * sanfrecce_osaka from Hirakata.rb
  * youcune from KOBE.rb
  * hachi、ydah from Kyobashi.rb
  * luccafort、onk from Kyoto.rb
  * おごもり from Ruby 関西/naniwa.rb
  * znz from Ruby 関西
  * 107steps from Ruby 舞鶴
  * toshima66 from RubyTuesday
  * むらじゅん from Shinosaka.rb
  * たろサ from Wakayama.rb
* 司会
  * pastak from Kyoto.js
* スライド
  * [https://speakerdeck.com/ydah/regionalrb-and-the-kyoto-city](https://speakerdeck.com/ydah/regionalrb-and-the-kyoto-city)
* 出囃子
  * ハートスランプ二人ぼっち / 円広志

探偵ナイトスクープのオープニングパロディから始まるという演出で始まった、関西圏の地域 Ruby コミュニティのオーガナイザーが一堂に会したパネルディスカッションで、各コミュニティの活動内容や、長く続けるための工夫について語り合われました。
各コミュニティの話を聞いていると「飲みの話」が多く、会場から「飲みの話しかしてないぞ！」というツッコミが入る場面もあり、和やかな雰囲気に包まれていました。

会場からの質問コーナーで「運営を続けるために工夫していることは？」という問いかけに対して、各オーガナイザーから出た答えは「頑張りすぎないこと」「1 人で背負い込まないこと」でした。それぞれのコミュニティの人たちが持続可能なペースを大事にしながら活動しているというメッセージは、これから地域コミュニティを始めようとしている方々に伝えたい大切な視点だと感じました。

![Regional.rb and the Kyoto City.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/Regional.rb-and-the-Kyoto-City.jpg)

#### Ruby を使った 10 年の個人開発でやってきたこと (基調講演)

* 発表者
  * Koji Shimba 氏 ([@shimbaco](https://x.com/shimbaco))
* スライド
  * [https://speakerdeck.com/shimbaco/rubywoshi-tuta10nian-noge-ren-kai-fa-teyatutekitakoto](https://speakerdeck.com/shimbaco/rubywoshi-tuta10nian-noge-ren-kai-fa-teyatutekitakoto)
* 出囃子
  * 神様のいうとおり / いしわたり淳治&砂原良徳+やくしまるえつこ

仕事では Ruby on Rails を使用した Web アプリケーション開発に携わり、休日も Rails を使って個人開発を行っている shimbaco さんによる基調講演でした。現在はアニメ視聴記録サービス「Annict」、マイクロブログサービス「Mewst」、Wiki サービス「Wikino」など、複数のサービスを開発・運営されています。この 10 年間の個人開発の経験から得た知見を共有する内容でした。

印象的だったのは「自分が欲しいものを作っても意外と使ってもらえる」という考え方です。「誰もいらないんじゃないか、無駄になるかも」と悩むよりも、「意外と使ってもらえるし、自分が便利に使えるからよし」という気楽さで始めるのが良いというメッセージは、多くの方の心に響いたのではないかと思います。たとえ利用者が自分だけでも、「自分だけは使えるんだからそれでいいじゃないか」という考えは、個人開発を始める上での精神的なハードルを大きく下げるものだったように感じます。
発表では、実際に開発した 3 つのサービス ( Annict、Mewst、Wikino ) それぞれが「自分がほしい」と思ったものがきっかけになっていることが語られていました。

また、後半では技術的な話として紹介されていたクラス設計の話も非常に興味深く、パターンを利用する際にその目的が漠然としていたり、表面的な部分だけを取り入れてしまっていたという話は自分の経験とも重なり非常に共感していました。なかなか、他の方が実践の中で得たクラス設計の話を聞ける機会は少ないなと感じていて、非常に楽しく聞かせていただきました。

![shimbaco.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/shimbaco.jpg)

#### クロージング

* 発表者
  * ydah ([@ydah](https://x.com/ydah_))
* 出囃子
  * RIVER / 10-FEET

クロージングでは、関西 Ruby 会議 08 についての思いを述べさせていただきました。

また、次回の関西 Ruby 会議の開催地を決定する開催地決めダーツも行われました。
参加者が思い思いの地名をコールする中、ダーツが刺さったのは「滋賀県」でした。来年の開催地が決定し、会場から大きな拍手が起こりました。
さらに、幕が降りた後に会場からアンコールが起こり、オーガナイザー全員がドギマギしながら幕が上がるという一幕もあり、和やかな雰囲気で関西 Ruby 会議 08 の本編が終了しました。

![クロージング.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/クロージング.jpg)

![めくりとオーガナイザー.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/めくりとオーガナイザー.jpg)

## オフィシャルパーティ

関西 Ruby 会議 08 のオフィシャルパーティは、京都三条にあるレストラン[IND É PENDANTS](https://cafe-independants.com/) さんで開催しました。
京都市の登録有形文化財である[1928 ビル](https://ja.wikipedia.org/wiki/1928%E3%83%93%E3%83%AB) の中にあります。この建物は「関西建築界の父」と称される建築家・武田五一氏によって設計されたもので、歴史的な雰囲気が漂う素敵な空間でした。

突発的な感想を聞くコーナーも設けられ、参加者の皆さんから関西 Ruby 会議 08 の感想を自由に語っていただきました。また、多くの方にご参加いただき、和やかな雰囲気の中で交流を深めることができました。美味しい料理とお酒を楽しみながら、関西 Ruby 会議 08 の思い出を語り合う素敵な時間となりました。

![オフィシャルパーティ.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/オフィシャルパーティ.jpg)

## 「川」

Ruby コミュニティにおける「川」が何かということについては[こちらのまとめ](https://scrapbox.io/ruby-jp/%E5%B7%9D) を見ていただくのが良いと思います。
RubyKaigi 2016 から 9 年の時を経て、the origin の「川」を体験いただけたのではないかと思います。遅くまで多くの方が残って交流されている様子があり、楽しんでいただけたのではないかと感じています。

![川.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/川.jpg)

## 関西 Ruby 会議 08 After Party : 叡電 LT

関西 Ruby 会議 08 では After Party として、翌日に株式会社 6VOX 様のご協力を得て、[叡山電車](https://eizandensha.co.jp/)を 1 両まるごと貸し切ってライトニングトークを行うという特別企画が開催されました。京都の出町柳から八瀬・鞍馬へ走る叡山電鉄 (叡電) での開催で、6 月下旬は新緑が美しく、川沿いの景色が楽しめる時期です。参加者は叡電の車内でライトニングトークを楽しみながら、京都の自然豊かな風景を満喫しました。

発表形式は車内放送用のマイクを使い、2〜3 駅区間ごとに交代しながら発表する形式でした。通常の LT と異なり、発表時間が駅間によって変動し、プロジェクターが使えないため、スマホで資料を見たり、紙に印刷したり、iPad やモバイルモニターを使うなど、各自工夫して発表されていました。限られた時間と環境の中で発表するという特殊な状況が、参加者にとって新鮮で刺激的な体験となりました。

印象的だったのは、[@makicamel](https://x.com/makicamel) さんの「[PicoRuby on Rails](https://speakerdeck.com/makicamel/picoruby-on-rails)」という発表で、電車の床にプラレールを組み立てて走らせるという「LT で平面 (床) を使う」という斬新な発想の発表でした。車内という限られた空間を活かし、参加者全員が楽しめる内容となっていました。
動いている電車の中で Ruby に関するトークイベントが行われるというのは得難い体験だったと思います。参加者同士の交流も深まり、関西 Ruby 会議 08 の余韻を楽しむ素晴らしい機会となりました。

![叡電.jpg]({{base}}{{site.beseurl}}/images/0065-KansaiRubyKaigi08Report/叡電.jpg)

## ご協賛頂いた企業・団体様

[株式会社アジャイルウェア](https://agileware.jp/) [株式会社永和システムマネジメント](https://esm.co.jp/) [フリー株式会社](https://www.freee.co.jp) [株式会社インゲージ](https://ingage.co.jp/) [株式会社ナレッジラボ](https://knowledgelabo.com/) [ポノス株式会社](https://www.ponos.jp/) [株式会社Ruby開発](https://www.ruby-dev.jp/) [株式会社SmartHR](https://smarthr.co.jp/) [株式会社アンドパッド](https://engineer.andpad.co.jp/) [Tebiki株式会社](https://tebiki.co.jp/) [株式会社タイミー](https://corp.timee.co.jp/) [株式会社Degica](https://ja.komoju.com/company/) [株式会社はてな](https://hatena.co.jp/) [株式会社マネーフォワード](https://corp.moneyforward.com/) [株式会社6VOX](https://6vox.com/) [株式会社スタメン](https://stmn.co.jp/) [エースチャイルド株式会社](https://www.as-child.com/) [株式会社コードタクト](https://codetakt.com/) [株式会社Gaji-Labo](https://www.gaji.jp/) [#local_tech](https://localtechjp.notion.site) [株式会社ロッカ](https://lokka.jp/) [株式会社mov](https://mov.am/) [株式会社ネットワーク応用通信研究所](https://www.netlab.jp/) [東京Ruby会議12 実行委員一同](https://regional.rubykaigi.org/tokyo12/) [株式会社TwoGate](https://twogate.com/) [株式会社ザルファ](https://xalpha.jp/) [合同会社ユーキューブ](https://youcube.jp/)

## 著者について

### 高田 雄大 ([@ydah](https://x.com/ydah_))

関西 Ruby 会議 08 チーフオーガナイザー。Ruby とビールが好き。

### Special Thanks

本記事の執筆にあたり、フォトグラファーとして関西 Ruby 会議 08 の運営に参加いただいた [@youcune](https://x.com/youcune) さんと [@hachiblog](https://x.com/hachiblog) さんに写真を提供いただきました。ありがとうございました。
