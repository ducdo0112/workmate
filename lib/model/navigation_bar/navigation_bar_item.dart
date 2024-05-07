import 'package:workmate/common/image/app_images.dart';

enum NavigationBarItemType { home, workmateList, aroundHere, guide }

extension NavigationBarItemExtention on NavigationBarItemType {
  String getIconPath() {
    switch (this) {
      case NavigationBarItemType.home:
        return AppImages.navigationBarHome;
      case NavigationBarItemType.workmateList:
        return AppImages.navigationBarworkmate;
      case NavigationBarItemType.aroundHere:
        return AppImages.navigationBarAroundHere;
      case NavigationBarItemType.guide:
        return AppImages.navigationBarGuide;
    }
  }
}
