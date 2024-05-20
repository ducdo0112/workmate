import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/model/conversation/conversation.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:workmate/model/http_raw/network_exception.dart';

class ChatState extends BaseState {
  final List<Conversation> conversations;
  const ChatState({
    BlocStatus status = BlocStatus.initial,
    NetworkException? exception,
    this.conversations = const [],
  }) : super(status: status, exception: exception);

  ChatState copyWith({
    BlocStatus? status,
    NetworkException? exception,
    List<Conversation>? conversations,
  }) =>
      ChatState(
        status: status ?? this.status,
        exception: exception ?? this.exception,
        conversations: conversations ?? this.conversations,
      );

  @override
  List<Object?> get props => super.props..addAll([conversations]);
}
