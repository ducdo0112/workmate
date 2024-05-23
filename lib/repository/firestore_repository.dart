import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workmate/model/conversation/conversation.dart';
import 'package:workmate/model/event/event.dart';
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
  final CollectionReference conversationCollection =
      FirebaseFirestore.instance.collection("conversations");
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection("events");
  final CollectionReference notificationsCollection =
      FirebaseFirestore.instance.collection("notifications");

  // USER
  Future savingUserdata(String fullname, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullname,
      "email": email,
      "conversations": [],
      "statusReadMessages": [],
      "profilePic": "",
      "uid": uid,
      "status": "Hoạt động",
      "isAdmin": false,
      "createdDate": DateTime.now()
    });
  }

  Future updateUserdata(
      String fullname, String profilePic, String status) async {
    return await userCollection.doc(uid).update(
        {"fullName": fullname, "profilePic": profilePic, "status": status});
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
          element.uid != FirebaseAuth.instance.currentUser!.uid && element.isAdmin == false)
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<UserInfoData> findUserByUid(String uid) async {
    DocumentSnapshot doc = await userCollection.doc(uid).get();
    return UserInfoData.fromJson(doc.data() as Map<String, dynamic>);
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

  Future<void> deleteUser(String uid) async {
    try {
      userCollection.doc(uid).delete();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.uid == uid) {
        await user.delete();
      }
    } catch (e) {
      print("Error deleting user: $e");
    }
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
            (element) => element.uid != FirebaseAuth.instance.currentUser!.uid && element.isAdmin == false)
        .toList();
  }

  CollectionReference<Object?> getUserStream() {
    return userCollection;
  }

  getUsersStream()
  {
    return userCollection.snapshots();
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
    await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // get user conversations
  getUserConversations() async {
    return userCollection.doc(uid).snapshots();
  }

  Future updateFcmTokenForUser(String uuidUser, String fcmToken) async {
    return await userCollection.doc(uuidUser).update({"fcmToken": fcmToken});
  }

  // NOTIFICATIONS

  Future<NotificationItem> findNotificationById(int id) async {
    DocumentSnapshot doc = await notificationsCollection.doc('$id').get();
    return NotificationItem.fromJson(doc.data() as Map<String, dynamic>);
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

  //EVENTS

  Future<Event> findEventById(DateTime dateTime, String id) async {
    String dateTimeString = TimestampUtil.formatTimeDDMMYYYY(dateTime);
    DocumentSnapshot doc = await eventsCollection
        .doc(dateTimeString)
        .collection("list_events")
        .doc(id)
        .get();
    return Event.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<String> uploadPdfFile(File file, String name, String timeStamp) async {
    String path = '${timeStamp}_${name}';
    TaskSnapshot taskSnapshot =
        await FirebaseStorage.instance.ref('pdf').child(path).putFile(file);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
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
  }

  Future<void> deleteEvent({
    required String id,
    required DateTime dateTime,
  }) async {
    String dateTimeString = TimestampUtil.formatTimeDDMMYYYY(dateTime);
    //Delete
    eventsCollection
        .doc(dateTimeString)
        .collection("list_events")
        .doc(id).delete();
  }

  //CONVERSATIONS

  // creating a conversation
  Future<String> createConversation(String userName, String id, String conversationName,
      List<String> uuidMembers, List<String> memberNames) async {
    DocumentReference conversationDocumentReference = await conversationCollection.add({
      "conversationName": conversationName,
      "conversationIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "conversationId": "",
      "recentMessage": "",
      "recentMessageSender": "",
      "username1": "",
      "username2": "",
      "avatarUser1": "",
      "avatarUser2": "",
      "emailUser1": "",
      "emailUser2": "",
      "isPrivateConversation": false
    });
    final listMember = [];
    for (var i = 0; i < uuidMembers.length; i++) {
      final member =
          FieldValue.arrayUnion(["${uuidMembers[i]}_${memberNames[i]}"]);
      listMember.add(member);

      DocumentReference userDocumentReference =
          userCollection.doc(uuidMembers[i]);
      // removed await here check once
      await userDocumentReference.update({
        "conversations":
            FieldValue.arrayUnion(["${conversationDocumentReference.id}_$conversationName"])
      });

      await conversationDocumentReference.update({
        "members": member,
        "conversationId": conversationDocumentReference.id,
      });
    }

    return conversationDocumentReference.id;
  }

  // creating a group
  Future<String> createPrivateConversation(
    String userName,
    String id,
    String conversationName,
    List<String> uuidMembers,
    List<String> memberNames,
    String avatarUser1,
    String avatarUser2,
    String emailUser1,
    String emailUser2,
  ) async {
    DocumentReference groupDocumentReference = await conversationCollection.add({
      "conversationName": "private",
      "conversationIcon": "",
      "admin": "${id}_${memberNames[0]}",
      "members": [],
      "conversationId": "",
      "recentMessage": "",
      "recentMessageSender": "",
      "username1": memberNames[0],
      "username2": memberNames[1],
      "emailUser1": emailUser1,
      "emailUser2": emailUser2,
      "avatarUser1": avatarUser1,
      "avatarUser2": avatarUser2,
      "isPrivateConversation": true
    });
    final listMember = [];
    for (var i = 0; i < uuidMembers.length; i++) {
      final member =
          FieldValue.arrayUnion(["${uuidMembers[i]}_${memberNames[i]}"]);
      listMember.add(member);

      DocumentReference userDocumentReference =
          userCollection.doc(uuidMembers[i]);
      // removed await here check once
      await userDocumentReference.update({
        "conversations": FieldValue.arrayUnion(
            ["${groupDocumentReference.id}_${memberNames[0]}"])
      });

      await groupDocumentReference.update({
        "members": member,
        "conversationId": groupDocumentReference.id,
      });
    }

    return groupDocumentReference.id;
  }

  // getting all user data
  Future<List<Conversation>> getAllConversation() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await conversationCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .map((doc) => Conversation.fromJson((doc.data() as Map<String, dynamic>)))
        .toList();

    return allData;
  }

  Future getConversation(String conversationId) async {
    return conversationCollection.doc("").snapshots();
  }

  Future getGroupAdmin(String conversationId) async {
    DocumentReference d = conversationCollection.doc(conversationId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  //get members
  getGroupMembers(conversationId) async {
    return conversationCollection.doc(conversationId).snapshots();
  }

  //getting the chats
  getChats(String conversationId) {
    return conversationCollection
        .doc(conversationId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  // return booliean to know present or not
  Future<bool> isUserJoined(
      String conversationName, String conversationId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> conversations = await documentSnapshot['conversations'];
    if (conversations.contains("${conversationId}_$conversationName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/wait
  Future toggleGroupJoin(
      String conversationId, String userName, String conversationName) async {
    //doc
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = conversationCollection.doc(conversationId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> conversations = await documentSnapshot['conversations'];
    //if group has user then remove them or rejoin them
    if (conversations.contains("${conversationId}_$conversationName")) {
      await userDocumentReference.update({
        "conversations": FieldValue.arrayRemove(["${conversationId}_$conversationName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "conversations": FieldValue.arrayUnion(["${conversationId}_$conversationName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  Future exitGroupWithRoleMember(
      String conversationId, String conversationName, String userName) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = conversationCollection.doc(conversationId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> conversations = await documentSnapshot['conversations'];
    if (conversations.contains("${conversationId}_$conversationName")) {
      await userDocumentReference.update({
        "conversations": FieldValue.arrayRemove(["${conversationId}_$conversationName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    }
  }

  // send message
  sendMessage(String conversationId, Map<String, dynamic> chatMessageData) async {
    conversationCollection.doc(conversationId).collection("messages").add(chatMessageData);
    conversationCollection.doc(conversationId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });

    // update group in collection user thanh chua do
    List<UserInfoData> allUser = await getAllUser();
    if (allUser.isNotEmpty) {
      for (UserInfoData user in allUser) {
        DocumentReference userDocumentReference = userCollection.doc(user.uid);
        DocumentSnapshot documentSnapshot = await userDocumentReference.get();
        // removed await here check once
        List<dynamic> statusReadMessages =
            await documentSnapshot["statusReadMessages"];
        if (!statusReadMessages.contains(conversationId)) {
          await userDocumentReference.update({
            "statusReadMessages": FieldValue.arrayUnion([conversationId])
          });
        }
      }
    }
  }

  updateStatusMessageToRead(String conversationId) async {
    DocumentReference userDocumentReference =
        userCollection.doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    // removed await here check once
    List<dynamic> statusReadMessages =
        await documentSnapshot["statusReadMessages"];
    if (statusReadMessages.contains("${conversationId}")) {
      await userDocumentReference.update({
        "statusReadMessages": FieldValue.arrayRemove(["${conversationId}"])
      });
    }
  }
}
