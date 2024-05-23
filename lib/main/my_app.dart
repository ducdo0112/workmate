import 'package:workmate/common/theme/app_themes.dart';
import 'package:workmate/generated/l10n.dart';
import 'package:workmate/main/main_dev.dart';
import 'package:workmate/routing/app_routing.dart';
import 'package:workmate/ui/admin_home/page/admin_home_page.dart';
import 'package:workmate/ui/home/page/home_page.dart';
import 'package:workmate/ui/login/page/login_page.dart';
import 'package:workmate/utils/const.dart';
import 'package:workmate/utils/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.hasLogin}) : super(key: key);
  final bool hasLogin;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ScreenUtilInit(
      designSize: Const.screenDesignSize,
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: AppRouting.generateRoute,
            home: widget.hasLogin ? AdminHomePage() : const LoginPage());
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
