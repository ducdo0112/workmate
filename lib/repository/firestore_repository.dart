import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workmate/model/group/group.dart';
import 'package:workmate/model/user/user_info_data.dart';

class FireStoreRepository {
  final String? uid;
  FireStoreRepository({this.uid});
  // reference for our collecitons
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");
  // saving the userdata
  Future savingUserdata(String fullname, String email ) async{
    return await userCollection.doc(uid).set({
      "fullName": fullname,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  Future updateUserdata(String fullname, String profilePic) async{
    return await userCollection.doc(uid).update({
      "fullName": fullname,
      "profilePic": profilePic,
    });
  }

  // getting all user data
  Future<List<UserInfoData>> getAllUser () async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await userCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => UserInfoData.fromJson((doc.data() as Map<String, dynamic>))).toList();

    return allData;
  }

  // getting all user data
  Future<List<Group>> getAllGroup () async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await groupCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => Group.fromJson((doc.data() as Map<String, dynamic>))).toList();

    return allData;
  }

  Future<List<Group>> getGroup (String groupId) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await groupCollection.where("groupId", isEqualTo: groupId).get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => Group.fromJson((doc.data() as Map<String, dynamic>))).toList();

    return allData;
  }
  
  // getting user data
  Future gettingUserData (String email) async {
    QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
  // get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }
  // creating a group
  Future<String> createGroup(String userName, String id, String groupName, List<String> uuidMembers,List<String> memberNames ) async {
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
      "isPrivateGroup": false
    });
    final listMember = [];
    for(var i = 0 ; i < uuidMembers.length ; i++) {
      final member = FieldValue.arrayUnion(["${uuidMembers[i]}_${memberNames[i]}"]);
      listMember.add(member);

      DocumentReference userDocumentRefence = userCollection.doc(uuidMembers[i]);
      // removed await here check once
     await userDocumentRefence.update({
        "groups":FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
      });

      await groupDocumentReference.update({
        "members": member,
        "groupId": groupDocumentReference.id,
      });

    }

    return groupDocumentReference.id;
  }

  // creating a group
  Future<String> createPrivateGroup(String userName, String id, String groupName, List<String> uuidMembers,List<String> memberNames ) async {
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
      "isPrivateGroup": true
    });
    final listMember = [];
    for(var i = 0 ; i < uuidMembers.length ; i++) {
      final member = FieldValue.arrayUnion(["${uuidMembers[i]}_${memberNames[i]}"]);
      listMember.add(member);

      DocumentReference userDocumentRefence = userCollection.doc(uuidMembers[i]);
      // removed await here check once
      await userDocumentRefence.update({
        "groups":FieldValue.arrayUnion(["${groupDocumentReference.id}_${memberNames[0]}"])
      });

      await groupDocumentReference.update({
        "members": member,
        "groupId": groupDocumentReference.id,
      });

    }

    return groupDocumentReference.id;
  }

  //getting the chats
  getChats(String groupId){
    return groupCollection.doc(groupId).collection("messages").orderBy("time").snapshots();
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
  serachByName(String groupName){
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }
  // return booliean to know present or not
  Future<bool>isUserJoined(String groupName,String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    if(groups.contains("${groupId}_$groupName")){
      return true;
    }
    else{
      return false;
    }
  }
  // toggling the group join/wait
  Future toggleGroupJoin(String groupId, String userName, String groupName) async {
    //doc
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    //if group has user then remove them or rejoin them
    if(groups.contains("${groupId}_$groupName")){
      await userDocumentReference.update({
        "groups":FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members":FieldValue.arrayRemove(["${uid}_$userName"])
      });
    }
    else{
      await userDocumentReference.update({
        "groups":FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members":FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }
  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage":chatMessageData['message'],
      "recentMessageSender":chatMessageData['sender'],
      "recentMessageTime":chatMessageData['time'].toString(),
    });
  }
}