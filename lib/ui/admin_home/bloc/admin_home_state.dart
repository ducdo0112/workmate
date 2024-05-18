import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/http_raw/network_exception.dart';
import 'package:workmate/model/navigation_bar/navigation_bar_item.dart';

class AdminHomeState extends BaseState {
  final NavigationBarItemType currentTabSelected;
  final String appBarTitle;
  final BlocStatus signOutStatus;
  final bool isCheckNeverAskNice;
  final bool showShowDialogInfluencer;

  /// Using this variable to detect Influencer page close, after close => emit data to refresh page
  final int numberTimesInfluencerPageClose;

  const AdminHomeState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.currentTabSelected = NavigationBarItemType.home,
    this.appBarTitle = "",
    this.signOutStatus = BlocStatus.initial,
    this.isCheckNeverAskNice = false,
    this.showShowDialogInfluencer = false,
    this.numberTimesInfluencerPageClose = 0,
  }) : super(status: status, exception: exception);

  AdminHomeState copyWith({
    BlocStatus? status,
    BlocStatus? signOutStatus,
    NetworkException? exception,
    NavigationBarItemType? currentTabSelected,
    String? appBarTitle,
    bool? isCheckNeverAskNice,
    bool? showShowDialogInfluencer,
    int? numberTimesInfluencerPageClose,
  }) =>
      AdminHomeState(
        status: status ?? this.status,
        exception: exception ?? this.exception,
        currentTabSelected: currentTabSelected ?? this.currentTabSelected,
        appBarTitle: appBarTitle ?? this.appBarTitle,
        signOutStatus: signOutStatus ?? this.signOutStatus,
        isCheckNeverAskNice: isCheckNeverAskNice ?? this.isCheckNeverAskNice,
        showShowDialogInfluencer:
            showShowDialogInfluencer ?? this.showShowDialogInfluencer,
        numberTimesInfluencerPageClose: numberTimesInfluencerPageClose ??
            this.numberTimesInfluencerPageClose,
      );

  @override
  List<Object?> get props => super.props
    ..addAll([
      currentTabSelected,
      appBarTitle,
      signOutStatus,
      isCheckNeverAskNice,
      showShowDialogInfluencer,
      numberTimesInfluencerPageClose,
    ]);
}
