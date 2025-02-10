---
layout: post
title: RegionalRubyKaigi レポート (xx) 東京Ruby会議12
short_title: RegionalRubyKaigi レポート (xx) 東京Ruby会議12
post_author: 東京Ruby会議12 実行委員会
tags: regionalRubyKaigi
created_on: 2025-01-27
---

{% include base.html %}

## RegionalRubyKaigi レポート (xx) 東京Ruby会議12

(ここに『はじめに』が入る）

## キーノート

## John Hawthorn『Scaling Ruby @ GitHub』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


## Kohei Suzuki『Ruby と Rust と私』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


## セッション

### Keynote: 『Scaling Ruby @ GitHub』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。


(your name)

### 前田 修吾『Ruby製テキストエディタでの生活』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### ぺん！『全てが同期する! Railsとフロントエンドのシームレスな連携の再考』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### ryopeko『functionalなアプローチで動的要素を排除する』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### tokujiros『ゼロからの、2Dレトロゲームエンジンの作り方』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### yumu『Ruby×AWSで作る動画変換システム』

* 録画: https://example.com/

yumuさんによる「Ruby×AWSで作る動画変換システム」は、GMOペパボさんののハンドメイドECサービス「minnne」で新しくリリースされた動画投稿機能の設計や実装・運用について焦点を当てられていた発表内容でした。

Rubyによる自前実装とAWSのマネージドサービスを組み合わせた設計となっており、それらを実装する上で導入した2つのgemであるffmpegの動画変換をRubyで作れる [streamio-ffmpeg](https://github.com/streamio/streamio-ffmpeg) gemとAWS SQSをバックエンド基盤としたワーカー実装ができる [Shoryuken](https://github.com/ruby-shoryuken/shoryuken) gemの活用事例を中心に触れられていました。<br>
リリース後の運用についても話されており、ECSの監視はGrafanaを用いてリソース監視をしメモリ/CPUのスペック調整を行いながらコストを意識した運用を続けているとのことでした。

今後の展望として、パフォーマンスチューニングのために並列処理の最適化を進めていくことや、アップデート機能として長時間の動画アップロードやストリーミング配信を可能にできるようにしたいと話されており、ユーザーにとってよりメリットのある機能として作り上げていこうとする強い思い入れを感じました。

また、発表中には ffmpeg を使った動画変換のデモを挟んでおり、yumuさんが撮影した可愛いカピバラの動画をアップロードし動画変換された様子を紹介されていてたいへん和みました。

発表の最後では Shoryuken gem のリポジトリが先日アーカイブとなりショックを受けた話もされていましたが、その後yumuさんご本人がメンテナのPabloさんに連絡を取り、アーカイブが解除されyumuさんもメンテナのメンバーに加わるというとても素敵な Kaigi Effect があったことも後日観測しました！すごすぎる、おめでとうございます！
https://x.com/myumura3/status/1880872104775893101<br>
https://x.com/myumura3/status/1884281861435974085

(桐生あんず)


### moznion『simple組み合わせ村から大都会Railsにやってきた俺は』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### Hiromi Ogawa『Writing PDFs in Ruby DSL』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### buty4649『mrubyでワンバイナリーなテキストフィルタツールを作った』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### morihirok『混沌とした例外処理とエラー監視に秩序をもたらす』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### Kasumi Hanazuki『Ruby meets secure DNS and modern Internet protocols』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


## 『Regional.rb and the Tokyo Metropolis』

* 録画: https://example.com/

大倉さん(@okuramasafumi) さん司会による、総勢16団体の東京圏を中心とする地域rbコミュニティが集結したトークセッションとなりました。

> Gotanda.rb, Shibuya.rb, Tokyu.rb, Omotesando.rb, Roppongi.rb, Sendagaya.rb, Ginza.rb, Shinjuku.rb, 中央総武.rb, mitaka.rb, Asakusa.rb, Nishinippori.rb, Urawa.rb, Saitama.rb, 柏.rb, しんめ.rb の実に16団体から登壇いただきます。意外、そして多彩、ご期待あれ！

[東京Ruby会議12 コンテンツ一覧｜東京Ruby会議12](https://note.com/tokyorubykaigi12/n/nabf1be5c3cee)

最初の紹介パートでは、1人30秒+スライド付きで各地域rbの紹介が行われました。16団体もいたこともあり、たくさんのコミュニティについて高速に触れられていく光景がちょっとシュールで楽しいひとときでした。<br>
しかし、ここで各地域rbの存在や活動内容を初めて知る方も多かったのではないでしょうか。聴衆の方々がこれを機に興味を持った地域コミュニティへと脚を運ぶ機会に繋がっていきそうに感じました。

紹介パートが終わってからは、事前に用意されたトークテーマ「今やっているコミュニティを主催するきっかけは？」「思い出に残っていることは？」「会場の参加者にメッセージ」についてその場で大倉さんの方から気になる内容を掘り下げつつ各地域rbの方々がお答えしていくという座談会形式で行われました。<br>
そこから出てくる話はどれも印象的な身の上話が多くコミュニティを作ることの楽しさが伝わるような内容が続きました。
その後の質疑応答パートやXの実況ハッシュタグ([#tokyorubykaigi](https://x.com/search?q=%23tokyorubykaigi&src=typed_query&f=top))でも、この場に影響を受けてコミュニティの立ち上げや再興について機運を高める参加者が見受けられました。[筆者自身もこの場に強く感化され新しく地域rbを作ろうと思った1人です](https://kiryuanzu.hatenablog.com/entry/2025/01/23/224006)。

全体を通してとても和気藹々とした雰囲気で行われたトークセッションでした。会場に来れなかった方もぜひアーカイブ動画をご覧いただきその雰囲気を味わっていただきたいです！

(桐生あんず)

## 会場や廊下のようす
