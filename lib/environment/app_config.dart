import 'package:flutter/cupertino.dart';

enum Environment { prod, dev }

class AppConfig extends InheritedWidget {
  final Environment environment;
  final String baseUrl;

  static AppConfig of(BuildContext buildContext) {
    return buildContext.dependOnInheritedWidgetOfExactType<AppConfig>()!;
  }

  const AppConfig({
    Key? key,
    required Widget child,
    required this.environment,
    required this.baseUrl,
  }) : super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
