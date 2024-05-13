import 'dart:async';
import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:workmate/di/dependency_inject.dart';
import 'package:workmate/environment/app_config.dart';
import 'package:workmate/main/app_bloc_observer.dart';
import 'package:workmate/main/my_app.dart';
import 'package:workmate/repository/firestore_repository.dart';
import 'package:workmate/repository/shared_preferences_repository.dart';
import 'package:workmate/service/firebase/firebase_service.dart';
import 'package:workmate/utils/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

/// This is our global ServiceLocator
GetIt getIt = GetIt.instance;
var nfcTagIncomingWhenAppOpenController = PublishSubject<String>();

@pragma('vm:entry-point') 
void printHello() async {
final DateTime now = DateTime.now();
final int isolateId = Isolate.current.hashCode;
await FirebaseService.setUpFirebaseService();
 await FireStoreRepository().testestIsolate();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await setupDependency(baseUrl: Const.baseUrlStg);
  await _setUpAndConfig();
  final hasLogin = (await SharedPreferencesHelper.getStringType(
          SharedPreferencesHelper.keyEmail))
      .isNotEmpty;
  final AppConfig configuredApp = AppConfig(
      environment: Environment.dev,
      baseUrl: Const.baseUrlStg,
      child: MyApp(
        hasLogin: hasLogin,
      ));

  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }

  //await AndroidAlarmManager.oneShotAt(DateTime(2024, 5, 11, 7, 36), 1, printHello, exact: true, wakeup: true, alarmClock: true, allowWhileIdle: true);
  runApp(configuredApp);
}

Future<void> _setUpAndConfig() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await FirebaseService.setUpFirebaseService();
}
