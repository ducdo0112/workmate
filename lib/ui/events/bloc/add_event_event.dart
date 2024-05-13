import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:workmate/model/event/event.dart';
import 'package:workmate/model/user/user_info_data.dart';

abstract class AddEventEvent extends Equatable {
  const AddEventEvent();
}

class AddEventFetched extends AddEventEvent {
  final String? eventId;
  final DateTime dateTime;
  const AddEventFetched(this.eventId, this.dateTime);

  @override
  List<Object?> get props => [eventId];
}

class AddEventTitleChanged extends AddEventEvent {
  final String title;
  const AddEventTitleChanged(this.title);

  @override
  List<Object?> get props => [title];
}

class AddEventNoteChanged extends AddEventEvent {
  final String note;
  const AddEventNoteChanged(this.note);

  @override
  List<Object?> get props => [note];
}

class AddEventDatetimeChanged extends AddEventEvent {
  final DateTime dateTime;
  const AddEventDatetimeChanged(this.dateTime);

  @override
  List<Object?> get props => [dateTime];
}

class AddEventStartHourChanged extends AddEventEvent {
  final TimeOfDay timeOfDay;
  const AddEventStartHourChanged(this.timeOfDay);

  @override
  List<Object?> get props => [timeOfDay];
}

class AddEventEndHourChanged extends AddEventEvent {
  final TimeOfDay timeOfDay;
  const AddEventEndHourChanged(this.timeOfDay);

  @override
  List<Object?> get props => [timeOfDay];
}

class AddEventRemindTypeChanged extends AddEventEvent {
  final int type;
  const AddEventRemindTypeChanged(this.type);

  @override
  List<Object?> get props => [type];
}

class AddEventListUserSelectChanged extends AddEventEvent {
  final List<UserInfoData> listUserChanged;
  const AddEventListUserSelectChanged(this.listUserChanged);

  @override
  List<Object?> get props => [listUserChanged];
}

class AddEventFileChanged extends AddEventEvent {
  final FilePickerResult filePicker;
  const AddEventFileChanged(this.filePicker);

  @override
  List<Object?> get props => [filePicker];
}

class AddEventTagChanged extends AddEventEvent {
  final String tag;
  const AddEventTagChanged(this.tag);

  @override
  List<Object?> get props => [tag];
}

class AddOrUpdateEvent extends AddEventEvent {
  const AddOrUpdateEvent();

  @override
  List<Object?> get props => [];
}