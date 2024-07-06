# Flutter オレオレ Template

## 対応バージョン

Android | iOS
--|--
Android 10.0(API Level 29) 以上 | 17以上


## 技術スタック

- Dart (3.4.3)
- Flutter (3.22.2)
- Firebase
- Riverpod（未導入）

## できること

### 設定

- ビルド環境ごとの定数管理（`dar_defines` と `lib/environment.dart` によるハードコーディング）
- ビルド環境ごとに、アプリ名やアプリID(Bundle Identifier、Application ID)を変更
- ビルド環境ごとの Firebase Project との接続に利用する設定ファイルの変更
- 日本語設定がデフォルト
- dotenv が使える

### 非機能

- Firebase Analytics が使える
- Firebase Analytics で、自動イベントが停止され任意のイベント送信の管理がコードでされている状態
- Firebase Crashlytics が使える（main.dart で catch）
- Firebase Performance が使える（自動）
- Firebase RemoteConfig が使える（多分使える）

### アプリケーション層

- Light/Dark Theme の指定（ユーザによる変更はカバーしない）
- onGenerateRoute によるルーティング管理
- レビューを促すダイアログの表示制御

実現できたものからここに追加していく

<details>
<summary>できるようにしたいこと</summary>

### 設定

- 環境ごとによるアイコンの差し替え [参考](https://zenn.dev/altiveinc/articles/separating-environments-in-flutter#app%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3%E3%82%92%E7%92%B0%E5%A2%83%E3%81%AB%E3%82%88%E3%81%A3%E3%81%A6%E5%A4%89%E3%81%88%E3%82%8B)

### 機能

- Riverpod によるステート管理
</details>


## セットアップ手順

### Firebase プロジェクト・アプリの作成

CLI から作成するためのコマンドを紹介  
Firebase コンソールでポチポチして作成しても構わない

<details>
<summary>CLI コマンド</summary>

#### 認証

ディレクトリごとに login する Firebase アカウントを切り替えるための Tips

```sh
$ firebase login:add # どこにもログインしていないなら firebase login
$ firebase login:list
$ firebase login:use {メールアドレス}
```

#### 作成

以下のコマンドは1プロジェクトを作り、iOS と Android アプリを作成する。ファイル名などは Debug 環境を想定している。

Firebaseプロジェクト作成
```bash
$ firebase projects:create --display-name "start app" start-app
```

Android アプリ作成
```bash
$ firebase apps:create android --package-name sugiken.start_app --project start-app
? What would you like to call your app? Start App # 任意のアプリの名前
```

iOS アプリ作成
```bash
$ firebase apps:create ios --bundle-id sugiken.start-app --project start-app
? What would you like to call your app? Start App # 任意のアプリの名前
? Please specify your iOS app App Store ID: # 空白でも可
```

Android 設定ファイル取得
```bash
$ firebase apps:sdkconfig --project start-app android -o android/app/src/dev/google-services.json
```

iOS 設定ファイル取得
```bash
$ firebase apps:sdkconfig --project start-app ios -o ios/Runner/GoogleService-Info-dev.plist
```

:::warn
Xcode を利用して GoogleService-Info.plist ファイルを Xcode の管理下にする必要がある
ただし GoogleService-Info.plist は BuildPhase によって GoogleService-Info-(dev|prod).plist からコピーされるので初回ビルド試行後に可能
:::

##### Prod 環境用のコマンド

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


### プロジェクト名リネーム


`flutter_template` というプロジェクト名のため、適当なプロジェクト名に変更する。  
変更箇所は以下を参照( `flutter_template` を `start_app` に変更する例)

1. pubspec.yaml > name を `flutter_template` から変更する
2. Dart ファイルを `package:flutter_template/` で検索して `start_app` に一括置換


### dev.env/prod.env の変更

以下のファイルを変更する

- dart_defines/dev.env
- dart_defined/prod.env

それぞれの値の意味はファイルに記載

[【Flutter 3.19対応】Dart-define-from-fileを使って開発環境と本番環境を分ける](https://zenn.dev/altiveinc/articles/separating-environments-in-flutter) を参考に動かしている


### デバッグ/ビルドのための準備

#### コマンドラインでビルドする場合

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


#### VSCode

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


### install dependencies

```sh
$ flutter pub get

# pod install
$ cd ios; pod install --repo-update;cd ../;
```


---

ここまでで Dev 環境での開発ができるはず

---


### リリースビルドのための設定


Android リリースビルドに必要なファイル  
TODO: それぞれのファイルの作り方や役割を調査して追記

* android/app/signing/key.jks
* android/app/signing/signing.gradle

signing.gradle の内容

```
signingConfigs {
  release {
     storeFile file("key.jks")
     storePassword "xxxxx"
     keyAlias "xxxxx"
     keyPassword "xxxxx"
  }
}
```


## リリースのための準備
