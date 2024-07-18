# API
https://randomuser.me/documentation

# 仕様
`画面1.png`のようなレイアウトでキーボードで数値を入力して以下のAPIからユーザ情報を取ってくる

セルをタップしたら、`画面2.png`のようなレイアウトでそのユーザ情報を渡した詳細画面へ遷移する

詳細画面のアイコンをタップしたら、`画面3.png`のようなアラートが出る


# 実装ルール
UserModelを用意する

テーブルビューセルに載せるアイコンはKingfisherでキャッシュ化する

Routerパターンで画面遷移する

アラートもRouterに書く

1画面内はMVCにする


# 注意
地図表示にはXcodeの設定を追加する必要がある

`地図表示の許可設定.png`を参照してMapのCapabilityを追加する

