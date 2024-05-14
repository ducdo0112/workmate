import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final String? id;
  final String? title;
  final String? note;
  final String? hourStart;
  final String? hourEnd;
  final String? dateTime;
  final String? tag;
  final int? typeOfRemind;
  final List<String>? users;
  final String? uuidAdmin;
  final String? urlPdfFile;
  final String? fileName;
  final int? notificationId;

  Event(
    this.id,
    this.title,
    this.note,
    this.hourStart,
    this.hourEnd,
    this.dateTime,
    this.tag,
    this.typeOfRemind,
    this.uuidAdmin,
    this.users,
    this.urlPdfFile,
    this.fileName,
    this.notificationId,
  );

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
