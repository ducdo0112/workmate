import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/event/event.dart';
import 'package:workmate/model/http_raw/network_exception.dart';

import '../../../model/user/user_info_data.dart';

class AddEventState extends BaseState {
  final bool isCreateNewEvent;
  final Event? event;
  final List<UserInfoData> listUserForSelectedInit;

  final String title;
  final String titleEdit;
  final bool isValidateErrorTitle;

  final String note;
  final String noteEdit;

  final DateTime? dateTime;
  final DateTime? dateTimeEdit;
  final bool isValidateDateTime;

  final TimeOfDay? startHour;
  final TimeOfDay? startHourEdit;
  final bool isValidateStartHour;
  final bool isOverLapTime;

  final TimeOfDay? endHour;
  final TimeOfDay? endHourEdit;
  final bool isValidateEndHour;

  final int remindType;
  final int remindTypeEdit;

  final List<UserInfoData> listUser;
  final List<UserInfoData> listUserEdit;

  final FilePickerResult? filePickerResultEdit;

  final String tag;
  final String tagEdit;

  final BlocStatus statusRegisterOrUpdate;

  final String fileNamePdfInEditMode;
  final String linkPdfFileInEditMode;

  final String eventId;

  const AddEventState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.isCreateNewEvent = false,
    this.event,
    this.title = '',
    this.titleEdit = '',
    this.isValidateErrorTitle = false,
    this.note = '',
    this.noteEdit = '',
    this.dateTime,
    this.dateTimeEdit,
    this.isValidateDateTime = false,
    this.startHour,
    this.startHourEdit,
    this.isValidateStartHour = false,
    this.endHour,
    this.endHourEdit,
    this.isValidateEndHour = false,
    this.remindType = 5,
    this.remindTypeEdit = 5,
    this.listUser = const [],
    this.listUserEdit = const [],
    this.listUserForSelectedInit = const [],
    this.tag = 'red',
    this.tagEdit = 'red',
    this.filePickerResultEdit,
    this.statusRegisterOrUpdate = BlocStatus.initial,
    this.fileNamePdfInEditMode = '',
    this.linkPdfFileInEditMode = '',
    this.eventId = '',
    this.isOverLapTime = false,
  }) : super(status: status, exception: exception);

  AddEventState copyWith({
    BlocStatus? status,
    NetworkException? exception,
    bool? isCreateNewEvent,
    Event? event,
    String? title,
    String? titleEdit,
    bool? isValidateErrorTitle,
    String? note,
    String? noteEdit,
    DateTime? dateTime,
    DateTime? dateTimeEdit,
    bool? isValidateDateTime,
    TimeOfDay? startHour,
    TimeOfDay? startHourEdit,
    bool? isValidateStartHour,
    TimeOfDay? endHour,
    TimeOfDay? endHourEdit,
    bool? isValidateEndHour,
    List<UserInfoData>? listUser,
    List<UserInfoData>? listUserEdit,
    List<UserInfoData>? listUserForSelectedInit,
    String? tag,
    String? tagEdit,
    int? remindType,
    int? remindTypeEdit,
    FilePickerResult? filePickerResultEdit,
    BlocStatus? statusRegisterOrUpdate,
    String? fileNamePdfInEditMode,
    String? linkPdfFileInEditMode,
    String? eventId,
    bool? isOverLapTime,
  }) =>
      AddEventState(
        status: status ?? this.status,
        exception: exception ?? this.exception,
        isCreateNewEvent: isCreateNewEvent ?? this.isCreateNewEvent,
        event: event ?? this.event,
        title: title ?? this.title,
        titleEdit: titleEdit ?? this.titleEdit,
        isValidateErrorTitle: isValidateErrorTitle ?? this.isValidateErrorTitle,
        note: note ?? this.note,
        noteEdit: noteEdit ?? this.noteEdit,
        dateTime: dateTime ?? this.dateTime,
        dateTimeEdit: dateTimeEdit ?? this.dateTimeEdit,
        isValidateDateTime: isValidateDateTime ?? this.isValidateDateTime,
        startHour: startHour ?? this.startHour,
        startHourEdit: startHourEdit ?? this.startHourEdit,
        isValidateStartHour: isValidateStartHour ?? this.isValidateStartHour,
        endHour: endHour ?? this.endHour,
        endHourEdit: endHourEdit ?? this.endHourEdit,
        isValidateEndHour: isValidateEndHour ?? this.isValidateEndHour,
        listUser: listUser ?? this.listUser,
        listUserEdit: listUserEdit ?? this.listUserEdit,
        tag: tag ?? this.tag,
        tagEdit: tagEdit ?? this.tagEdit,
        remindType: remindType ?? this.remindType,
        remindTypeEdit: remindTypeEdit ?? this.remindTypeEdit,
        filePickerResultEdit: filePickerResultEdit ?? this.filePickerResultEdit,
        listUserForSelectedInit:
            listUserForSelectedInit ?? this.listUserForSelectedInit,
        statusRegisterOrUpdate:
            statusRegisterOrUpdate ?? this.statusRegisterOrUpdate,
        fileNamePdfInEditMode:
            fileNamePdfInEditMode ?? this.fileNamePdfInEditMode,
        linkPdfFileInEditMode:
            linkPdfFileInEditMode ?? this.linkPdfFileInEditMode,
        eventId: eventId ?? this.eventId,
        isOverLapTime: isOverLapTime ?? this.isOverLapTime,
      );

  String getListNameUserFromListUserSelected() {
    if (listUserEdit.isEmpty) {
      return "";
    }
    return listUserEdit.map((e) => e.fullName).toList().join(", ");
  }

  bool isEnableUpdateButton() {
    if (isCreateNewEvent) {
      return false;
    }

    return (title != titleEdit ||
        note != noteEdit ||
        dateTime != dateTimeEdit ||
        startHour != startHourEdit ||
        endHour != endHourEdit ||
        remindType != remindTypeEdit ||
        listUser != listUserEdit ||
        tag != tagEdit || filePickerResultEdit != null
    );
  }

  @override
  List<Object?> get props => super.props
    ..addAll([
      isCreateNewEvent,
      event,
      title,
      titleEdit,
      isValidateErrorTitle,
      note,
      noteEdit,
      dateTime,
      dateTimeEdit,
      isValidateDateTime,
      startHour,
      startHourEdit,
      isValidateStartHour,
      endHour,
      endHourEdit,
      isValidateEndHour,
      listUser,
      listUserEdit,
      tag,
      tagEdit,
      remindType,
      remindTypeEdit,
      filePickerResultEdit,
      statusRegisterOrUpdate,
      listUserForSelectedInit,
      linkPdfFileInEditMode,
      fileNamePdfInEditMode,
      eventId,
      isOverLapTime
    ]);
}
