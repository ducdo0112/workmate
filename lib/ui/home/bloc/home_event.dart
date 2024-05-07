import 'package:workmate/model/navigation_bar/navigation_bar_item.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class NavigationBarPressed extends HomeEvent {
  const NavigationBarPressed({
    required this.navigationBarType,
    this.isClickBuyUser = true,
    this.storeId,
    this.isShowAllNearShopList = false,
    this.isUserRequireFetchFromHistoryTabPage = false,
  });

  final NavigationBarItemType navigationBarType;

  // two case: click buy user or tap nfc
  final bool isClickBuyUser;
  final String? storeId;
  final bool isShowAllNearShopList;
  final bool isUserRequireFetchFromHistoryTabPage;

  @override
  List<Object?> get props => [
        navigationBarType,
        storeId,
        isShowAllNearShopList,
        isUserRequireFetchFromHistoryTabPage,
      ];
}


class NeverAskNiceAgainChecked extends HomeEvent {
  const NeverAskNiceAgainChecked();

  @override
  List<Object?> get props => [];
}


class InitDataWhenCreatedHomeBloc extends HomeEvent {
  const InitDataWhenCreatedHomeBloc();

  @override
  List<Object?> get props => [];
}

class NeedRefreshAfterFinishPageInfluencer extends HomeEvent {
  const NeedRefreshAfterFinishPageInfluencer();

  @override
  List<Object?> get props => [];
}