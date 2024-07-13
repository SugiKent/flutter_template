# リリース準備

## アイコンの設定

- `assets/icon/icon.png` を独自のアイコンに変更する
- `$ fvm flutter pub run flutter_launcher_icons` を実行


## GooglePlay

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

## AppStore

TODO: 設定方法を書く
