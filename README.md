# アプリケーション名
THREAD  
<br>

# アプリケーション概要
LINEアプリと連携して毎日メッセージが届き安否確認をする  
日記投稿ができる  
<br>

# URL
https://thread-app-38082.herokuapp.com/  
<br>


# テスト用アカウント
- Basic認証ID : ”KIU"
- Basic認証パスワード : "5211"
- メールアドレス : test@test
- パスワード : 111aaa  
<br>

# 利用方法
### LINE公式アカウントをフレンド登録する
***
1. トップページでQRコードを読み込みフレンド登録をする
2. メッセージのURLに飛び、ユーザー登録をする

### 日記の投稿
***
1. ログインする
2. 日記新規投稿ボタンから日記を投稿する
3. マイページで確認する  
<br>

# アプリケーションを作成した背景
一人で生活している人は、いつ自分の身に何が起こるかわからない不安と共に生活をしていることが分かりました。身近なLINEというアプリから日々メッセージが届くこと。日記をつけるような感覚で文章を投稿するといいねをもらえる機能を実装し、誰かと繋がっている安心感を持てるアプリを開発したいと考えました。

# 洗い出した要件
[要件を定義したシート](https://docs.google.com/spreadsheets/d/1qjAYbKSrR3WXR6txBWmN_1iuw8PXPWS0Mu-ACh17iSg/edit?usp=sharing)  
<br>


# 実装した機能についての画像やGIFおよびその説明
[![Image from Gyazo](https://i.gyazo.com/a0f5a88128e2aa626cb97ba91f0c0739.png)](https://gyazo.com/a0f5a88128e2aa626cb97ba91f0c0739)

LINEでフレンド登録をすると通知が届きます  
「こちらです」のボタンを押すと新規登録ページに遷移します。  

[![Image from Gyazo](https://i.gyazo.com/0cb9addee459cfd1223c0310c5a14003.png)](https://gyazo.com/0cb9addee459cfd1223c0310c5a14003)

メッセージを送ると応答メッセージが返されるようになっています。  
<br>
[![Image from Gyazo](https://i.gyazo.com/58b8987c31c366062ff14e9e7ed5da1d.png)](https://gyazo.com/58b8987c31c366062ff14e9e7ed5da1d)

毎日このような通知が届き、actionボタンを押すとOKとメッセージが送信され応答メッセージが届きます。  
<br>


# 実装予定の機能
安否確認ができる機能を実装中。  
スマホでのviewの調整を実施予定。  
<br>

# データベース設計

[![Image from Gyazo](https://i.gyazo.com/2295aef5b62ac9c45ea445b2f4bcbd08.png)](https://gyazo.com/2295aef5b62ac9c45ea445b2f4bcbd08)  



# 画面遷移図

[![Image from Gyazo](https://i.gyazo.com/870e77eec7199132c45e359cd818963c.png)](https://gyazo.com/870e77eec7199132c45e359cd818963c)

# 開発環境
- フロントエンド
- バックエンド
- テスト
- テキストエディタ
- タスク管理

# 工夫したポイント
- 独学でLINE messaging APIを勉強しました。  
現段階では、フレンド登録されるとLINEのユーザーIDがLineUserモデルに保存されます。保存されたフレンドには毎日通知が届くようになっています。また、フレンドからメッセージが送られると応答メッセージが返るようプログラムしています。ユーザーIDは公式アカウントをブロックすることでデータが消え、メッセージも届かなくなります。  

- 日記では公開、非公開機能を設け、自分だけの日記帳としても使えるようにしました。
