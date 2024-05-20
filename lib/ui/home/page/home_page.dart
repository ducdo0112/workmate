import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/main/main_dev.dart';
import 'package:workmate/ui/calendar/page/calendar_page.dart';
import 'package:workmate/ui/chat/page/chat_list_page.dart';
import 'package:workmate/ui/home/bloc/home_bloc.dart';
import 'package:workmate/ui/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../account_info/page/account_info_page.dart';


var notificationStreamController = PublishSubject();

class HomePage extends StatefulWidget {

  static final List<Widget> page = <Widget>[
    const CalendarPage(),
    const ChatListPage(),
    const AccountInfoPage(),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;

  int visit = 0;

  List<TabItem> items = [
    const TabItem(
      icon: Icons.calendar_month,
      title: 'Sự kiện',
    ),
    const TabItem(
      icon: Icons.chat,
      title: 'Trò chuyện',
    ),
    const TabItem(
      icon: Icons.person,
      title: 'Cá nhân',
    ),
  ];



  @override
  void initState() {
    super.initState();
    notificationStreamController.listen((value) async {

    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<HomeBloc>();
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          return _buildHomePage(state, context);
        },
      ),
    );
  }

  _buildHomePage(HomeState state, BuildContext context) {
    return Container(
        color: AppColor.gainsBoro,
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          top: false,
          child: Scaffold(
            body: IndexedStack(
              index: visit,
              children: HomePage.page,
            ),
            bottomNavigationBar: _buildBottomNavigationBar(),
          ),
        ));
  }

  BottomBarDefault _buildBottomNavigationBar() {
    return BottomBarDefault(
      items: items,
      backgroundColor: Colors.white,
      color: AppColor.grayX11,
      colorSelected: AppColor.orangePeel,
      indexSelected: visit,
      titleStyle: TextStyle(fontSize: 10.sp),
      onTap: (int index) => setState(() {
        visit = index;
      }),

      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    notificationStreamController.close();
  }
}
