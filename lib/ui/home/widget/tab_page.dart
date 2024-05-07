import 'package:workmate/model/navigation_bar/navigation_bar_item.dart';
import 'package:workmate/routing/app_routing.dart';
import 'package:workmate/ui/home/bloc/home_bloc.dart';
import 'package:workmate/ui/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabPage extends StatelessWidget {
  const TabPage({Key? key, required this.navigatorKeys}) : super(key: key);
  final Map<NavigationBarItemType, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(bottom: 60.h),
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.currentTabSelected != current.currentTabSelected,
          builder: (context, state) {
            final currentTabPageSelected = state.currentTabSelected;
            return Stack(
              children: [
                _buildOffstageNavigator(
                    initRoutePageName: RouteDefine.historyPage.name,
                    bottomTypeOfPage: NavigationBarItemType.home,
                    currentTabPageSelected: currentTabPageSelected,
                    key: navigatorKeys[NavigationBarItemType.home]),
                _buildOffstageNavigator(
                    initRoutePageName: RouteDefine.workmatePage.name,
                    bottomTypeOfPage: NavigationBarItemType.workmateList,
                    currentTabPageSelected: currentTabPageSelected,
                    key: navigatorKeys[NavigationBarItemType.workmateList]),
                _buildOffstageNavigator(
                    initRoutePageName: RouteDefine.aroundHere.name,
                    bottomTypeOfPage: NavigationBarItemType.aroundHere,
                    currentTabPageSelected: currentTabPageSelected,
                    key: navigatorKeys[NavigationBarItemType.aroundHere]),
                _buildOffstageNavigator(
                    initRoutePageName: RouteDefine.guide.name,
                    bottomTypeOfPage: NavigationBarItemType.guide,
                    currentTabPageSelected: currentTabPageSelected,
                    key: navigatorKeys[NavigationBarItemType.guide])
              ],
            );
          },
        ));
  }

  Widget _buildOffstageNavigator({
    required String initRoutePageName,
    required NavigationBarItemType bottomTypeOfPage,
    required NavigationBarItemType currentTabPageSelected,
    required GlobalKey<NavigatorState>? key,
  }) {
    return Offstage(
      offstage: bottomTypeOfPage != currentTabPageSelected,
      child: Navigator(
        key: key,
        initialRoute: initRoutePageName,
        onGenerateRoute: AppRouting.generateRoute,
      ),
    );
  }
}
