import 'package:workmate/model/event/event.dart';
import 'package:workmate/ui/add_chat_group/page/add_chat_group_page.dart';
import 'package:workmate/ui/events/page/add_event_page.dart';
import 'package:workmate/ui/home/page/home_page.dart';
import 'package:workmate/ui/login/page/login_page.dart';
import 'package:workmate/ui/register/page/register_account_page.dart';
import 'package:flutter/cupertino.dart';

enum RouteDefine {
  login,
  home,
  register,
  addChatGroup,
  addEvent,
}

class AppRouting {
  static CupertinoPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.login.name: (_) => const LoginPage(),
      RouteDefine.home.name: (_) => HomePage(),
      RouteDefine.register.name: (_) => const RegisterAccountPage(),
      RouteDefine.addChatGroup.name: (_) => AddChatGroupPage(
          isAddGroupChat:
              settings.arguments != null ? settings.arguments as bool : false),
      RouteDefine.addEvent.name: (_) => AddEventPage(
            args: settings.arguments as AddEventPageArgs,
          ),
    };

    final routeBuilder = routes[settings.name];

    return CupertinoPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}
