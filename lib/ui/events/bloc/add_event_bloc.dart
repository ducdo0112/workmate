import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmate/ui/events/bloc/add_event_event.dart';
import 'package:workmate/ui/events/bloc/add_event_state.dart';
import 'package:workmate/utils/timestamp.dart';

import '../../../common/bloc/call_api.dart';
import '../../../model/enum/bloc_status.dart';
import '../../../model/user/user_info_data.dart';
import '../../../repository/firestore_repository.dart';
import '../../../repository/shared_preferences_repository.dart';

class AddEventBloc extends Bloc<AddEventEvent, AddEventState> {
  final FireStoreRepository fireStoreRepository;

  AddEventBloc({required this.fireStoreRepository})
      : super(const AddEventState()) {
    on<AddEventFetched>(_onAccountInfoFetch);
    on<AddEventTitleChanged>(_onTitleChanged);
    on<AddEventNoteChanged>(_onNoteChanged);
    on<AddEventDatetimeChanged>(_onDateTimeChanged);
    on<AddEventStartHourChanged>(_onStartHourChanged);
    on<AddEventEndHourChanged>(_onEndHourChanged);
    on<AddEventRemindTypeChanged>(_onRemindTypeChanged);
    on<AddEventListUserSelectChanged>(_onListUserSelectedChanged);
    on<AddEventFileChanged>(_onFileSelectedChanged);
    on<AddEventTagChanged>(_onTagChanged);
    on<AddOrUpdateEvent>(_onAddOnUpdateEventPressed);
  }

  Future<void> _onAccountInfoFetch(
    AddEventFetched event,
    Emitter<AddEventState> emit,
  ) async {
    if (event.eventId == null) {
      state.copyWith(status: BlocStatus.loading);
      var result = await fireStoreRepository.getAllExceptMe();
      emit(state.copyWith(
          isCreateNewEvent: true,
          listUserForSelectedInit: result,
          status: BlocStatus.success));
    } else {
      await handleCallApi(
        shouldDefaultErrorDialogWhenCallApi: true,
        onNoInternet: (e) {},
        onCallApi: () async {
          emit(state.copyWith(
              status: BlocStatus.loading, eventId: event.eventId));
          final eventDetail = await fireStoreRepository.findEventById(
              event.dateTime, event.eventId ?? "");
          final dateTime = TimestampUtil.convertStringYYYYMMDDToDateTime(
              eventDetail.dateTime);
          final hourStart =
              TimestampUtil.convertStringToTimeOfDay(eventDetail.hourStart);
          final hourEnd =
              TimestampUtil.convertStringToTimeOfDay(eventDetail.hourEnd);
          var listUser = await fireStoreRepository.getAllExceptMe();
          var listUserSelect = await fireStoreRepository
              .getAllUserInfoByListConditionExceptMe(eventDetail.users ?? []);
          emit(state.copyWith(
              status: BlocStatus.success,
              isCreateNewEvent: false,
              title: eventDetail.title,
              titleEdit: eventDetail.title,
              note: eventDetail.note,
              noteEdit: eventDetail.note,
              dateTime: dateTime,
              dateTimeEdit: dateTime,
              startHour: hourStart,
              startHourEdit: hourStart,
              endHour: hourEnd,
              endHourEdit: hourEnd,
              remindType: eventDetail.typeOfRemind,
              remindTypeEdit: eventDetail.typeOfRemind,
              listUser: listUserSelect,
              listUserEdit: listUserSelect,
              listUserForSelectedInit: listUser,
              fileNamePdfInEditMode: eventDetail.fileName,
              linkPdfFileInEditMode: eventDetail.urlPdfFile,
              tag: eventDetail.tag,
              tagEdit: eventDetail.tag));
        },
        onError: (e) {
          emit(state.copyWith(status: BlocStatus.error));
        },
      );
    }
  }

  _onTitleChanged(
    AddEventTitleChanged event,
    Emitter<AddEventState> emit,
  ) async {
    emit(state.copyWith(titleEdit: event.title));
  }

  _onNoteChanged(
    AddEventNoteChanged event,
    Emitter<AddEventState> emit,
  ) async {
    emit(state.copyWith(noteEdit: event.note));
  }

  _onDateTimeChanged(
    AddEventDatetimeChanged event,
    Emitter<AddEventState> emit,
  ) async {
    emit(state.copyWith(dateTimeEdit: event.dateTime));
  }

  _onStartHourChanged(
    AddEventStartHourChanged event,
    Emitter<AddEventState> emit,
  ) async {
    emit(state.copyWith(startHourEdit: event.timeOfDay));
  }

  _onEndHourChanged(
    AddEventEndHourChanged event,
    Emitter<AddEventState> emit,
  ) async {
    emit(state.copyWith(endHourEdit: event.timeOfDay));
  }

  _onRemindTypeChanged(
    AddEventRemindTypeChanged event,
    Emitter<AddEventState> emit,
  ) async {
    emit(state.copyWith(remindTypeEdit: event.type));
  }

  _onListUserSelectedChanged(
    AddEventListUserSelectChanged event,
    Emitter<AddEventState> emit,
  ) async {
    emit(state.copyWith(listUserEdit: event.listUserChanged));
  }

  _onFileSelectedChanged(
    AddEventFileChanged event,
    Emitter<AddEventState> emit,
  ) async {
    emit(state.copyWith(filePickerResultEdit: event.filePicker));
  }

  _onTagChanged(
    AddEventTagChanged event,
    Emitter<AddEventState> emit,
  ) async {
    emit(state.copyWith(tagEdit: event.tag));
  }

  Future<void> _onAddOnUpdateEventPressed(
    AddOrUpdateEvent event,
    Emitter<AddEventState> emit,
  ) async {
    if (state.isCreateNewEvent) {
      List<String> uuidUserSelected =
          state.listUserEdit.map((e) => e.uid).toList();
      final email = await SharedPreferencesHelper.getStringType(
          SharedPreferencesHelper.keyEmail);
      QuerySnapshot userInfoSnapshot =
          await FireStoreRepository(uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);
      final user = UserInfoData.fromQuerySnapshot(userInfoSnapshot);
      final uuids = [...uuidUserSelected];
      uuids.add(user.uid);
      if (_isValidateSuccessInput(emit)) {
        await handleCallApi(
          shouldDefaultErrorDialogWhenCallApi: true,
          onNoInternet: (e) {},
          onCallApi: () async {
            emit(state.copyWith(statusRegisterOrUpdate: BlocStatus.loading));
            String urlPdfFile = "";
            String fileName = "";
            if (state.filePickerResultEdit != null) {
              final file = File(state.filePickerResultEdit!.files.first.path!);
              fileName = state.filePickerResultEdit?.files.first.name ?? "";
              urlPdfFile = await fireStoreRepository.uploadPdfFile(
                  file,
                  state.filePickerResultEdit?.files.first.name ?? "test.pdf",
                  Timestamp.fromDate(DateTime.now())
                      .millisecondsSinceEpoch
                      .toString());
            }
            await fireStoreRepository.addNewEvent(
              title: state.titleEdit,
              note: state.noteEdit,
              dateTime: state.dateTimeEdit!,
              hourStart: state.startHourEdit!,
              hourEnd: state.endHourEdit!,
              typeOfRemind: state.remindTypeEdit,
              uuidUser: uuids,
              tag: state.tagEdit,
              uuidAdmin: user.uid,
              urlPdfFile: urlPdfFile,
              fileName: fileName,
            );
            emit(state.copyWith(statusRegisterOrUpdate: BlocStatus.success));
          },
          onError: (e) {
            emit(state.copyWith(statusRegisterOrUpdate: BlocStatus.error));
          },
        );
      }
    } else {
      // update
      if (_isValidateSuccessInput(emit)) {
        await handleCallApi(
          shouldDefaultErrorDialogWhenCallApi: true,
          onNoInternet: (e) {},
          onCallApi: () async {
            emit(state.copyWith(statusRegisterOrUpdate: BlocStatus.loading));
            List<String> uuidUserSelected =
                state.listUserEdit.map((e) => e.uid).toList();
            final email = await SharedPreferencesHelper.getStringType(
                SharedPreferencesHelper.keyEmail);
            QuerySnapshot userInfoSnapshot = await FireStoreRepository(
                    uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(email);
            final user = UserInfoData.fromQuerySnapshot(userInfoSnapshot);
            final uuids = [...uuidUserSelected];
            uuids.add(user.uid);
            String urlPdfFile = "";
            String fileName = "";
            if (state.filePickerResultEdit != null) {
              final file = File(state.filePickerResultEdit!.files.first.path!);
              fileName = state.filePickerResultEdit?.files.first.name ?? "";
              urlPdfFile = await fireStoreRepository.uploadPdfFile(
                  file,
                  state.filePickerResultEdit?.files.first.name ?? "test.pdf",
                  Timestamp.fromDate(DateTime.now())
                      .millisecondsSinceEpoch
                      .toString());
            } else {
              fileName = state.fileNamePdfInEditMode;
              urlPdfFile = state.linkPdfFileInEditMode;
            }
            if (state.filePickerResultEdit != null) {
              final file = File(state.filePickerResultEdit!.files.first.path!);
              fileName = state.filePickerResultEdit?.files.first.name ?? "";
              urlPdfFile = await fireStoreRepository.uploadPdfFile(
                  file,
                  state.filePickerResultEdit?.files.first.name ?? "test.pdf",
                  Timestamp.fromDate(DateTime.now())
                      .millisecondsSinceEpoch
                      .toString());
            }
            bool isChangeDate = state.dateTime != state.dateTimeEdit;
            await fireStoreRepository.updateEvent(
              id: state.eventId,
              title: state.titleEdit,
              note: state.noteEdit,
              dateTime: state.dateTimeEdit!,
              hourStart: state.startHourEdit!,
              hourEnd: state.endHourEdit!,
              typeOfRemind: state.remindTypeEdit,
              uuidUser: uuids,
              tag: state.tagEdit,
              uuidAdmin: user.uid,
              urlPdfFile: urlPdfFile,
              fileName: fileName,
              isChangeDate: isChangeDate,
              oldDate: state.dateTime!,
            );
            emit(state.copyWith(statusRegisterOrUpdate: BlocStatus.success));
          },
          onError: (e) {
            emit(state.copyWith(statusRegisterOrUpdate: BlocStatus.error));
          },
        );
      }
    }
  }

  bool _isValidateSuccessInput(Emitter<AddEventState> emit) {
    // title
    bool resultValidateTitle = false;
    if (state.titleEdit.isEmpty) {
      resultValidateTitle = true;
    }

    // date time
    bool resultValidateDateTime = false;
    if (state.dateTimeEdit == null) {
      resultValidateDateTime = true;
    }

    // hour start
    bool resultValidateHourStart = false;
    if (state.startHourEdit == null) {
      resultValidateHourStart = true;
    }

    // hour end
    bool resultValidateHourEnd = false;
    if (state.endHourEdit == null) {
      resultValidateHourEnd = true;
    }

    // validate overlap
    bool resultValidateOverLapHour = false;
    if (state.endHourEdit != null && state.startHourEdit != null) {
      if (state.endHourEdit!.hour < state.startHourEdit!.hour ||
          (state.endHourEdit!.hour == state.startHourEdit!.hour &&
              state.endHourEdit!.minute <= state.startHourEdit!.minute)) {
        resultValidateOverLapHour = true;
      }
    }

    emit(state.copyWith(
      isValidateErrorTitle: resultValidateTitle,
      isValidateDateTime: resultValidateDateTime,
      isValidateStartHour: resultValidateHourStart,
      isValidateEndHour: resultValidateHourEnd,
      isOverLapTime: resultValidateOverLapHour,
    ));

    if (resultValidateTitle ||
        resultValidateDateTime ||
        resultValidateHourStart ||
        resultValidateHourEnd ||
        resultValidateOverLapHour) {
      return false;
    }

    return true;
  }
}
