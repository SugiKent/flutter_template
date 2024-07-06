import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  final EnvironmentKind kind;
  final String testEnvText = dotenv.env['TEST_ENV_TEXT'] ?? '';

  factory Environment() {
    const env = String.fromEnvironment('env');
    return env == 'prod' ? Environment.prod() : Environment.dev();
  }

  Environment._({
    required this.kind,
  });

  Environment.prod()
      : this._(
          kind: EnvironmentKind.prod,
        );

  Environment.dev()
      : this._(
          kind: EnvironmentKind.dev,
        );
}

enum EnvironmentKind {
  dev,
  prod,
}
