import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workmate/model/event/event.dart';
import 'package:workmate/model/group/group.dart';
import 'package:workmate/model/notification/notification_item.dart';
import 'package:workmate/model/user/user_info_data.dart';
import 'package:workmate/utils/timestamp.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreRepository {
  final String? uid;

  FireStoreRepository({this.uid});

  // reference for our collecitons
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection("events");
  final CollectionReference notificationsCollection =
      FirebaseFirestore.instance.collection("notifications");

  // saving the userdata
  Future savingUserdata(String fullname, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullname,
      "email": email,
      "groups": [],
      "statusReadMessages": [],
      "profilePic": "",
      "uid": uid,
      "status": "Hoạt động",
      "isAdmin": false,
    });
  }

  Future updateUserdata(
      String fullname, String profilePic, String status) async {
    return await userCollection.doc(uid).update(
        {"fullName": fullname, "profilePic": profilePic, "status": status});
  }

  Future updateFcmTokenForUser(String uuidUser, String fcmToken) async {
    return await userCollection.doc(uuidUser).update({"fcmToken": fcmToken});
  }

  Future addNotificationDateOnServer(int id, String title, String body,
      List<String> uuids, String eventId) async {
    await notificationsCollection.doc('$id').set({
      'title': title,
      'body': body,
      'id': id,
      'users': FieldValue.arrayUnion(uuids),
      'eventId': eventId,
    });
  }

  Future<NotificationItem> findNotificationById(int id) async {
    DocumentSnapshot doc = await notificationsCollection.doc('$id').get();
    return NotificationItem.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<UserInfoData> findUserByUid(String uid) async {
    DocumentSnapshot doc = await userCollection.doc(uid).get();
    return UserInfoData.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<Event> findEventById(DateTime dateTime, String id) async {
    String dateTimeString = TimestampUtil.formatTimeDDMMYYYY(dateTime);
    DocumentSnapshot doc = await eventsCollection
        .doc(dateTimeString)
        .collection("list_events")
        .doc(id)
        .get();
    return Event.fromJson(doc.data() as Map<String, dynamic>);
  }

  // getting all user data
  Future<List<UserInfoData>> getAllUserInfoByListConditionExceptMe(
      List<String> uuids) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await userCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .map((doc) =>
            UserInfoData.fromJson((doc.data() as Map<String, dynamic>)))
        .toList();

    try {
      return allData
          .where((element) =>
              uuids.contains(element.uid) &&
              element.uid != FirebaseAuth.instance.currentUser!.uid)
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<String> uploadPdfFile(File file, String name, String timeStamp) async {
    String path = '${timeStamp}_${name}';
    TaskSnapshot taskSnapshot =
        await FirebaseStorage.instance.ref('pdf').child(path).putFile(file);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    //await FirebaseFirestore.instance.collection(path).add({"url": downloadUrl, "name": name});
    return downloadUrl;
  }

  // getting all user data
  Future<List<UserInfoData>> getAllUser() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await userCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .map((doc) =>
            UserInfoData.fromJson((doc.data() as Map<String, dynamic>)))
        .toList();

    return allData;
  }

  // getting all user data
  Future<List<UserInfoData>> getAllExceptMe() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await userCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .map((doc) =>
            UserInfoData.fromJson((doc.data() as Map<String, dynamic>)))
        .toList();

    return allData
        .where(
            (element) => element.uid != FirebaseAuth.instance.currentUser!.uid)
        .toList();
  }

  // getting all user data
  Future<List<Group>> getAllGroup() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await groupCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .map((doc) => Group.fromJson((doc.data() as Map<String, dynamic>)))
        .toList();

    return allData;
  }

  Future getGroup(String groupId) async {
    return groupCollection.doc("").snapshots();
  }

  CollectionReference<Object?> getUserStream() {
    return userCollection;
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  getListEventByDate(String date) {
    return eventsCollection.doc(date).collection("list_events").snapshots();
  }

  Future<String> addNewEvent({
    required String title,
    required String note,
    required DateTime dateTime,
    required TimeOfDay hourStart,
    required TimeOfDay hourEnd,
    required int typeOfRemind,
    required List<String> uuidUser,
    required String tag,
    required String uuidAdmin,
    required String urlPdfFile,
    required String fileName,
  }) async {
    String dateTimeString = TimestampUtil.formatTimeDDMMYYYY(dateTime);
    print("dongnd1 time: $dateTimeString");

    CollectionReference eventsByDate =
        eventsCollection.doc(dateTimeString).collection("list_events");
    DocumentReference newEvent = await eventsByDate.add({
      "id": "",
      "title": title,
      "note": note,
      "dateTime": TimestampUtil.formatTimeYYYYMMDDWithOutSeparate(dateTime),
      "hourStart": TimestampUtil.formatTimeHHMM(hourStart),
      "hourEnd": TimestampUtil.formatTimeHHMM(hourEnd),
      "tag": tag,
      "users": FieldValue.arrayUnion(uuidUser),
      "uuidAdmin": uuidAdmin,
      "typeOfRemind": typeOfRemind,
      "urlPdfFile": urlPdfFile,
      "fileName": fileName,
    });

    newEvent.update({
      "id": newEvent.id,
    });

    return newEvent.id;
  }

  Future updateNotificationIdForEvent(DateTime dateTime, String eventId, int notificationId) async {
    String dateTimeString = TimestampUtil.formatTimeDDMMYYYY(dateTime);
    print("dongnd1 time updateNotificationIdForEvent: $dateTimeString");
    await eventsCollection
        .doc(dateTimeString)
        .collection("list_events")
        .doc(eventId)
        .update({"notificationId": notificationId});
  }

  Future<String> updateEvent({
    required String id,
    required String title,
    required String note,
    required DateTime dateTime,
    required TimeOfDay hourStart,
    required TimeOfDay hourEnd,
    required int typeOfRemind,
    required List<String> uuidUser,
    required String tag,
    required String uuidAdmin,
    required String urlPdfFile,
    required String fileName,
    required bool isChangeDate,
    required DateTime oldDate,
  }) async {
    String dateTimeString = TimestampUtil.formatTimeDDMMYYYY(dateTime);
    print("dongnd1 time: $dateTimeString");

    DocumentSnapshot documentSnapshot = await eventsCollection
        .doc(dateTimeString)
        .collection("list_events")
        .doc(id)
        .get();
    if (documentSnapshot.data() != null) {
      await eventsCollection
          .doc(dateTimeString)
          .collection("list_events")
          .doc(id)
          .update({
        "id": id,
        "title": title,
        "note": note,
        "dateTime": TimestampUtil.formatTimeYYYYMMDDWithOutSeparate(dateTime),
        "hourStart": TimestampUtil.formatTimeHHMM(hourStart),
        "hourEnd": TimestampUtil.formatTimeHHMM(hourEnd),
        "tag": tag,
        "users": [],
        "uuidAdmin": uuidAdmin,
        "typeOfRemind": typeOfRemind,
        "urlPdfFile": urlPdfFile,
        "fileName": fileName,
      });
      await eventsCollection
          .doc(dateTimeString)
          .collection("list_events")
          .doc(id)
          .update({
        "users": FieldValue.arrayUnion(uuidUser),
      });

      return id;
    } else {
      DocumentReference newEvent = await eventsCollection
          .doc(dateTimeString)
          .collection("list_events")
          .add({
        "id": "",
        "title": title,
        "note": note,
        "dateTime": TimestampUtil.formatTimeYYYYMMDDWithOutSeparate(dateTime),
        "hourStart": TimestampUtil.formatTimeHHMM(hourStart),
        "hourEnd": TimestampUtil.formatTimeHHMM(hourEnd),
        "tag": tag,
        "users": FieldValue.arrayUnion(uuidUser),
        "uuidAdmin": uuidAdmin,
        "typeOfRemind": typeOfRemind,
        "urlPdfFile": urlPdfFile,
        "fileName": fileName,
      });

      newEvent.update({
        "id": newEvent.id,
      });

      String oldDateTimeString = TimestampUtil.formatTimeDDMMYYYY(oldDate);
      await eventsCollection
          .doc(oldDateTimeString)
          .collection("list_events")
          .doc(id)
          .delete();

      return newEvent.id;
    }

    // DocumentReference newEvent = await eventsByDate.add({
    //   "id": "",
    //   "title": title,
    //   "note": note,
    //   "dateTime": TimestampUtil.formatTimeYYYYMMDDWithOutSeparate(dateTime),
    //   "hourStart": TimestampUtil.formatTimeHHMM(hourStart),
    //   "hourEnd": TimestampUtil.formatTimeHHMM(hourEnd),
    //   "tag": tag,
    //   "users": FieldValue.arrayUnion(uuidUser),
    //   "uuidAdmin": uuidAdmin,
    //   "typeOfRemind": typeOfRemind,
    //   "urlPdfFile": urlPdfFile,
    //   "fileName": fileName,
    // });
    //
    // newEvent.update({
    //   "id": newEvent.id,
    // });
  }

  test(String uid) async {
    return CombineLatestStream.list([
      userCollection.doc(uid).snapshots(),
      groupCollection.doc().collection("messages").orderBy("time").snapshots()
    ]);
  }

  // creating a group
  Future<String> createGroup(String userName, String id, String groupName,
      List<String> uuidMembers, List<String> memberNames) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
      "username1": "",
      "username2": "",
      "avatarUser1": "",
      "avatarUser2": "",
      "emailUser1": "",
      "emailUser2": "",
      "isPrivateGroup": false
    });
    final listMember = [];
    for (var i = 0; i < uuidMembers.length; i++) {
      final member =
          FieldValue.arrayUnion(["${uuidMembers[i]}_${memberNames[i]}"]);
      listMember.add(member);

      DocumentReference userDocumentRefence =
          userCollection.doc(uuidMembers[i]);
      // removed await here check once
      await userDocumentRefence.update({
        "groups":
            FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
      });

      await groupDocumentReference.update({
        "members": member,
        "groupId": groupDocumentReference.id,
      });
    }

    return groupDocumentReference.id;
  }

  // creating a group
  Future<String> createPrivateGroup(
    String userName,
    String id,
    String groupName,
    List<String> uuidMembers,
    List<String> memberNames,
    String avatarUser1,
    String avatarUser2,
    String emailUser1,
    String emailUser2,
  ) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": "private",
      "groupIcon": "",
      "admin": "${id}_${memberNames[0]}",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
      "username1": memberNames[0],
      "username2": memberNames[1],
      "emailUser1": emailUser1,
      "emailUser2": emailUser2,
      "avatarUser1": avatarUser1,
      "avatarUser2": avatarUser2,
      "isPrivateGroup": true
    });
    final listMember = [];
    for (var i = 0; i < uuidMembers.length; i++) {
      final member =
          FieldValue.arrayUnion(["${uuidMembers[i]}_${memberNames[i]}"]);
      listMember.add(member);

      DocumentReference userDocumentRefence =
          userCollection.doc(uuidMembers[i]);
      // removed await here check once
      await userDocumentRefence.update({
        "groups": FieldValue.arrayUnion(
            ["${groupDocumentReference.id}_${memberNames[0]}"])
      });

      await groupDocumentReference.update({
        "members": member,
        "groupId": groupDocumentReference.id,
      });
    }

    return groupDocumentReference.id;
  }

  //getting the chats
  getChats(String groupId) {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  //get members
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  // search
  serachByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  // return booliean to know present or not
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/wait
  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    //doc
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    //if group has user then remove them or rejoin them
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  Future exitGroupWithRoleMember(
      String groupId, String groupName, String userName) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    }
  }

  Future exitGroupWithRoleAdmin() async {}

  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });

    // update group in collection user thanhf chua do
    List<UserInfoData> allUser = await getAllUser();
    if (allUser.isNotEmpty) {
      for (UserInfoData user in allUser) {
        DocumentReference userDocumentRefence = userCollection.doc(user.uid);
        DocumentSnapshot documentSnapshot = await userDocumentRefence.get();
        // removed await here check once
        List<dynamic> statusReadMessages =
            await documentSnapshot["statusReadMessages"];
        if (!statusReadMessages.contains("${groupId}")) {
          await userDocumentRefence.update({
            "statusReadMessages": FieldValue.arrayUnion(["${groupId}"])
          });
        }
      }
    }
  }

  updateStatusMessageToRead(String groupId) async {
    DocumentReference userDocumentRefence =
        userCollection.doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot documentSnapshot = await userDocumentRefence.get();
    // removed await here check once
    List<dynamic> statusReadMessages =
        await documentSnapshot["statusReadMessages"];
    if (statusReadMessages.contains("${groupId}")) {
      await userDocumentRefence.update({
        "statusReadMessages": FieldValue.arrayRemove(["${groupId}"])
      });
    }
  }
}
