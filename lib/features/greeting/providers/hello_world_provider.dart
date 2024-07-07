import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hello_world_provider.g.dart';

// HelloWorldRef は自動生成される
// ref. https://riverpod.dev/docs/concepts/about_code_generation
@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hello World!';
}
