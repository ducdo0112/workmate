import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_data.g.dart';

@JsonSerializable()
class UserInfoData {
  final String fullName;
  final String email;
  final String profilePic;
  final String uid;
  final String status;

  UserInfoData(this.fullName, this.email, this.profilePic, this.uid, this.status);

  factory UserInfoData.fromQuerySnapshot(QuerySnapshot snapshot) {
    return UserInfoData(
        snapshot.docs[0]['fullName'],
        snapshot.docs[0]['email'],
        snapshot.docs[0]['profilePic'],
        snapshot.docs[0]['uid'],
        snapshot.docs[0]['status']);
  }

  factory UserInfoData.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoDataToJson(this);
}
