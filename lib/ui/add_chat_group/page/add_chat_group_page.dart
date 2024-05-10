import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:workmate/common/bloc/bloc_consumer_creation.dart';
import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/widget/base_page.dart';
import 'package:workmate/common/widget/input_form.dart';
import 'package:workmate/main/main_dev.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/ui/add_chat_group/bloc/add_chat_group_bloc.dart';
import 'package:workmate/ui/add_chat_group/bloc/add_chat_group_event.dart';
import 'package:workmate/ui/add_chat_group/bloc/add_chat_group_state.dart';

import '../../../common/image/app_images.dart';
import '../../../common/widget/custom_button.dart';
import '../../chat/page/widget/group_tile.dart';
import '../../chat_group/chat_group_page.dart';
import '../widget/profile_widget_chat.dart';

class AddChatGroupPage extends StatelessWidget {
  const AddChatGroupPage({Key? key, required this.isAddGroupChat})
      : super(key: key);
  final bool isAddGroupChat;

  @override
  Widget build(BuildContext context) {
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
      elevation: 0,
      backgroundColor: AppColor.orangePeel,
      title: Text(
        isAddGroupChat ? "Tạo nhóm chat" : "Chọn liên hệ để nhắn tin",
        style: TextStyle(fontSize: 16.sp),
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AddChatGroupBloc>()..add(const AddChatGroupFetched()),
      child: createBlocConsumer<AddChatGroupEvent, AddChatGroupState,
          AddChatGroupBloc>(
        listener: (p0, p1) {
          if (p1.statusCreateGroup == BlocStatus.success) {
            Navigator.of(context).pop();
            nextScreen(
                context,
                ChatGroupPage(
                  groupId: p1.groupId,
                  groupName: p1.groupName,
                  userName: p1.usernameAdmin,
                  avatar: p1.avatarAdmin,
                  email: p1.emailAdmin,
                  isPrivateGroup: p1.isPrivateGroup,
                  username1: p1.username1,
                  username2: p1.username2,
                  isAdmin: p1.isAdmin,
                  avatarUser1: "",
                  avatarUser2: "",
                  emailUser1: "",
                  emailUser2: "",
                ));
            return;
          }
          if (p1.statusCreatePrivateGroup == BlocStatus.success) {
            Navigator.of(context).pop();
            nextScreen(
                context,
                ChatGroupPage(
                  groupId: p1.groupId,
                  groupName: p1.groupName,
                  userName: p1.usernameAdmin,
                  avatar: p1.avatarAdmin,
                  email: p1.emailAdmin,
                  isPrivateGroup: p1.isPrivateGroup,
                  username1: p1.username1,
                  username2: p1.username2,
                  isAdmin: p1.isAdmin,
                  avatarUser1: p1.avatarUser1,
                  avatarUser2: p1.avatarUser2,
                  emailUser1: p1.emailUser1,
                  emailUser2: p1.emailUser2,
                ));
          }
        },
        shouldShowLoadingFullScreen: true,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 150,
                ),
                Visibility(
                    visible: isAddGroupChat,
                    child: _buildGroupNameInput(state, context)),
                Visibility(
                  visible: isAddGroupChat,
                  child: const SizedBox(
                    height: 50,
                  ),
                ),
                Text(
                  isAddGroupChat ? "Thêm thành viên" : "Danh sách thành viên",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Visibility(
                    visible: state.shouldShowErrorSelectUser,
                    child: Text(
                      "Vui lòng chọn thành viên",
                      style: TextStyle(
                          color: AppColor.red,
                          fontSize: 10.sp,
                          fontStyle: FontStyle.italic),
                    )),
                _buildListMember(state),
                Visibility(
                    visible: isAddGroupChat,
                    child: _buildRegisterButton(context)),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  _buildGroupNameInput(AddChatGroupState state, BuildContext context) {
    final controller = TextEditingController(text: state.groupName);
    controller.selection =
        TextSelection.collapsed(offset: state.groupName.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tên group",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(
          height: 6,
        ),
        BlocBuilder<AddChatGroupBloc, AddChatGroupState>(
          builder: (context, state) {
            return InputForm(
              controller: controller,
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
                    .read<AddChatGroupBloc>()
                    .add(GroupNameChanged(nameGroup: value));
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
        Visibility(
            visible: state.shouldShowErrorInputNameGroup,
            child: Text(
              "Vui lòng điền tên group",
              style: TextStyle(
                  color: AppColor.red,
                  fontSize: 10.sp,
                  fontStyle: FontStyle.italic),
            ))
      ],
    );
  }

  _buildListMember(AddChatGroupState state) {
    final listUser = state.listUsers ?? [];
    if (listUser.isEmpty) {
      return Container();
    }
    return Expanded(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: listUser.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final user = listUser[index];
              final isSelected =
                  state.listUsersSelected?.contains(user) ?? false;
              return InkWell(
                onTap: () {
                  if (!isAddGroupChat) {
                    context.read<AddChatGroupBloc>().add(
                        CreateGroupPrivateWithUserSelected(userInfoData: user));
                  }
                },
                child: Card(
                  color: isSelected ? AppColor.lightGray : null,
                  child: ListTile(
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: ProfileWidgetChat(
                        imageBase64: user.profilePic,
                      ),
                    ),
                    title:
                        Text(user.fullName, style: TextStyle(fontSize: 16.sp)),
                    trailing: Visibility(
                      visible: isAddGroupChat,
                      child: GestureDetector(
                        onTap: () {
                          context.read<AddChatGroupBloc>().add(
                              ChangeUserSelected(
                                  userInfoData: user, isAdd: !isSelected));
                        },
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: Icon(isSelected
                                ? Icons.remove_circle_outline
                                : Icons.add_circle_outline_sharp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  _buildRegisterButton(
    BuildContext context,
  ) {
    return BlocBuilder<AddChatGroupBloc, AddChatGroupState>(
      builder: (context, state) {
        return CustomButton(
          buttonStatus: state.statusCreateGroup,
          title: "Tạo nhóm",
          buttonClick: () {
            context.read<AddChatGroupBloc>().add(const CreateGroupPressed());
          },
          fontSize: 16.sp,
          borderSizeWidth: 3.w,
          backgroundColorEnable: AppColor.yellowOrange,
          borderSizeColor: AppColor.yellowOrange,
          isEnable: true,
        );
      },
    );
  }
}
