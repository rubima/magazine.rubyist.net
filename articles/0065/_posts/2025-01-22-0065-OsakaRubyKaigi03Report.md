---
layout: post
title: RegionalRubyKaigi レポート (88) 大阪 Ruby 会議 03
short_title: RegionalRubyKaigi レポート (88) 大阪 Ruby 会議 03
post_author: ydah
tags: OsakaRubyKaigi03Report regionalRubyKaigi
created_on: 2025-01-22
---
{% include base.html %}

## RegionalRubyKaigi レポート (88) 大阪 Ruby 会議 03

* 日時：2023 年 9 月 9 日 (土) 10:00〜20:50
* 場所：ハートンホテル心斎橋別館 松風ホール
* 主催：Ruby Tuesday (ルビーチューズデイ)
* 後援：Ruby 関西 (ルビーカンサイ)、日本 Ruby の会
* Togetter まとめ： [https://togetter.com/li/2221531](https://togetter.com/li/2221531)
* 公式タグ・ Twitter：[#osrb03](https://twitter.com/hashtag/osrb03)

![01_all.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/01_all.jpg)

## 大阪 Ruby 会議とは

2018 年 7 月 21 日 (土) に大阪 Ruby 会議 01 がはじめて開催されました。以前までは関西 Ruby 会議という名前で開催していましたが、より地域に密接した Ruby 会議にしようというということになり、ローカルな大阪 Ruby 会議として開催されました。

2019 年の大阪 Ruby 会議 02 から早 4 年。長かったコロナ禍を乗り越え、大阪 Ruby 会議を再開することができました。
心の底から笑い合える日がまた来ることを願って、今年のテーマは「Ruby で笑おう」としました。

第 3 回となる今回は大阪市中央区にある[ハートンホテル心斎橋別館 松風ホール](https://www.hearton.co.jp/hotel/shinsaibashi) で開催しました。総勢 175 名 (運営スタッフ含む) の方にご参加いただきました。

## セッション (一部)

### Opening Talk

* 発表者
  * honeniq 氏 ([@honeniq](https://twitter.com/honeniq))

チーフオーガナイザーの honeniq さんから大阪 Ruby 会議 03 の開催の挨拶がありました。今回の Ruby 会議のテーマとロゴについて発表してくださいました。

![02_honeniq.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/02_honeniq.jpg)

### Enjoy Ruby programming, Enjoy Ruby community!

* 発表者
  * 伊藤 淳一 氏 ([@jnchito](https://twitter.com/jnchito))
* 資料
  * [スライド](https://speakerdeck.com/jnchito/enjoy-ruby-programming-enjoy-ruby-community)

最近、悩まれていることとしてリッチな UI を求められることが多い、例えばモーダルもその一つです。そんな時に Hotwire というを使うと、簡単にモーダルを作ることに感動した、この感動を共有したいということで、かつて DHH は 15 分でブログを作りましたが、伊藤さんは Hotwire を使って 15 分でモーダルを作るライブコーディングを行われました。

最後の 「楽しいと勝手にスキルも上がる」 というお言葉がとくに印象的でした。Ruby はコードを書くだけでも楽しいが、コミュニティに参加することでさらに楽しいのは、Ruby の魅力のひとつだと思います。

![03_jnchito.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/03_jnchito.jpg)

### GVL のお話

* 発表者
  * まつもと ゆきひろ 氏 ([@yukihiro_matz](https://twitter.com/yukihiro_matz))

Ruby の開発の 30 年間におけるハードウェアの変化について話し、その中でも特に大きな革新の一つとしてマルチコアプロセッサの登場がいかに影響を与えたか、という話から始まりました。

そこから GVL (Global VM Lock) の話題に移り、パフォーマンスへの影響について触れました。また、Python における GIL (Global Interpreter Lock) をオプション化する提案 [PEP 703](https://peps.python.org/pep-0703/) にも言及しました。その上で、Ruby では I/O バウンドや Web アプリケーション、C 拡張との比較において、GVL の影響はそれほど大きな問題ではないという見解が示されました。

![04_matz.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/04_matz.jpg)

### Lrama へのコントリビューションを通して学ぶ Ruby のパーサジェネレータ事情

* 発表者
  * Junichi Kobayashi 氏 ([@junk0612](https://twitter.com/junk0612))
* 資料
  * [スライド](https://speakerdeck.com/junk0612/lrama-henokontoribiyusiyonwotong-sitexue-bu-ruby-nopasazieneretashi-qing)

パーサーの話題は [RubyKaigi 2023](https://rubykaigi.org/2023/) 以降さらに注目を集めており、今回もその流れを受けて、 [Lrama](https://github.com/ruby/lrama) というパーサージェネレータにコントリビュートする過程で学んだことが共有されました。パーサーやパーサージェネレータの基礎知識から丁寧に解説されており、それらの仕組みを理解する上で非常に参考になる内容だったと思います。

後半では、Lrama の Named References という機能を作る過程が概説され、その実装を通じて知った Lrama の内部構造についての解説へとつながる構成になっていました。聴衆が迷子にならないよう工夫された、非常に分かりやすい内容でした。

![05_junk0612.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/05_junk0612.jpg)

### 複数の言語で同じ Web サービスを実装して技術特性の違いを見てみた

* 発表者
  * ONAKA Takafumi 氏 ([@onk](https://twitter.com/onk))
* 資料
  * [スライド](https://speakerdeck.com/onk/implementation-of-the-same-web-service-in-multiple-languages)

はてなさんの開発合宿では、参加者が複数のチームに分かれ、それぞれ異なるプログラミング言語を用いて同じお題の Web サービスを開発するという取り組みが行われました。この活動を通じて、各技術の特性の違いを見てみる、という趣旨のお話でした。

Rails を使ったチームでは、開発が非常に速く進んだものの、それは単に開発言語の性能差によるものではなく、事前にどれだけ素振り (経験や準備) ができているかが大きな要因である、という点が非常に印象的でした。この観点はとても興味深いと感じました。

この取り組みについては、はてなさんの開発者ブログでも紹介されています。ぜひこちらも読んでみると、合宿の雰囲気がより伝わるかと思います。

[https://developer.hatenastaff.com/entry/2023/06/14/110000](https://developer.hatenastaff.com/entry/2023/06/14/110000)

![06_onk.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/06_onk.jpg)

### Breaking the Flaky Test Cycle

* 発表者
  * willnet 氏 ([@willnet](https://twitter.com/netwillnet))
* 資料
  * [スライド](https://speakerdeck.com/willnet/breaking-the-flaky-test-cycle)

Flaky なテストの解決策について、willnet さんが実際に取り組んだ事例を紹介されました。Flaky なテストは、テストの信頼性を損なうだけでなく、CI が通るまでの作業を滞らせる問題を引き起こします。そのため、Flaky なテストの解消は非常に重要だという話から始まりました。

具体的な事例として、Capybara の要素のクリックミスを防ぐための設定や、失敗したテストのログだけを出力するための [gem](https://github.com/willnet/ci_logger) の紹介、さらに E2E テスト失敗時にブラウザの挙動を動画で確認できる仕組みが紹介されました。どれも非常に具体的で、実践的な内容でした。

![07_willnet.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/07_willnet.jpg)

### PicoRuby から始める たのしい電子工作

* 発表者
  * Takashi Ogomori 氏 ([@ogomr](https://twitter.com/ogomr))
* 資料
  * [スライド](https://speakerdeck.com/ogom/enjoy-ruby-electronic-programming)

Ruby で電子工作を楽しむためのお話で、[mruby](https://github.com/mruby/mruby) や [PicoRuby](https://github.com/picoruby/picoruby) の紹介から始まりました。
[R2P2](https://github.com/picoruby/R2P2) という PicoRuby で書かれたシェルシステム や [PRK Firmware](https://github.com/picoruby/prk_firmware) という DIY キーボード向けのファームウェアフレームワークなど、Ruby を使った電子工作に関連するツールやライブラリも紹介され、Ruby で楽しめる電子工作の情報が網羅的にまとめられていて、非常に参考になる内容でした。

また、PicoRuby のドキュメント整備はまだ十分に進んでいないそうですが、現在、新しいリファレンスマニュアルの計画が始動しているとのことです。今後の展開がとても楽しみです。

![08_ogomr.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/08_ogomr.jpg)

### Ruby ではじめるクリエイティブコーディング

* 発表者
  * 小芝 美由紀 氏 ([@chobishiba](https://twitter.com/chobishiba))
* 資料
  * [スライド](https://speakerdeck.com/chobishiba/creative-coding-starting-with-ruby)


プログラミングでビジュアルを作る、ジェネラティブアートにも通じるクリエイティブコーディングについてのお話でした。[RubyKaigi 2023 のロゴを使用した作品](https://x.com/chobishiba/status/1657310435266424834) をご覧になったことがある方もいらっしゃるのではないでしょうか。

クリエイティブコーディングの歴史や、Ruby でクリエイティブコーディングを楽しむためのツール、そして基本的な仕組みについて解説され、非常にわかりやすい内容でした。「役に立つことだけがプログラミングの意義ではない。気軽にプログラミングを楽しむのも良いのではないか。」というお言葉がとても印象的で、共感を覚えました。

![09_chobishiba.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/09_chobishiba.jpg)

### A Practitioner's Journey from Ruby 1.8 Era to Present

* 発表者
  * Koichi ITO 氏 ([@koic](https://twitter.com/koic))
* 資料
  * [スライド](https://speakerdeck.com/koic/a-practitioners-journey-from-ruby-1-dot-8-to-present)

Ruby 1.8 から現在に至るまでの Ruby の歴史を振り返り、その間に起きた変化や進化について話されました。
[tDiary](https://tdiary.org/) がキラーアプリだった時代、After Rails の時代、[YARV の登場](https://magazine.rubyist.net/articles/0006/0006-YarvManiacs.html)、光と闇の機能が追加された Ruby 2.0、エコシステムへの参加のきっかけとなった Ruby 2.4 ...と、時系列に沿った形式で話が展開されました。

Ruby の歴史とともに歩んできた koic さん自身の体験や、その中で感じたことが綴られた内容は非常に興味深く、Ruby の魅力を koic さんの目線で追体験できる素晴らしいお話でした。

![10_koic.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/10_koic.jpg)

### neovim で作る最新 ruby 開発環境 2023

* 発表者
  * Tomohiro Hashidate 氏 ([@joker1007](https://twitter.com/joker1007))
* 資料
  * [スライド](https://speakerdeck.com/joker1007/neovimdezuo-ruzui-xin-rubykai-fa-huan-jing-2023)


[Neovim](https://neovim.io/) を活用した開発環境の構築について、最新のプラグインやプロトコルを解説していただきました。
特に、LSP (Language Server Protocol) や DAP (Debug Adapter Protocol) を効果的に利用する方法を、具体的な設定例を交えて説明されており、Neovim を使った効率的な開発環境構築のヒントが満載でした。

DEMO を見ると、非常に開発がしやすそうで、普段 VSCode を使っている著者も Neovim に移行したくなる気持ちになりました。

![11_joker1007.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/11_joker1007.jpg)

### ブラウザから「今すぐ」 gem をロードする方法

* 発表者
  * lni_T / ルニ 氏 ([@lni_T](https://twitter.com/lni_T))
* 資料
  * [スライド](https://speakerdeck.com/lnit/load-gem-from-browser-just-now)

[ruby.wasm](https://github.com/ruby/ruby.wasm) で gem をロードする方法について、具体的な手法を解説していただきました。  
アプローチとしては、Bundling を用いてスクリプトを 1 ファイルにまとめる方法を選択し、`Kernel.caller_locations` を活用して `Kernel.require` にモンキーパッチを当てることで、gem のロードを実現されていました。

DEMO では、ブラウザ上で [Web Audio API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API) を使用し、自作のシンセサイザーで演奏を披露され、大いに盛り上がりました。波形データも Ruby で生成しているとのことで、非常に興味深い内容でした。

![12_lni_T.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/12_lni_T.jpg)

### Reboot of one of the Ruby Community

* 発表者
  * luccafort 氏 ([@luccafort](https://twitter.com/luccafort))
* 資料
  * [スライド](https://speakerdeck.com/luccafort/reboot-of-one-of-ruby-community)

コミュニティの価値や狙いを分析されており、その内容が非常に整理されていて、改めてコミュニティについて考えさせられるものでした。

コミュニティの価値はフェイズによって変わる。もし衰退しているのであれば、それはコミュニティの価値を見直すタイミングである。価値を変えられない場合、コミュニティを閉じるという選択肢もある。」という視点は非常に重要だと感じ、コミュニティの運営に携わる方々にとって参考となる内容でした。
[Kyoto.rb](https://kyotorb.connpass.com/) を引き継いだ理由については後に [Kyobashi.rb](https://kyobashirb.connpass.com/) での発表での発表でも話されていて、そちらも合わせてご覧いただくと良いと思います。

[Kyoto.rb のコミュニティを引き継いだ理由](https://scrapbox.io/kyobashirb/Kyoto.rb_%E3%81%AE%E3%82%B3%E3%83%9F%E3%83%A5%E3%83%8B%E3%83%86%E3%82%A3%E3%82%92%E5%BC%95%E3%81%8D%E7%B6%99%E3%81%84%E3%81%A0%E7%90%86%E7%94%B1)

![13_luccafort.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/13_luccafort.jpg)

### Building Tebukuro with Hotwire and Rails

* 発表者
  * むらじゅん 氏 ([@murajun1978](https://twitter.com/murajun1978))
* 資料
  * [スライド](https://speakerdeck.com/murajun1978/building-tebukuro-with-hotwire-and-rails)

過去に [Shinosaka.rb](https://shinosakarb.doorkeeper.jp/) にて、「プロダクトを運用しつつ、それを OSS として公開することで Rails の開発を楽しみながら OSS の敷居を下げられないか」という思いから、[Tebukuro](https://github.com/shinosakarb/tebukuro) というイベントのチケット管理プロダクトを作成されたという話から始まりました。

その後、この Tebukuro を Hotwire を用いて作り直した際に得られた知見を共有していただきました。実際の使用経験に基づく良い点と悪い点が示されており、Hotwire をこれから導入しようと考えている方にとって非常に参考になる内容でした。

![14_murajun1978.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/14_murajun1978.jpg)

### 技術書典で Rails の本を出す技術

* 発表者
  * Hayao Kimura 氏 ([@hachiblog](https://twitter.com/hachiblog))

技術書典で Rails の本を出すためのノウハウを共有していただきました。親族総出で技術書を作られたというエピソードがとても素敵で、心温まる内容でした。
また、収支が公開されており、技術同人誌作りの費用感など、これから技術書を出してみたいと考えている方にとって非常に参考になる内容でした。

実際に執筆された「Rails のコードを読む」という本は、以下から電子版を購入できるようです。

[https://techbookfest.org/product/mbD8MPYZsV0MU67LHfyhxJ?productVariantID=b68wv2YcHipWsKXQ1nrcSR](https://techbookfest.org/product/mbD8MPYZsV0MU67LHfyhxJ?productVariantID=b68wv2YcHipWsKXQ1nrcSR)

![15_hachiblog.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/15_hachiblog.jpg)

## セッション (二部)

今回は公式の懇親会はありませんでしたが、二部として豪華景品をかけたじゃんけん大会や LT 大会が開催されました。
長丁場となりましたが、二部ではお酒を片手に楽しむ方も多く、双方向のコミュニケーションがさらに活発になり、非常に盛り上がった雰囲気でした。

![16_janken.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/16_janken.jpg)

### RailsGirls のドキュメント翻訳について

* 発表者
  * maimu 氏 ([@maimux2x](https://twitter.com/maimux2x))
* 資料
  * [スライド](https://speakerdeck.com/maimux2x/about-rails-girls-document-translation)

RailsGirls のドキュメント翻訳について、その背景や翻訳の進め方、翻訳の成果などについて話されました。
2023 年の 4 月末には第一弾が反映されたとのことで、成果も着実に出されていて、非常に素晴らしい取り組みだと感じました。

![17_maimux2x.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/17_maimux2x.jpg)

### RAILS_ENV を統合する取り組み：開発用デプロイ環境をよりシンプルに

* 発表者
  * 明里 慶祐 氏 ([@akarin0519](https://twitter.com/akarin0519))
* 資料
  * [スライド](https://speakerdeck.com/akarin/rails-envwotong-he-suruqu-rizu-mi-kai-fa-yong-depuroihuan-jing-woyorisinpuruni)

デプロイ環境毎に作られてしまっていた、RAILS_ENV の統合についての取り組みについて話されました。
実際にどのように統合していったかを順を追って解説されており、非常に具体的でわかりやすい内容でした。

![18_akarin0519.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/18_akarin0519.jpg)

### スレッドとコールバックと実行コンテキスト

* 発表者
  * Andrey Novikov 氏 ([@Envek](https://twitter.com/Envek))
* 資料
  * [スライド](https://envek.github.io/osakarubykaigi-threads-callbacks/)

Ruby のブロックをコールバックとして扱う際に、その動作や複数スレッドで扱う場合の注意点について話されました。
途中でタイムアップとなってしまいましたが、非常に興味深く、最後まで聞きたくなる内容でした。

![19_Envek.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/19_Envek.jpg)

### OSS に PR を送ってからの心境の変化

* 発表者
  * おさと 氏 ([@osatohh](https://twitter.com/osatohh))
* 資料
  * [スライド](https://speakerdeck.com/osatoh/ossnipull-requestwosong-tutemite)

![20_osatohh.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/20_osatohh.jpg)

[gem_rbs_collection](https://github.com/ruby/gem_rbs_collection) に [rbs](https://github.com/ruby/rbs) の型を追加するパッチを送った際のお話でした。
その経験を通じて、より技術や Ruby に関心を持つようになったとのことで、とても素敵なエピソードでした。

### Slim を安全にあつかう

* 発表者
  * ydah ([@ydah](https://twitter.com/ydah_))
* 資料
  * [スライド](https://speakerdeck.com/ydah/slim-safety)

[slim](https://github.com/slim-template/slim) を安全に扱うために実際にどのような対策を行ったかを解説しました。

![21_ydah.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/21_ydah.jpg)

### コードレビューで学ぶ Ruby on Rails 続編

* 発表者
  * 田中 義人 氏 ([@tanaka4410](https://twitter.com/tanaka4410))
* 資料
  * [スライド](https://speakerdeck.com/yoshito/kodorebiyudexue-bu-ruby-on-rails-sok-bian-number-osrb03)

著書である「コードレビューで学ぶ Ruby on Rails」の続編として本に書ききれなかったことを紹介されました。
has_many の dependent は正しく使い分けよう、create と create! の使い分けなどなど、具体的なコード例を元に解説されていました。

書籍は以下から購入できるようです。

[https://techbookfest.org/product/50CLAnEpRNhFNKzgq1aK78?productVariantID=gmDHaevdhz4T3T4eiGjWHe](https://techbookfest.org/product/50CLAnEpRNhFNKzgq1aK78?productVariantID=gmDHaevdhz4T3T4eiGjWHe)

![22_tanaka4410.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/22_tanaka4410.jpg)

### 教育と LLM － 24 時間の AI 質問サポートが Rails の講義・研修にもたらした成果 (LT 版)

* 発表者
  * 安川 要平 氏 ([@yasulab](https://twitter.com/yasulab))

[Rails チュートリアル](https://railstutorial.jp/) に導入した [AI サポート機能](https://railstutorial.jp/ai_support) を通して、そのフィードバックと考察されたことについて話されました。
こちらは LT 版での発表でしたが、[RubyWorld Conference 2023](https://2023.rubyworld-conf.org/ja/) にて詳細な内容を発表されたとのことで以下からその様子をご覧いただけます。

[https://www.youtube.com/watch?v=Mnhwe8Lf_W8&ab_channel=RubyWorldConference](https://www.youtube.com/watch?v=Mnhwe8Lf_W8&ab_channel=RubyWorldConference)

![23_yasulab.jpg]({{base}}{{site.beseurl}}/images/0065-OsakaRubyKaigi03Report/23_yasulab.jpg)

## ご協賛頂いた企業様 (五十音順)

[株式会社アジャイルウェア](https://agileware.jp/) [株式会社インゲージ](https://ingage.co.jp/) [株式会社エイチーム](https://www.a-tm.co.jp/) [株式会社ナレッジラボ](https://knowledgelabo.com/) [BouqueTec 株式会社](https://www.instagram.com/bouquetec_com/) [ポノス株式会社](https://www.ponos.jp/) [リバティ・フィッシュ株式会社](https://www.libertyfish.co.jp/) [株式会社 Ruby 開発](https://www.ruby-dev.jp/)

## 著者について

### 高田 雄大 ([@ydah](https://twitter.com/ydah_))

大阪市在住、新米 Ruby コミッタ。最近は怪談を聞きながらプログラミングするのが好き。

### Special Thanx

本記事の執筆にあたり、フォトグラファーとして大阪 Ruby 会議 03 の運営に参加いただいた [@shutooike](https://twitter.com/shutooike) さんに写真を提供いただきました。ありがとうございました。
