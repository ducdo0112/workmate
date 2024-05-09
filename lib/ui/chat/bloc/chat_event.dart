import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}
class ChatListEventFetched extends ChatEvent {
  const ChatListEventFetched();

  @override
  List<Object?> get props => [];
}