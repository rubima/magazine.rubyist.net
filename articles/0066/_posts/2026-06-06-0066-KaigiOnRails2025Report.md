---
layout: post
title: Kaigi on Rails 2025 開催レポート
short_title: Kaigi on Rails 2025 開催レポート
tags: 0066 KaigiOnRails2025Report KaigiOnRails
post_author: nobu09, mugi, nissyi
created_on: 2026-06-15
---
{% include base.html %}

## はじめに

2025 年 9 月 26 日 (金) 〜 27 日 (土) に [Kaigi on Rails 2025](https://kaigionrails.org/2025/) が開催されました。この記事では、その開催の様子をお届けいたします。

## Kaigi on Rails とは

Kaigi on Rails は、「初学者から上級者までが楽しめる Web 系の技術カンファレンス」 です。技術カンファレンスへの参加の敷居を下げることを意図して企画されています。また、名前のとおり Rails の話題を中心に据えるカンファレンスではありますが、広く Web に関すること全般についても扱っています。

Kaigi on Rails は、2020 年にオンラインで初開催されました。それからは毎年開催されており、2023 年以降はオフラインでの開催となっています。コンセプト、過去の公式サイト、ガイドライン、お問い合わせ先については、[https://kaigionrails.org/2025/about/](https://kaigionrails.org/2025/about/) にまとめられていますので、ぜひご覧ください。

## 開催情報

- 日程: 2025 年 9 月 26 日 (金) 〜 27 日 (土)
- 会場: [JP TOWER Hall & Conference](https://www.jptower-hall.jp/)
- 来場者数: 約 750 名
- X(旧: Twitter) の公式ハッシュタグ: [#kaigionrails](https://x.com/search?q=%23kaigionrails&f=live) [#kaigionrails_red](https://x.com/search?q=%23kaigionrails_red&f=live) [#kaigionrails_blue](https://x.com/search?q=%23kaigionrails_blue&f=live)
- 関連イベント: [https://kaigionrails.org/2025/events/](https://kaigionrails.org/2025/events/)

### デザインコンセプト

2025 年の Kaigi on Rails は、宇宙をモチーフとしたデザインを基調としていました。これまでの Kaigi on Rails は、メインロゴを中心としたシンボリックなデザインが主流でしたが、2025 年は背景やモチーフ、キャラクターを含めた世界観でイベントを表現しており、少し異なるアプローチを用いていました。

<img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/kor2025.webp" alt="Kaigi on Rails 2025 サイト" width="700px">

<img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/novelty01.webp" alt="ノベルティのキーホルダー" width="350px"> <img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/novelty02.webp" alt="ノベルティ" width="250px">

## コンテンツ

### 基調講演

Kaigi on Rails 2025 では、2 つの基調講演が行われました。

- 諸橋恭介さん「dynamic!」
    - [https://kaigionrails.org/2025/talks/moro/](https://kaigionrails.org/2025/talks/moro/)
    - 変化し続けることを前提にソフトウェアやプロダクトと向き合う重要性が語られ、Rails における継続的な改善や進化のあり方が示されました
- Samuel Williams さん「Building and Deploying Interactive Rails Applications with Falcon」
    - [https://kaigionrails.org/2025/talks/ioquatix/](https://kaigionrails.org/2025/talks/ioquatix/)
    - Falcon を用いたインタラクティブな Rails アプリケーションの構築・デプロイを通じて、Rails の新たな可能性が提示されました

いずれの基調講演も、単なる技術紹介にとどまらず、「Rails でどのような体験を実現できるのか」「これからの Web アプリケーションはどうあるべきか」といった視点を提示する内容となっており、カンファレンス全体の方向性を示すものとなっていました。

<img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/moro.webp" alt="諸橋さん" width="500px"> <img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/samuel.webp" alt="Samuel Williams さん" width="500px">

### セッション

Kaigi on Rails 2025 では、179 件のプロポーザルの応募をいただきました。ご応募いただいた方々に、この場を借りて御礼申し上げます。

幅広いテーマ・レベル感の提案が集まり、選考は非常に悩ましいものとなりました。

#### セッションの特徴

採択されたセッションは、パフォーマンス改善、設計、非同期処理、フロントエンド連携など、まさに**日々の開発に役立つような**現場の課題に踏み込んだテーマを中心に構成されていました。

#### 登壇体験: preload によるメモリ問題の実例

今回、オーガナイザーとして運営に携わりながら一人の登壇者としても参加した mugi の視点から、実際の登壇内容とそこから得られたものについて紹介します。

私は、「[そのpreloadは必要？──見過ごされたpreloadが技術的負債として爆発した日](https://kaigionrails.org/2025/talks/mugitti9/#day1)」というタイトルで登壇しました。

この発表では、ActiveRecord の preload を安易に使い続けた結果、不要なオブジェクト生成が積み重なり、最終的にメモリ使用量の増大によって OOM 障害に至った実例を紹介しました。数万件規模のデータを扱う中で、数百 MB 単位のメモリ消費が発生していたケースもあり、N+1 対策として導入された preload が、使わなくなっても忘れ去られ、それが長期的には技術的負債となりうることを実体験をもとに共有しました。

<img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/mugi.webp" alt="mugi さん" width="600px">

発表準備を通じて、Rails 内部での preload の挙動やオブジェクト生成コストを改めて整理し、自分の中で理解していたつもりの知識を言語化し直す機会にもなりました。また、当日は同様の課題に直面している参加者の方からの反応も多く、現場に共通する問題であることを実感しました。

#### セッション全体を通して

Kaigi on Rails のセッションは、こうした実体験に基づく知見が共有される点に大きな価値があります。成功事例だけでなく、失敗やトラブルから得られた学びが言語化されることで、参加者それぞれの現場に持ち帰れる形で蓄積されていきます。

また、登壇者の多くは特別な誰かではなく、日々の業務の中で得た気づきや課題を整理し、発表という形にしています。私自身も、日々の運用の中で発生した問題をきっかけに登壇しました。

Kaigi on Rails は、発表を「聞く場」であると同時に、「自分の考えを言葉にして共有する場」でもあります。日々の開発の中で感じた違和感や学びも、少し整理してみると十分に価値のある内容になります。

今回のカンファレンスを通じて「自分も話してみたい」と感じた方は、ぜひ次回のプロポーザル応募を検討してみてください。

## スポンサーブース

今年は、55 のスポンサーの皆様にご支援いただきました。この場を借りて御礼申し上げます。

内訳は以下の通りです。

- Ruby Sponsor: 6 社
- Gold Sponsor: 18 社
- Silver Sponsor: 31 社

詳細は、[https://kaigionrails.org/2025/sponsors/](https://kaigionrails.org/2025/sponsors/) をご覧ください。

## わいわい部屋

当日の会場は 2 フロアに分かれていて、下の階にセッションが行われる 2 つのホールやスポンサーブース、上の階に上がると「わいわい部屋」という交流や休憩ができるスペースがありました。

わいわい部屋には、ささださんの本屋さんのスペース、ogijun さんによるおいしいコーヒーの提供、スポンサーによるお菓子やドリンクの提供、地域.rb や技術イベントなどについて自由に書き込めるホワイトボードなどがありました。
あちこちで交流が生まれ、コーヒーの行列ができるなど、とても活気のあるスペースになっていました。

Kaigi on Rails 2025 の本屋さんについては、ささださんご本人による記事、[本屋さんを開催する技術（Kaigi on Rails 2025）](https://zenn.dev/ko1/articles/69d8db0227b40a)をご覧ください。

<img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/bookstore.webp" alt="本屋さん" width="500px"> <img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/whiteboard.webp" alt="ホワイトボード" width="500px">

## 懇親会

1 日目の夜は、東京国際フォーラム ホール B7 にて懇親会が開催されました。東京駅前にある本編会場 ( KITTE 内 JP タワー ホール＆カンファレンス) から徒歩 5 分程度の場所でした。約 450 名の方に参加していただきました。

<img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/party-guide.webp" alt="懇親会会場の案内" width="250px">

1 日目のカンファレンスの熱気をそのまま持ち込んだようなにぎやかな時間となり、会場のあちこちで活発な交流が生まれていました。また、前年に引き続きオーガナイザーが選んだお酒も好評でした。

<img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/drink.webp" alt="ドリンク" width="400px"> <img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/meal.webp" alt="フード" width="400px">

<img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/sake01.webp" alt="久保田・仙禽" width="400px"> <img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/sake02.webp" alt="伯楽星・真澄" width="400px">

## 託児

今回も、託児サポートを提供しました。

会場内で託児のための十分なスペース確保が難しかったため、今回は会場近隣の託児施設と連携する形で実施しました。ご協力いただいたスポンサーのご支援のもと、託児を希望された方に無事ご利用いただくことができました。

また、後日開催された「Kaigi on Rails 2025 事後勉強会」にて、託児の取り組みについてオーガナイザーから [LT で発表](https://speakerdeck.com/nobu09/having-childcare-support-at-conferences) を行ったところ、これを聞いた Rails Girls Tokyo 18th の主催者の方が、同イベントでも託児を実施することを決めてくださいました。こうした取り組みがコミュニティの中で広がっていくことを、とてもうれしく思っています。

## 2025 年の新たな取り組み

Kaigi on Rails 2025 では、いくつかの新しい取り組みを行いました。

### 日本語・英語の併記

Kaigi on Rails 2026 での国際カンファレンス化を見据えて、公式サイトや SNS などでの情報発信において、日本語・英語の併記を行いました。国内外から参加される方が増えるなかで、言語の壁をできるだけ低くすることを目指した取り組みです。

### 同時通訳の提供

2 日目の一部の英語のセッションで同時通訳の提供を行いました。希望する方に同時通訳レシーバーを配布しました。

また、会場のサブスクリーンでは字幕も表示していました。

<img src="{{base}}{{site.baseurl}}/images/0066-KaigiOnRails2025Report/subscreen.webp" alt="サブスクリーン" width="500px">

### イベントフォトの公開

開催後、イベントフォトを公式サイト上で公開しました。\
[https://kaigionrails.org/2025/album/](https://kaigionrails.org/2025/album/)

当日の雰囲気や会場の様子、登壇者の表情が伝わる写真を通じて、当日の熱気を思い起こすことができます。


## 次回予告

次回の [Kaigi on Rails 2026](https://kaigionrails.org/2026/) は、2026 年 10 月 16 日 (金) 〜 17 日 (土) の 2 日間、[ベルサール渋谷ガーデン](https://www.bellesalle.co.jp/shisetsu/shibuya/bs_shibuyagarden/) にて開催予定です。

キーノートスピーカーとして、David Heinemeier Hansson (DHH) 氏、Dave Thomas 氏の登壇が決定しています。\
DHH 氏はかつて [日本 Ruby カンファレンス 2006](https://rubykaigi.org/2006/) で基調講演を行っており、その様子は、るびまの [基調講演レポート]({{base}}{% post_url articles/RubyKaigi2006/2006-06-28-RubyKaigi2006-0611-3 %}#基調講演-david-heinemeier-hanssonone-controller-many-ins-many-outs) や 「[David を追う]({{base}}{% post_url articles/RubyKaigi2006/2006-06-28-RubyKaigi2006-DHH %})」 の記事でご覧いただけます。また、Dave 氏と日本の Ruby コミュニティの関わりについては、[るびま 0066 号の記事]({{base}}{% post_url articles/0066/2026-05-29-0066-Book-SimplicityJa %}#日本の-rubyist-が本書を読む意義) をご覧ください。

詳細については、今後公式の [X アカウント](https://x.com/kaigionrails) や [Mastodon アカウント](https://ruby.social/@kaigionrails) にて順次発信していきます。ぜひアカウントをフォローして続報をお待ちください。

渋谷でお会いできることを楽しみにしています！

## 著者について

### [mugi](https://x.com/mugi_1359)

Web エンジニアとして、Rails を中心としたアプリケーション開発に携わっています。Ruby コミュニティのオープンで歓迎的な雰囲気が好きで、Kaigi on Rails 2024 からオーガナイザーとして参加しています。

### [nobu09](https://x.com/nobu09_)

Web エンジニア。Kaigi on Rails 2025 からオーガナイザーとして参加しています。Ruby コミュニティが好きです。この春、ひとり息子が中学生になりました。

### [nissyi](https://x.com/yuta_onishi_97)

2023 年より Kaigi on Rails オーガナイザーとして活動しています。元電車の運転士です。
