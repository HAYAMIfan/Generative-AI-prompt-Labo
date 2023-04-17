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

ここ最近の生成AIの発展は著しく、私も今回のPF作成で大いに活用しています。<br>いろいろ試すうちに<strong>呪文の書き方によって出力結果は大きく変わってくる</strong>ことに気付き、<br>上手くできたときの呪文を共有し、皆で評価し合い、よりよい呪文を生み出す場所があればいいのにな...<br>という思いから、今回のテーマに至りました。

## 機能

### ログイン前

- ホーム画面には週間ランキングと新着投稿が表示される。
- 投稿を一覧表示でき(デフォルトは新着順)、投稿の詳細を閲覧できる。
- 投稿一覧画面では投稿のタイトルと本文に対して、キーワードによる部分一致検索とタグ検索が可能。
- ユーザー詳細画面の左側には、アイコン画像及び自己紹介を表示。
  右側にはそのユーザーの投稿一覧及びいいね！履歴、フォロー中している/されているユーザー一覧がタブ切り替えで表示される。

### ログイン後

- フォロー中ユーザーの投稿を表示可能になる。
- 新規投稿が可能になる。画像はChat GPTとのやり取りに合わせたサイズにするため、画像の中心を基準に切り抜き加工を施して表示。
- 投稿の詳細ページにコメントを残せる。
- 自身の投稿は編集・削除が可能で、自身のコメントも削除可能。
- 気に入った投稿にいいね！ができる(解除も可能)。
- いいね！及びコメントは非同期通信化されており、素早く反映される。
- マイページではアイコン及び自身の表示名、自己紹介コメントを編集可能。
- 他ユーザーのページではユーザーのフォローorフォロー解除が可能。

### 管理者専用機能

- 管理者は投稿やコメントの削除が可能。
- 管理者はユーザーの一覧を閲覧でき、停止状態も含む全ユーザーに対してユーザー名で部分一致検索が可能。
- 管理者はアカウントの停止及び復旧が可能。アカウントが停止されると、
  ユーザーの詳細、編集ページはロックされ、URL直打ちも含めて管理人以外アクセス不可。
  停止されたユーザーの投稿及びコメントは非表示化される。

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