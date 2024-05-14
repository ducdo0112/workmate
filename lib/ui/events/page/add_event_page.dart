import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workmate/common/widget/custom_button.dart';
import 'package:workmate/common/widget/input_form_with_select_file.dart';
import 'package:workmate/common/widget/input_form_with_time_picker.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/event/event.dart';
import 'package:workmate/ui/events/bloc/add_event_bloc.dart';
import 'package:workmate/ui/events/bloc/add_event_event.dart';
import 'package:workmate/ui/events/bloc/add_event_state.dart';
import 'package:workmate/utils/timestamp.dart';

import '../../../common/bloc/bloc_consumer_creation.dart';
import '../../../common/color/app_color.dart';
import '../../../common/widget/base_page.dart';
import '../../../common/widget/input_form.dart';
import '../../../common/widget/input_form_with_date_picker.dart';
import '../../../main/main_dev.dart';
import '../../../model/user/user_info_data.dart';
import '../widget/input_form_with_add_user.dart';

class AddEventPage extends StatefulWidget {
  final AddEventPageArgs args;

  const AddEventPage({Key? key, required this.args}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  @override
  void initState() {
    isAddEventPage = true;
    super.initState();
  }

  @override
  void dispose() {
    isAddEventPage = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<AddEventBloc>()
          ..add(AddEventFetched(widget.args.eventId, widget.args.dateTime)),
        child: createBlocConsumer<AddEventEvent, AddEventState, AddEventBloc>(
          usingFullBackgroundLoadingDialog: true,
          listener: (p0, p1) {
            if (p1.statusRegisterOrUpdate == BlocStatus.success) {
              Navigator.of(context).pop();
            }
          },
          shouldShowLoadingFullScreen: true,
          buildWhen: (previous, current) =>
              previous.status != current.status ||
              previous.isCreateNewEvent != current.isCreateNewEvent,
          builder: (context, state) {
            return buildBasePage(
              appBar: _buildAppBar(state),
              backgroundColor: AppColor.white,
              extendBodyBehindAppBar: true,
              showDrawer: false,
              resizeToAvoidBottomInset: false,
              body: _buildBodyWidget(state, context),
            );
          },
        ));
  }

  PreferredSizeWidget _buildAppBar(AddEventState addEventState) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  Widget _buildBodyWidget(AddEventState addEventState, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 120),
            _buildHeader(addEventState),
            const SizedBox(height: 24),
            _buildTitle(context),
            const SizedBox(height: 20),
            _buildNote(context),
            const SizedBox(height: 20),
            _buildSelectDate(),
            const SizedBox(height: 20),
            _buildSelectTime(),
            const SizedBox(height: 20),
            _buildSelectRemind(),
            const SizedBox(height: 20),
            _buildListUser(),
            const SizedBox(height: 20),
            _buildSelectFilePdf(),
            const SizedBox(height: 25),
            _buildBottom(context),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  _buildHeader(AddEventState addEventState) {
    return Text(
      addEventState.isCreateNewEvent ? "Thêm task mới" : "Chi tiết task",
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    );
  }

  _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tiêu đề", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        BlocBuilder<AddEventBloc, AddEventState>(
          buildWhen: (previous, current) =>
              previous.titleEdit != current.titleEdit,
          builder: (context, state) {
            final controller = TextEditingController(text: state.titleEdit);
            controller.selection =
                TextSelection.collapsed(offset: state.titleEdit.length);
            return InputForm(
              hint: "Nhập tiêu đề",
              controller: controller,
              prefixIconConstraints: BoxConstraints(
                minWidth: 20.w,
                minHeight: 20.w,
              ),
              borderSideWidth: 1.0,
              onChanged: (value) {
                context.read<AddEventBloc>().add(AddEventTitleChanged(value));
              },
              hintTextStyle: TextStyle(fontSize: 16.sp),
              textStyle: TextStyle(fontSize: 16.sp),
            );
          },
        ),
        BlocBuilder<AddEventBloc, AddEventState>(
          buildWhen: (previous, current) =>
              previous.isValidateErrorTitle != current.isValidateErrorTitle,
          builder: (context, state) {
            return Visibility(
                visible: state.isValidateErrorTitle,
                child: Text(
                  "Nhập tiêu đề",
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

  _buildNote(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Ghi chú", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        BlocBuilder<AddEventBloc, AddEventState>(
          buildWhen: (previous, current) =>
              previous.noteEdit != current.noteEdit,
          builder: (context, state) {
            final controller = TextEditingController(text: state.noteEdit);
            controller.selection =
                TextSelection.collapsed(offset: state.noteEdit.length);
            return InputForm(
              hint: "Nhập ghi chú",
              controller: controller,
              prefixIconConstraints: BoxConstraints(
                minWidth: 20.w,
                minHeight: 20.w,
              ),
              borderSideWidth: 1.0,
              onChanged: (value) {
                context.read<AddEventBloc>().add(AddEventNoteChanged(value));
              },
              hintTextStyle: TextStyle(fontSize: 16.sp),
              textStyle: TextStyle(
                fontSize: 16.sp,
              ),
            );
          },
        )
      ],
    );
  }

  _buildListUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Thêm thành viên",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        BlocBuilder<AddEventBloc, AddEventState>(
          buildWhen: (previous, current) =>
              previous.listUser != current.listUser ||
              previous.listUserEdit != current.listUserEdit ||
              previous.listUserForSelectedInit !=
                  current.listUserForSelectedInit,
          builder: (context, state) {
            final controller = TextEditingController();
            // if (state.listUserEdit.isNotEmpty) {
            //   controller.text = state.getListNameUserFromListUserSelected();
            // }
            return InputFormWithAddUser(
              textInit: state.getListNameUserFromListUserSelected(),
              hint: "Thêm thành viên",
              prefixIconConstraints: BoxConstraints(
                minWidth: 20.w,
                minHeight: 20.w,
              ),
              borderSideWidth: 1.0,
              controller: controller,
              onChanged: (value) {},
              hintTextStyle: TextStyle(fontSize: 16.sp),
              textStyle: TextStyle(
                fontSize: 16.sp,
              ),
              userSelected: state.listUserEdit,
              listUserInfo: state.listUserForSelectedInit,
              onUserSelectedCompleted: (List<UserInfoData> listUser) {
                context
                    .read<AddEventBloc>()
                    .add(AddEventListUserSelectChanged(listUser));
              },
            );
          },
        )
      ],
    );
  }

  _buildSelectDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Ngày", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        BlocBuilder<AddEventBloc, AddEventState>(
          buildWhen: (previous, current) =>
              previous.dateTimeEdit != current.dateTimeEdit,
          builder: (context, state) {
            final controller = TextEditingController();
            if (state.dateTimeEdit != null) {
              controller.text = TimestampUtil.formatTimeYYYYMMDDWithOutSeparate(
                  state.dateTimeEdit ?? DateTime.now());
            }
            return InputFormWithDatePicker(
              initDatetime: state.dateTimeEdit,
              suffixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.calendar_month),
              ),
              controller: controller,
              hint: "Chọn ngày",
              prefixIconConstraints: BoxConstraints(
                minWidth: 20.w,
                minHeight: 20.w,
              ),
              borderSideWidth: 1.0,
              onChanged: (DateTime date) {
                context.read<AddEventBloc>().add(AddEventDatetimeChanged(date));
              },
              hintTextStyle: TextStyle(fontSize: 16.sp),
              textStyle: TextStyle(
                fontSize: 16.sp,
              ),
            );
          },
        ),
        BlocBuilder<AddEventBloc, AddEventState>(
          buildWhen: (previous, current) =>
              previous.isValidateDateTime != current.isValidateDateTime,
          builder: (context, state) {
            return Visibility(
                visible: state.isValidateDateTime,
                child: Text(
                  "Chọn ngày",
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

  _buildSelectTime() {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Giờ bắt đầu",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                BlocBuilder<AddEventBloc, AddEventState>(
                  buildWhen: (previous, current) =>
                      previous.startHourEdit != current.startHourEdit,
                  builder: (context, state) {
                    final controller = TextEditingController();
                    if (state.startHourEdit != null) {
                      controller.text = TimestampUtil.formatTimeHHMM(
                          state.startHourEdit ?? TimeOfDay.now());
                    }
                    return InputFormWithTimePicker(
                      suffixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.access_time_outlined),
                      ),
                      controller: controller,
                      hint: "Chọn giờ",
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 20.w,
                        minHeight: 20.w,
                      ),
                      borderSideWidth: 1.0,
                      onChanged: (TimeOfDay timeOfDay) {
                        context
                            .read<AddEventBloc>()
                            .add(AddEventStartHourChanged(timeOfDay));
                      },
                      hintTextStyle: TextStyle(fontSize: 16.sp),
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                      ),
                    );
                  },
                ),
                BlocBuilder<AddEventBloc, AddEventState>(
                  buildWhen: (previous, current) =>
                      previous.isValidateStartHour !=
                          current.isValidateStartHour ||
                      current.isOverLapTime != previous.isOverLapTime ||
                      previous.isValidateEndHour != current.isValidateEndHour,
                  builder: (context, state) {
                    if (!state.isValidateStartHour && state.isValidateEndHour ||
                        state.isOverLapTime) {
                      return Text(
                        ' ',
                        style: TextStyle(
                            color: AppColor.red,
                            fontSize: 10.sp,
                            fontStyle: FontStyle.italic),
                      );
                    }
                    return Visibility(
                        visible: state.isValidateStartHour,
                        child: Text(
                          "Chọn giờ",
                          style: TextStyle(
                              color: AppColor.red,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.italic),
                        ));
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Giờ kết thúc",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                BlocBuilder<AddEventBloc, AddEventState>(
                  buildWhen: (previous, current) =>
                      previous.endHourEdit != current.endHourEdit,
                  builder: (context, state) {
                    final controller = TextEditingController();
                    if (state.endHourEdit != null) {
                      controller.text = TimestampUtil.formatTimeHHMM(
                          state.endHourEdit ?? TimeOfDay.now());
                    }
                    return InputFormWithTimePicker(
                      suffixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.access_time_outlined),
                      ),
                      controller: controller,
                      hint: "Chọn giờ",
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 20.w,
                        minHeight: 20.w,
                      ),
                      borderSideWidth: 1.0,
                      onChanged: (TimeOfDay timeOfDay) {
                        context
                            .read<AddEventBloc>()
                            .add(AddEventEndHourChanged(timeOfDay));
                      },
                      hintTextStyle: TextStyle(fontSize: 16.sp),
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                      ),
                    );
                  },
                ),
                BlocBuilder<AddEventBloc, AddEventState>(
                  buildWhen: (previous, current) =>
                      previous.isValidateEndHour != current.isValidateEndHour ||
                      previous.isOverLapTime != current.isOverLapTime ||
                      previous.isValidateStartHour !=
                          current.isValidateStartHour,
                  builder: (context, state) {
                    if (state.isValidateStartHour && !state.isValidateEndHour) {
                      return Text(
                        ' ',
                        style: TextStyle(
                            color: AppColor.red,
                            fontSize: 10.sp,
                            fontStyle: FontStyle.italic),
                      );
                    }
                    return Visibility(
                        visible: state.isValidateEndHour || state.isOverLapTime,
                        child: Text(
                          state.isValidateEndHour ? "Chọn giờ" : "Trùng giờ",
                          style: TextStyle(
                              color: AppColor.red,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.italic),
                        ));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildSelectRemind() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Thông báo nhắc nhở trước",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        BlocBuilder<AddEventBloc, AddEventState>(
          buildWhen: (previous, current) =>
              previous.remindTypeEdit != current.remindTypeEdit,
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
                child: DropdownButton<int>(
                  value: state.remindTypeEdit,
                  isDense: true,
                  isExpanded: false,
                  items: [
                    DropdownMenuItem(
                        value: 5,
                        child: Text(
                          "5 phút",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.normal),
                        )),
                    DropdownMenuItem(
                        value: 10,
                        child: Text(
                          "10 phút",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.normal),
                        )),
                    DropdownMenuItem(
                        value: 15,
                        child: Text(
                          "15 phút",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.normal),
                        )),
                  ],
                  onChanged: (newValue) {
                    context
                        .read<AddEventBloc>()
                        .add(AddEventRemindTypeChanged(newValue ?? 5));
                  },
                ),
              ),
            );
          },
        )
      ],
    );
  }

  _buildSelectFilePdf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Chọn file pdf",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        BlocBuilder<AddEventBloc, AddEventState>(
          buildWhen: (previous, current) => false,
          builder: (context, state) {
            return InputFormWithSelectFile(
              fileNameInit: state.fileNamePdfInEditMode,
              linkFileInit: state.linkPdfFileInEditMode,
              suffixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.open_in_new),
              ),
              controller: TextEditingController(),
              hint: "Chọn file pdf",
              prefixIconConstraints: BoxConstraints(
                minWidth: 20.w,
                minHeight: 20.w,
              ),
              borderSideWidth: 1.0,
              onChanged: (FilePickerResult filePicker) {
                context
                    .read<AddEventBloc>()
                    .add(AddEventFileChanged(filePicker));
              },
              hintTextStyle: TextStyle(fontSize: 16.sp),
              textStyle: TextStyle(
                fontSize: 16.sp,
              ),
            );
          },
        )
      ],
    );
  }

  _buildBottom(BuildContext context) {
    Color getColorRed(Set<MaterialState> states) {
      return Colors.red;
    }

    Color getColorGreen(Set<MaterialState> states) {
      return Colors.green;
    }

    Color getColorBlue(Set<MaterialState> states) {
      return Colors.blue;
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Tag:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                BlocBuilder<AddEventBloc, AddEventState>(
                  buildWhen: (previous, current) =>
                      previous.tagEdit != current.tagEdit ||
                      previous.tag != current.tag,
                  builder: (context, state) {
                    String groupValueColor = state.tagEdit;
                    return Row(
                      children: [
                        Radio<String>(
                          value: 'red',
                          groupValue: groupValueColor,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColorRed),
                          onChanged: (String? value) {
                            context
                                .read<AddEventBloc>()
                                .add(AddEventTagChanged(value ?? 'red'));
                          },
                        ),
                        Radio<String>(
                          value: 'green',
                          groupValue: groupValueColor,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColorGreen),
                          onChanged: (String? value) {
                            context
                                .read<AddEventBloc>()
                                .add(AddEventTagChanged(value ?? 'green'));
                          },
                        ),
                        Radio<String>(
                          value: 'blue',
                          groupValue: groupValueColor,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColorBlue),
                          onChanged: (String? value) {
                            context
                                .read<AddEventBloc>()
                                .add(AddEventTagChanged(value ?? 'blue'));
                          },
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AddEventBloc, AddEventState>(
                buildWhen: (previous, current) => true,
                builder: (context, state) {
                  return CustomButton(
                    widthButton: 150,
                    title: state.isCreateNewEvent ? "Thêm mới" : "Cập nhật",
                    buttonStatus: state.statusRegisterOrUpdate,
                    buttonClick: () {
                      context.read<AddEventBloc>().add(AddOrUpdateEvent());
                    },
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    textColorEnable: AppColor.white,
                    circularProgressColor: AppColor.white,
                    backgroundColorEnable: AppColor.orangePeel,
                    isEnable:
                        state.isCreateNewEvent || state.isEnableUpdateButton(),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AddEventPageArgs {
  final String? eventId;
  final DateTime dateTime;

  const AddEventPageArgs({required this.eventId, required this.dateTime});
}
