# **サービス概要**

直接交わすコミュニケーションの頻度が低く、同期や先輩社員のことを知る機会が極めて少ないフルリモート会社の新入社員に、社員一人一人の雑多なプロフィールを社内共有することで社員情報を得る機会を増やす、社員プロフィール公開サービス

### **登場人物**

- エンドユーザー
    - リモートワーク会社の新入社員(新卒、転職含め)
- 管理者
    - 社員全体のプロフィール情報を管理する役職の人

### **ユーザーが抱える課題**

"雑談"などのオフラインコミュニケーション頻度が減ったため、リモートワークの会社に入社した新入社員が既存社員、同期を知る機会が非常に少なくなっている。そのため、新入社員が社員一人一人の固有の話題を把握できず、既存の社内コミュニティに馴染むことが困難になっている。

### **解決方法**

Slackのアカウント情報やTwitterのツイート情報から、趣味、住んでいる場所等の"雑談"から得られそうな情報を抽出し、アプリオリジナルプロフィールを生成。それを社内コミュニティで共有することで、新入社員が社員の雑多な情報を把握することが可能になる。

### **マーケット**

- コロナ下でフルリモート会社に転職をする新入社員
- コロナが収束してもフルリモート体制を継続する会社

### プロダクト

Slackと連携するリフルリモート会社向けWebサービス

### 懸念点

- 既存社員がプロフィールを公開することが前提となるため、雑多な情報を含むプロフィール作成をほんの数分でできるようにする必要がある

### 機能一覧

[マスト]

- Slackのプロフィール + 個人で入力する情報からプロフィールを生成
- SlackやTwitterのテキストメッセージから単語の頻度を計測し、その人の趣味嗜好や口癖などを抽出いし、プロフィールに反映する
- 新入社員がその人への印象などをメモできる（相手には分からないように）
- 趣味、趣向などから検索できる

[オプション]

※技術的再現性は考慮してません。

- `あなたと仲良くしたいかも？社員リスト`(自分へのスタンプ数、社員の印象のメモの感情などから、自分に興味を持ってくれている社員を表示する)
- 社員プロフィールから、その社員への雑談に適した話題を生成してくれる機能(コミュニケーション本やバディの人たちを参考に)

# 画面遷移図
[show_profile](https://xd.adobe.com/view/cb862b4a-0de1-4758-85b3-3f0a00068cf6-9ed5/)

# ER図
[プロフィール公開機能のER図](https://drive.google.com/file/d/1pW12b2TSxHrzDs3K9VegpUCwETd3dkdx/view)