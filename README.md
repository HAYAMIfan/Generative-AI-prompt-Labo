# 生成AI呪文ラボ

## 🚩 目次

- [サイト概要](#サイト概要)
- [サイトテーマ](#サイトテーマ)
- [機能](#機能)
- [設計図](#設計図)
- [開発環境](#開発環境)
- [使用素材](#使用素材)
- [導入したgemなど](#導入したgemなど)
- [参考にしたサイト](#参考にしたサイト)

## サイト概要

<h3>生成AIにどんな文章(＝呪文)を入力すればやりたいことが達成できるのかを探るために、<br>呪文に関する皆の知見を纏めるための研究所です。</h3>

### ターゲットユーザ

生成AIを試してみたいor試した初～中級者

### 主な利用シーン

- 生成AIと上手くやりとり出来た記録を残したい時
- 評判のいい呪文が知りたい時

## サイトテーマ

呪文と出力結果を投稿し、出力結果に対する満足度が高かった呪文を集めることで、<br>その傾向や共通点を見出して<strong>よりよい呪文とは何か？を追求すること</strong>を目的としています。

### テーマを選んだ理由

ここ最近の生成AIの発展は著しく、私も勉強の合間にアレコレと試していますが思わず舌を巻くような答えも返ってきます。そして情報を集める中で、<u>呪文の書き方によって出力結果は大きく変わってくる</u>ということを知り、<br>上手くできたときの呪文を記録し、皆で評価し合い、よりよい呪文を生み出し共有出来る場所があればいいのにな...<br>という思いから、今回のPFの制作に至りました。

## 機能

- 呪文と出力結果のスクリーンショット、キャプションを投稿できる。
- 気に入った投稿にいいね！を付けられる。
- 過去に自分がいいね！した投稿を一覧で表示できる。
- いいね！の多い投稿をランキング形式で一覧表示できる。

## 設計図

- [`画面遷移&ER図`](https://app.diagrams.net/#G1q1OqrWwuobj3JDz4oqv2tEpHWrA7mG7e)
- [`ワイヤーフレーム`](https://app.diagrams.net/?libs=general;mockups#G1ZsgHKRIQr0Ujm2d0qnlIFC_qGQ4B4VqM)

## 開発環境

- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails 6.1.4
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材

- 外部サービスの画像素材・音声素材を使用した場合は、必ずサービス名とURLを明記してください。
- 使用しない場合は、使用素材の項目をREADMEから削除してください。

## 導入したgemなど

- [`devise`]
- [`kaminari`]
- [`ransack`]
- [`jquery-rails`]
- [`Bootstrap`]
- [`FontAwesome`]
- [`ActiveStorage`]
- [`image_processing`]
- [`activestorage-validator`]

## 参考にしたサイト

- [`Chat GPT`](https://chat.openai.com/chat)このPF制作におけるテーマの大元であり、心強い戦友。
- [`note`](https://note.com/)テーマの大元その２。機能面やレイアウトなどを参考にしています。