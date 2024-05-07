part of 'account_info_bloc.dart';

class AccountInfoState extends BaseState {
  final UserInfoData? user;
  final UserInfoData? userAfterModify;
  final BlocStatus updateStatus;
  final BlocStatus logoutStatus;
  final String userStatus;

  // validate
  final bool isErrorValidateName;

  const AccountInfoState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.user,
    this.userAfterModify,
    this.updateStatus = BlocStatus.initial,
    this.logoutStatus = BlocStatus.initial,
    this.isErrorValidateName = false,
    this.userStatus = "Online",
  }) : super(status: status, exception: exception);

  AccountInfoState copyWith({
    BlocStatus? status,
    NetworkException? exception,
    UserInfoData? user,
    UserInfoData? userAfterModify,
    BlocStatus? updateStatus,
    BlocStatus? logoutStatus,
    bool? isErrorValidateName,
    String? userStatus,
  }) =>
      AccountInfoState(
        status: status ?? this.status,
        exception: exception ?? this.exception,
        user: user ?? this.user,
        userAfterModify: userAfterModify ?? this.userAfterModify,
        updateStatus: updateStatus ?? this.updateStatus,
        logoutStatus: logoutStatus ?? this.logoutStatus,
        isErrorValidateName: isErrorValidateName ?? this.isErrorValidateName,
        userStatus: userStatus ?? this.userStatus,
      );

  bool hasAvatarChanged() {
    return (user != null &&
        userAfterModify != null &&
        user?.profilePic != userAfterModify?.profilePic);
  }

  bool hasNameChanged() {
    return (user != null &&
        userAfterModify != null &&
        user?.fullName != userAfterModify?.fullName);
  }

  String getAvatarForDisplay() {
    if (userAfterModify != null &&
        (userAfterModify?.profilePic.isNotEmpty ?? false) &&
        hasAvatarChanged()) {
      return userAfterModify?.profilePic ?? '';
    }
    return user?.profilePic ?? '';
  }

  @override
  List<Object?> get props => super.props
    ..addAll([
      user,
      userAfterModify,
      updateStatus,
      logoutStatus,
      isErrorValidateName,
      userStatus
    ]);
}
