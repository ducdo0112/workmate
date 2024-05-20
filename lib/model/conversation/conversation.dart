import 'package:json_annotation/json_annotation.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation {
  final String? userName;
  final String conversationId;
  final String conversationName;
  final bool isPrivateConversation;
  final String? username1;
  final String? username2;

  const Conversation({this.userName,required this.conversationId,required this.conversationName, required this.isPrivateConversation, this.username1, this.username2});

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}