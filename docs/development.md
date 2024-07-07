# 開発時の注意点

## Riverpod について

### 開発時

常時 `$ fvm flutter pub run build_runner watch` の実行が必要

[参考: コード生成 - Riverpod](https://riverpod.dev/docs/concepts/about_code_generation)


これにより以下のコードがあるとき `HelloWorldRef` を自動生成してくれる

```dart
@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hello World!';
}
```

それを以下のようにして import する

```dart
part 'hello_world_provider.g.dart';
```
