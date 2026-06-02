---
layout: post
title: mruby Girls Matsue 1st 開催レポート
short_title: mruby Girls Matsue 1st レポート
tags: 0066 mrubyGirlsReport
post_author: chobishiba
created_on: 2026-05-03
---

## mruby Girls Matsue 1st とは

PicoRuby の作者である [hasumikin](https://x.com/hasumikin) さん、Rails Girls Japan の [emorima](https://x.com/emorima) さん、そして LED で光らせることを楽しんでいた私 chobishiba の 3 人で組み込み Ruby プログラミングのコミュニティ「mruby Girls」を立ち上げました。

まずは、Ruby の聖地 松江から始めようと、[RubyWorld Conference 2025](https://2025.rubyworld-conf.org/ja/) の翌日 mruby Girls Matsue 1st を行いました。

初めての開催だったので、告知サイトもワークショップのガイドも一から用意しました。準備の舞台裏は [mruby Girls Matsue 1st を開催しました｜chobishiba｜note](https://note.com/chobishiba/n/n8edd9f890c0f) にまとめています。

## イベント概要
- 日時：2025 年 11 月 8 日 (土) 10:00〜16:00
- 場所：松江オープンソースラボ
- イベントページ：[https://mrubygirls.github.io/events/2025-11-08-matsue_1st](https://mrubygirls.github.io/events/2025-11-08-matsue_1st)

## イベント当日

### オープニング

なんと予定より 30 分早く参加者もコーチも集まったので前倒しで開始。

<img src="{{base}}{{site.baseurl}}/images/0066-mrubyGirlsMatsue1stReport/welcome-board.jpg" width="200px" alt="ウェルカムボード"> 

### まつもとゆきひろさんのトーク

まつもとさんがゲストに来てくださったので、 mruby の成り立ちについて語っていただきました。

2010 年頃、経済産業省の地域イノベーション事業をきっかけに、組み込み向けの「軽量 Ruby」(後の mruby) プロジェクトが始まった。5 年後にはマイクロコントローラーが普及するという未来予測を立てたものの、2015 年時点ではまだ 2KB メモリが主流でメモリ・電力の制約が厳しく動かなかったが、2018 年に ESP32 が普及して、ようやく mruby が動くようになったそうです。

制約のあるプログラミングの楽しさやまつもとさんの mruby への愛が語られ、最後に参加者へ「ホビープログラムとして楽しんでほしい」というメッセージをいただきました。

<img src="{{base}}{{site.baseurl}}/images/0066-mrubyGirlsMatsue1stReport/matz.jpg" width="500px" alt="まつもとさん"> 

### ワークショップ

今回は、[ATOM Matrix](https://docs.m5stack.com/ja/core/ATOM%20Matrix) という  LED、ボタン、加速度センサー一体型のデバイスを使って PicoRuby を体験するという内容にしました。はんだ付けも配線も不要で、すぐ始められます。

この日集まったのは組み込み初体験の方ばかり。スポンサー様のおかげで参加者にデバイスを配布することができました。皆さん"自分の"デバイスを手にスタート。

用意していた [Guide](https://mrubygirls.github.io/guides/esp32/) に沿ってまずは環境構築から。搭載されているマイコンが ESP32 なので、ESP-IDF を導入する必要がありました。一斉にそのリポジトリを `git clone` したため、少々時間がかかりましたが、その間自己紹介をしながら和やかに過ごしました。

その後は irb を使ってマイコン上で PicoRuby を動かし始めました。ボタンを使った値の読み取りや `loop` から抜ける操作をしてもらうと、自分の手でデバイスを動かしコードに影響を与えるおもしろさを実感してもらえたようです。

そしてついに L チカ。点灯した瞬間「わっ」と声があがってました。情操教育の始まりです。[^1]

<img src="{{base}}{{site.baseurl}}/images/0066-mrubyGirlsMatsue1stReport/led_blinking.jpg" width="500px" alt="L チカ"> 

あっという間にお昼休憩の時間となり、まつもとさんを囲んでのランチへ。

午後は、6 軸モーションセンサーを使って傾けたり速く動かすとどうなるかを体験してもらいました。

そして、ボタン・ LED ・ 6 軸モーションセンサーを組み合わせた LED アニメーションや、デジタル水準器をチュートリアルに沿って作ってみたあと、各自の作りたいものを作り込んでいく作業に入っていきました。

<img src="{{base}}{{site.baseurl}}/images/0066-mrubyGirlsMatsue1stReport/workshop.jpg" width="500px" alt="ワークショップの様子"> 

### 成果発表会

会の最後は参加者全員での発表会。同じデバイスを使っても作るものは人によって様々で、お互いの作ったものを見せ合いました。アニメーションや、電光掲示板のようにメッセージを出す方、ブロックをキャッチするゲーム、任意の数字で止めるスロットなど、まさに「自分だけのガジェット」を完成させていました。   

<img src="{{base}}{{site.baseurl}}/images/0066-mrubyGirlsMatsue1stReport/presentation.jpg" width="700px" alt="成果発表会の様子">

## さいごに

ワークショップ終了後も、会場が使える時間いっぱいまで制作に励んだ方、家に帰ってからもデバイスで作品を作った方、後日他のセンサーと組み合わせて自分の欲しいものを作っていった方もいました。やったことがないところからはじまり、自分の好きなものを形にしていく姿を見て、本当に開催してよかったなと思います。

当日は見学の方も多かったので、何か次の取り組みにつながっていくといいなと思っています。

PicoRuby は今どんどん開発が進んでいて、始めやすくなっています。[mruby Girls](https://mrubygirls.github.io/) のサイトでもガイドを更新していくので、ぜひみなさんも PicoRuby をはじめてみてください。

<img src="{{base}}{{site.baseurl}}/images/0066-mrubyGirlsMatsue1stReport/group-photo.jpg" width="500px" alt="集合写真">

## 書いた人
### chobishiba([@chobishiba](https://x.com/chobishiba)) 

Rubyist & Creative Coder

----

[^1]: 前日の RubyWorld Conference 2025 の hasumikin さんの発表『PicoRuby をはじめるグッドタイミング』の中で「[L チカは情操教育](https://2025.rubyworld-conf.org/files/p30-3.pdf)」という言葉が紹介されていたため、ワークショップ中もそこかしこで「情操教育だ」「これは確かに情操教育」と話題に。