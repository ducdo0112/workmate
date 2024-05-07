import 'package:workmate/ui/home/page/home_page.dart';
import 'package:workmate/ui/login/page/login_page.dart';
import 'package:workmate/ui/register/page/register_account_page.dart';
import 'package:flutter/cupertino.dart';

enum RouteDefine {
  login,
  home,
  register,
  historyPage,
  influencerList,
  workmateDetail,
  workmatePage,
  inAppWebViewPage,
  guide,
  aroundHere,
  aroundHereNfcView,
  accountInfor
}

class AppRouting {
  static CupertinoPageRoute generateRoute(RouteSettings settings) {
    final routes = <
        String
    ,
        WidgetBuilder>{
      RouteDefine.login.name: (_) => const LoginPage(),
      RouteDefine.home.name: (_) => HomePage(),
      RouteDefine.register.name: (_) => const RegisterAccountPage(),
    };

    final routeBuilder = routes[settings.name];

    return CupertinoPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}
