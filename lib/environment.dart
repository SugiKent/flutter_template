class Environment {
  final EnvironmentKind kind;
  final String baseApiUrl;
  final String playStoreReviewUrl = "";
  final String appStoreReviewUrl = "";

  factory Environment() {
    const env = String.fromEnvironment('env');
    return env == 'prod' ? const Environment.prod() : const Environment.dev();
  }

  const Environment._({
    required this.kind,
    required this.baseApiUrl,
  });

  const Environment.prod()
      : this._(
          kind: EnvironmentKind.prod,
          baseApiUrl: "https://example.com",
        );

  const Environment.dev()
      : this._(
          kind: EnvironmentKind.dev,
          baseApiUrl: "https://dev.example.com",
        );
}

enum EnvironmentKind {
  dev,
  prod,
}
