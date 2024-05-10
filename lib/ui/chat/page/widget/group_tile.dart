import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:workmate/common/color/app_color.dart";
import "package:workmate/repository/firestore_repository.dart";
import "package:workmate/ui/chat/page/widget/profile_group_avatar.dart";
import "package:workmate/ui/chat_group/chat_group_page.dart";

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
                    avatarUser1: snapshot.data['avatarUser1'],
                    avatarUser2: snapshot.data['avatarUser2'],
                    emailUser1: snapshot.data['emailUser1'],
                    emailUser2: snapshot.data['emailUser2'],
                  ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListTile(
                leading: _buildAvatar(
                  snapshot.data['isPrivateGroup'],
                  widget.currentUserName,
                  snapshot.data['username1'],
                  snapshot.data['avatarUser1'],
                  snapshot.data['avatarUser2'],
                ),
                title: _buildTitle(
                  widget.currentUserName,
                  snapshot.data['isPrivateGroup'],
                  snapshot.data['username1'],
                  snapshot.data['username2'],
                  widget.groupName,
                  snapshot.data['recentMessage'],
                ),
                trailing: Visibility(
                  visible: widget.groupMessageUnread.contains(widget.groupId),
                  child: const Icon(
                    Icons.message,
                    color: Colors.green,
                  ),
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

  _buildAvatar(bool isPrivateGroup, String currentUserName, String username1,
      String userAvatar1, String userAvatar2) {
    if (isPrivateGroup) {
      String avatarDisplay;
      if (currentUserName == username1) {
        avatarDisplay = userAvatar2;
      } else {
        avatarDisplay = userAvatar1;
      }
      return SizedBox(
        width: 60,
        height: 56,
        child: ProfileGroupAvatar(
          imageBase64: avatarDisplay,
          onClicked: () {},
        ),
      );
    } else {
      return CircleAvatar(
        radius: 30,
        backgroundColor: AppColor.orangePeel,
        child: Text(
          widget.groupName.substring(0, 1).toUpperCase(),
          textAlign: TextAlign.center,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      );
    }
  }

  _buildTitle(
    String currentUserName,
    bool isPrivateGroup,
    String username1,
    String username2,
    String group,
    String recentMessage,
  ) {
    String title = "";
    if (!isPrivateGroup) {
      title = "Group: $group";
    } else {
      title =
          "Trò chuyện với: ${currentUserName == username1 ? username2 : username1}";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          recentMessage,
          style: TextStyle(fontSize: 12.sp),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
