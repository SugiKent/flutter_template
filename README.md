# Flutter オレオレ Template

## 対応バージョン

Android | iOS
--|--
Android 10.0(API Level 29) 以上 | 17以上


## 技術スタック

- Dart (3.4.3)
- Flutter (3.22.2)
- Firebase
- Riverpod

## できること

### 設定

- ビルド環境ごとの定数管理（`dar_defines` と `lib/environment.dart` によるハードコーディング）
- ビルド環境ごとに、アプリ名やアプリID(Bundle Identifier、Application ID)を変更
- ビルド環境ごとの Firebase Project との接続に利用する設定ファイルの変更
- 日本語設定がデフォルト
- dotenv が使える
- アイコンの設定（ `flutter_launcher_icons` を利用）

### 非機能

- Firebase Analytics が使える（デフォルトの Analytics は無効）
- Firebase Analytics で、自動イベントが停止され任意のイベント送信の管理がコードでされている状態
- Firebase Crashlytics が使える（main.dart で catch）
- Firebase Performance が使える（自動）
- Firebase RemoteConfig が使える（多分使える）

### アプリケーション層

- Light/Dark Theme の指定（ユーザによる変更はカバーしない）
- go_router によるルーティング管理
- BottomNavigation とスタイル修正のガイド
- レビューを促すダイアログの表示制御
- Riverpod によるステート管理

<details>
<summary>できるようにしたいこと</summary>

### 設定

- GitHub Actions 経由でのリリース作業

</details>

## 初期設定

https://github.com/SugiKent/flutter_template/blob/main/docs/prepairing.md

## 開発時の注意点

https://github.com/SugiKent/flutter_template/blob/main/docs/development.md

## リリースのための準備

https://github.com/SugiKent/flutter_template/blob/main/docs/for_release.md
