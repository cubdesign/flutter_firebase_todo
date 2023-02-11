class AppConfig {
  late List<String> tags;
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal() {
    tags = [];
  }
}
