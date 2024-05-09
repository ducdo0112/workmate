import "package:flutter/material.dart";
import "package:workmate/common/color/app_color.dart";
import "package:workmate/repository/firestore_repository.dart";
import "package:workmate/ui/chat_group/chat_group_page.dart";
import "package:workmate/ui/chat_group/group_info.dart";

import "../../../../model/group/group.dart";

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  final String avatar;
  final String email;
  final String currentUserName;
  final List<dynamic> groupMessageUnread;

  const GroupTile({
    Key? key,
    required this.groupName,
    required this.groupId,
    required this.userName,
    required this.avatar,
    required this.email,
    required this.currentUserName,
    required this.groupMessageUnread,
  }) : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  Stream? groups;

  @override
  void initState() {
    super.initState();
    getGroupInfo();
  }

  getGroupInfo() async {
    await FireStoreRepository()
        .getGroupMembers(widget.groupId)
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () {
              nextScreen(
                  context,
                  ChatGroupPage(
                    groupId: widget.groupId,
                    groupName: widget.groupName,
                    userName: widget.userName,
                    avatar: widget.avatar,
                    email: widget.email,
                    isPrivateGroup: snapshot.data['isPrivateGroup'],
                    username1: snapshot.data['username1'],
                    username2: snapshot.data['username2'],
                    isAdmin: getName(snapshot.data['admin']) == widget.userName,
                  ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColor.orangePeel,
                  child: Text(
                    widget.groupName.substring(0, 1).toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
                title: _buildTitle(
                    widget.currentUserName,
                    snapshot.data['isPrivateGroup'],
                    snapshot.data['username1'],
                    snapshot.data['username2'],
                    widget.groupName),
                trailing: Visibility(
                  visible: widget.groupMessageUnread.contains(widget.groupId),
                  child: const Icon(Icons.message, color: Colors.green,),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  _buildTitle(String currentUserName, bool isPrivateGroup, String username1,
      String username2, String group) {
    print("dongnd1 currentUserName: $currentUserName, isPrivateGroup: $isPrivateGroup, username1: $username1, username2: $username2, group: $group, groupID: ${widget.groupId}");
    String title = "";
    if (!isPrivateGroup) {
      title = "Group: $group";
    } else {
      title = "Trò chuyện với: ${currentUserName == username1 ? username2 : username1}";
    }
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
