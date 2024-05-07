import 'package:workmate/di/dependency_inject.dart';
import 'package:workmate/environment/app_config.dart';
import 'package:workmate/main/main_dev.dart';
import 'package:workmate/main/my_app.dart';
import 'package:workmate/utils/const.dart';
import 'package:flutter/material.dart';

import '../repository/shared_preferences_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependency(baseUrl: Const.baseUrlProduct);
  final hasLogin = (await SharedPreferencesHelper.getStringType(SharedPreferencesHelper.keyEmail)).isNotEmpty;
  final AppConfig configuredApp = AppConfig(
      environment: Environment.prod,
      baseUrl: Const.baseUrlProduct,
      child: MyApp(
        hasLogin: hasLogin,
      ));

  runApp(configuredApp);
}
