import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmate/ui/chat/bloc/chat_event.dart';
import 'package:workmate/ui/chat/bloc/chat_state.dart';

import '../../../common/bloc/call_api.dart';
import '../../../model/enum/bloc_status.dart';
import '../../../repository/firestore_repository.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FireStoreRepository fireStoreRepository;
  ChatBloc({required this.fireStoreRepository})
      : super(const ChatState()) {
    on<ChatListEventFetched>(_onChatListEventFetched);
  }

  Future<void> _onChatListEventFetched(
      ChatListEventFetched event,
      Emitter<ChatState> emit,
      ) async {
    await handleCallApi(
      shouldDefaultErrorDialogWhenCallApi: true,
      onNoInternet: (e) {},
      onCallApi: () async {
        emit(state.copyWith(status: BlocStatus.loading));
        final groups = await fireStoreRepository.getAllGroup();
        print("dongnd1");
      },
      onError: (e) {
        emit(state.copyWith(status: BlocStatus.error));
      },
    );
  }
}