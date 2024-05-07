import 'dart:io';

import 'package:workmate/di/dependency_inject.dart';
import 'package:workmate/environment/app_config.dart';
import 'package:workmate/main/app_bloc_observer.dart';
import 'package:workmate/main/my_app.dart';
import 'package:workmate/repository/auth_repository.dart';
import 'package:workmate/repository/shared_preferences_repository.dart';
import 'package:workmate/service/firebase/firebase_service.dart';
import 'package:workmate/utils/const.dart';
import 'package:workmate/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uni_links/uni_links.dart';

/// This is our global ServiceLocator
GetIt getIt = GetIt.instance;
var nfcTagIncomingWhenAppOpenController = PublishSubject<String>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependency(baseUrl: Const.baseUrlStg);
  await _setUpAndConfig();
  final hasLogin = (await SharedPreferencesHelper.getStringType(SharedPreferencesHelper.keyEmail)).isNotEmpty;

  final AppConfig configuredApp = AppConfig(
      environment: Environment.dev,
      baseUrl: Const.baseUrlStg,
      child: MyApp(
        hasLogin: hasLogin,
      ));

  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }
  runApp(configuredApp);
}

Future<void> _setUpAndConfig() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await FirebaseService.setUpFirebaseService();
}
