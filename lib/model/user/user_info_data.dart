import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_data.g.dart';

@JsonSerializable()
class UserInfoData {
  final String fullName;
  final String email;
  final String profilePic;
  final String uid;

  UserInfoData(this.fullName, this.email, this.profilePic, this.uid);

  factory UserInfoData.fromQuerySnapshot(QuerySnapshot snapshot) {
    return UserInfoData(
        snapshot.docs[0]['fullName'],
        snapshot.docs[0]['email'],
        snapshot.docs[0]['profilePic'],
        snapshot.docs[0]['uid']);
  }

  factory UserInfoData.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoDataToJson(this);
}
