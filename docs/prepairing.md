# 初期設定


## Firebase プロジェクト・アプリの作成

CLI から作成するためのコマンドを紹介  
Firebase コンソールでポチポチして作成しても構わない

<details>
<summary>CLI コマンド</summary>

### 認証

ディレクトリごとに login する Firebase アカウントを切り替えるための Tips

```sh
$ firebase login:add # どこにもログインしていないなら firebase login
$ firebase login:list
$ firebase login:use {メールアドレス}
```

### 作成

以下のコマンドは1プロジェクトを作り、iOS と Android アプリを作成する。ファイル名などは Debug 環境を想定している。

Firebaseプロジェクト作成
```bash
$ firebase projects:create --display-name "start app" start-app-0831
```

Android アプリ作成
```bash
$ firebase apps:create android --package-name bike.sugiken.start_app --project start-app-0831 # Android はハイフンが使えない
? What would you like to call your app? Start App # 任意のアプリの名前
```

iOS アプリ作成
```bash
$ firebase apps:create ios --bundle-id bike.sugiken.start-app --project start-app-0831 # Bundle Id にアンスコは使えない
? What would you like to call your app? Start App # 任意のアプリの名前
? Please specify your iOS app App Store ID: # 空白でも可
```

Android 設定ファイル取得
```bash
$ firebase apps:sdkconfig --project start-app-0831 android -o android/app/src/dev/google-services.json
```

iOS 設定ファイル取得
```bash
$ firebase apps:sdkconfig --project start-app-0831 ios -o ios/Runner/GoogleService-Info-dev.plist
```

:::warn
Xcode を利用して GoogleService-Info.plist ファイルを Xcode の管理下にする必要がある
ただし GoogleService-Info.plist は BuildPhase によって GoogleService-Info-(dev|prod).plist からコピーされるので初回ビルド試行後に可能
:::

#### Prod 環境用のコマンド

Project 作成とアプリ作成は同じなので割愛。

Android 設定ファイル取得
```bash
$ firebase apps:sdkconfig --project start-app android -o android/app/src/release/google-services.json
```

iOS 設定ファイル取得
```bash
$ firebase apps:sdkconfig --project start-app ios -o ios/Runner/GoogleService-Info-prod.plist
```
</details>


## プロジェクト名リネーム


`flutter_template` というプロジェクト名のため、適当なプロジェクト名に変更する。  
変更箇所は以下を参照( `flutter_template` を `start_app` に変更する例)

1. pubspec.yaml > name を `flutter_template` から変更する
2. Dart ファイルを `package:flutter_template/` で検索して `start_app` に一括置換


## dev.env/prod.env の変更

以下のファイルを変更する

- dart_defines/dev.env
- dart_defined/prod.env

それぞれの値の意味はファイルに記載

[【Flutter 3.19対応】Dart-define-from-fileを使って開発環境と本番環境を分ける](https://zenn.dev/altiveinc/articles/separating-environments-in-flutter) を参考に動かしている


## デバッグ/ビルドのための準備

### コマンドラインでビルドする場合

```
# Debug
$ flutter build ios --dart-define=env=dev

# Release(iOS)
$ flutter build ios --release --dart-define=env=prod

# Release(Android)
$ flutter build appbundle --release --dart-define=env=prod
or
$ flutter build appbundle --release --dart-define=env=prod --no-shrink
```


### VSCode

`.vscode/launch.json` を作る  
dart-defines を使うために必須の設定

<details>
<summary>`launch.json` の記述</summary>

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug dev",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "args": ["--dart-define-from-file=dart_defines/dev.env"]
    },
    {
      "name": "Debug prod",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "args": ["--dart-define-from-file=dart_defines/prod.env"]
    }
  ]
}
```
</details>


## install dependencies

```sh
$ flutter pub get

# pod install
$ cd ios; pod install --repo-update;cd ../;
```

---

ここまでで Dev 環境での開発ができるはず

---

## Apple Developer

### Identifier の登録

https://developer.apple.com/account/resources/identifiers/list で登録をする
これをしないとリリースや、いくつかの API(Push通知など) が利用できない

- `dart_defines/dev.env` や `dart_defines/prod.env` で利用している `appId` の値を確認
- App IDs → App を選択
- Bundle Id を `bundleId` と同じにして作成（Dev と Prod 同じでもいい）
- Target Runner > Signing & Capabilities で Bundle Identifier を見つけられていることを確認（見つけられていない場合、一度 debug ビルドをすることで dart_defines が反映される）

# Push通知

## iOS

[参考: Flutter × FCMでプッシュ通知を実装する - Zenn](https://zenn.dev/flutteruniv_dev/articles/flutter_push_notification)


上の記事を参考にやるべきこと

- Xcode 側の設定（この Template を clone した場合すでに設定できているかもしれない）
- APNs キーを Apple で作成し、Firebase に登録
  - 開発用も本番用も同じ
- Provisioning Profile の生成と Xcode での import
  - 基本は All に開発用の Profile を設定
  - Release の際に App Store 用の Profile を設定する
- ここまで設定したあとに実機からのアプリ削除からの再 install が必要
