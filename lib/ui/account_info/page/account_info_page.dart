import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workmate/common/bloc/bloc_consumer_creation.dart';
import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/main/main_dev.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/routing/app_routing.dart';
import 'package:workmate/ui/account_info/bloc/account_info_bloc.dart';
import 'package:workmate/ui/account_info/widget/profile_widget.dart';

import '../../../common/image/app_images.dart';
import '../../../common/widget/base_page.dart';
import '../../../common/widget/custom_button.dart';
import '../../../common/widget/input_form.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({Key? key}) : super(key: key);

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage>
    with AutomaticKeepAliveClientMixin<AccountInfoPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildBasePage(
      appBar: _buildAppBar(),
      backgroundColor: AppColor.white,
      extendBodyBehindAppBar: true,
      showDrawer: false,
      resizeToAvoidBottomInset: false,
      body: _buildBodyWidget(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 0,
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            getIt<AccountInfoBloc>()..add(const AccountInfoEventFetch()),
        child: createBlocConsumer<AccountInfoEvent, AccountInfoState,
            AccountInfoBloc>(
          listener: (p0, p1) {
            if (p1.logoutStatus == BlocStatus.success) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteDefine.login.name,
                (Route<dynamic> route) => false,
              );
            }
          },
          buildWhen: (previous, current) => previous.status != current.status,
          shouldShowLoadingFullScreen: true,
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 80),
                BlocBuilder<AccountInfoBloc, AccountInfoState>(
                  buildWhen: (previous, current) =>
                      previous.userAfterModify?.profilePic !=
                      current.userAfterModify?.profilePic,
                  builder: (context, state) {
                    return ProfileWidget(
                      imageBase64: state.getAvatarForDisplay(),
                      isEdit: true,
                      onClicked: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                            maxWidth: 120,
                            maxHeight: 120);
                        if (image != null) {
                          context
                              .read<AccountInfoBloc>()
                              .add(AccountEventAvatarChanged(file: image));
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 40),
                const Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                _buildFullName(state, context),
                const SizedBox(height: 20),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                _buildEmail(state),
                const SizedBox(height: 20),
                const Text(
                  "Trạng thái",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                _buildStatus(state, context),
                const SizedBox(height: 60),
                _buildUpdateInfoButton(state),
                const SizedBox(height: 12),
                _buildLogoutButton(state, context),
              ],
            );
          },
        ));
  }

  _buildFullName(AccountInfoState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<AccountInfoBloc, AccountInfoState>(
          buildWhen: (previous, current) => false,
          builder: (context, state) {
            return InputForm(
              controller: TextEditingController(
                  text: state.userAfterModify?.fullName ?? ''),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(
                  AppImages.user,
                  colorFilter: const ColorFilter.mode(
                    AppColor.textColorSilver,
                    BlendMode.srcIn,
                  ),
                  width: 20.w,
                  height: 20.w,
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 20.w,
                minHeight: 20.w,
              ),
              borderSideWidth: 1.0,
              onChanged: (value) {
                context
                    .read<AccountInfoBloc>()
                    .add(AccountEventUsernameChanged(username: value));
              },
              hintTextStyle: TextStyle(
                fontSize: 16.sp,
                color: AppColor.quickSilver,
                fontWeight: FontWeight.bold,
              ),
              textStyle: TextStyle(
                fontSize: 16.sp,
              ),
            );
          },
        ),
        BlocBuilder<AccountInfoBloc, AccountInfoState>(
          builder: (context, state) {
            return Visibility(
                visible: state.isErrorValidateName,
                child: Text(
                  "Tên không được để trống",
                  style: TextStyle(
                      color: AppColor.red,
                      fontSize: 10.sp,
                      fontStyle: FontStyle.italic),
                ));
          },
        )
      ],
    );
  }

  _buildEmail(AccountInfoState state) {
    return InputForm(
      controller: TextEditingController(text: state.user?.email ?? ''),
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SvgPicture.asset(
          AppImages.email,
          colorFilter: const ColorFilter.mode(
            AppColor.textColorSilver,
            BlendMode.srcIn,
          ),
          width: 20.w,
          height: 20.w,
        ),
      ),
      enable: false,
      prefixIconConstraints: BoxConstraints(
        minWidth: 20.w,
        minHeight: 20.w,
      ),
      borderSideWidth: 1.0,
      onChanged: (value) {},
      hintTextStyle: TextStyle(
        fontSize: 16.sp,
        color: AppColor.quickSilver,
        fontWeight: FontWeight.bold,
      ),
      textStyle: TextStyle(
        fontSize: 16.sp,
      ),
    );
  }

  _buildStatus(AccountInfoState state, BuildContext context) {
    return BlocBuilder<AccountInfoBloc, AccountInfoState>(
      buildWhen: (previous, current) =>
          previous.userStatus != current.userStatus,
      builder: (context, state) {
        return InputDecorator(
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                ),
              )),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: state.userStatus,
              isDense: true,
              isExpanded: false,
              items: const [
                DropdownMenuItem(
                    value: 'Hoạt động',
                    child: Text(
                      "Hoạt động",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    )),
                DropdownMenuItem(
                    value: "Vắng mặt",
                    child: Text(
                      "Vắng mặt",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    )),
              ],
              onChanged: (newValue) {
                context
                    .read<AccountInfoBloc>()
                    .add(AccountEventStatusChanged(status: newValue));
              },
            ),
          ),
        );
      },
    );
  }

  _buildUpdateInfoButton(AccountInfoState state) {
    return BlocBuilder<AccountInfoBloc, AccountInfoState>(
      builder: (context, state) {
        return CustomButton(
          title: "Cập nhật thông tin",
          buttonStatus: state.updateStatus,
          buttonClick: () {
            context.read<AccountInfoBloc>().add(AccountEventUpdatePressed());
          },
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          textColorEnable: AppColor.black,
          borderSizeColor: AppColor.black,
          borderSizeWidth: 1.w,
          circularProgressColor: AppColor.orangePeel,
          backgroundColorEnable: AppColor.white,
          isEnable: state.hasAvatarChanged() ||
              state.hasNameChanged() ||
              state.hasStatusChanged(),
        );
      },
    );
  }

  _buildLogoutButton(AccountInfoState state, BuildContext context) {
    return BlocBuilder<AccountInfoBloc, AccountInfoState>(
      builder: (context, state) {
        return CustomButton(
          title: "Đăng xuất",
          buttonStatus: state.logoutStatus,
          buttonClick: () {
            context
                .read<AccountInfoBloc>()
                .add(const AccountEventLogoutPressed());
          },
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          textColorEnable: AppColor.white,
          circularProgressColor: AppColor.white,
          backgroundColorEnable: AppColor.orangePeel,
          isEnable: true,
        );
      },
    );
  }
}
