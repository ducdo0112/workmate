import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/repository/firestore_repository.dart';
import 'package:workmate/ui/chat/page/widget/message_tile.dart';

import '../../model/user/user_info_data.dart';

class ChatGroupPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  final String avatar;
  final String email;
  final bool isPrivateGroup;
  final String username1;
  final String username2;
  final bool isAdmin;

  const ChatGroupPage({
    Key? key,
    required this.userName,
    required this.groupId,
    required this.groupName,
    required this.avatar,
    required this.email,
    required this.isPrivateGroup,
    required this.username1,
    required this.username2,
    required this.isAdmin,
  }) : super(key: key);

  @override
  State<ChatGroupPage> createState() => _ChatGroupPageState();
}

class _ChatGroupPageState extends State<ChatGroupPage> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messaagesController = TextEditingController();
  String admin = "";
  final ScrollController _scrollController = ScrollController();
  List<UserInfoData>? listUserInfoData;

  @override
  void initState() {
    super.initState();
    getChatandAdmin();
  }

  getChatandAdmin() async {
    var chatResult = await FireStoreRepository().getChats(widget.groupId);
    if (chatResult != null) {
      setState(() {
        chats = chatResult;
      });
    }

    var adminResult = await FireStoreRepository().getGroupAdmin(widget.groupId);
    if (adminResult != null) {
      setState(() {
        admin = adminResult;
      });
    }

    FireStoreRepository().getUserStream().snapshots().listen((event) async {
      final listUserChange = await FireStoreRepository().getAllUser();
      // setState(() {
      //   listUserInfoData = listUserChange;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    _scrollToBottom(2);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(_getTitle()),
        backgroundColor: AppColor.orangePeel,
        actions: [
          Visibility(
              visible: !widget.isPrivateGroup,
              child: _buildButtonExitGroup(
                  context, widget.groupId, widget.groupName, widget.userName))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: chatMessages(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: messaagesController,
                      decoration: const InputDecoration(
                        labelText: "Nhập tin nhắn",
                        labelStyle: TextStyle(color: AppColor.orangePeel),
                        contentPadding: EdgeInsets.zero,
                        focusColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.orangePeel),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.orangePeel),
                        ),
                      ),
                      cursorColor: AppColor.orangePeel,
                    )),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                        _scrollToBottom(1);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColor.orangePeel,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.send_outlined,
                          color: Colors.white,
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildButtonExitGroup(
      BuildContext context, String groupId, String groupName, String userName) {
    return IconButton(
        onPressed: () {
          _processExitGroupChat(context, groupId, groupName, userName);
        },
        icon: const Icon(Icons.exit_to_app));
  }

  _processExitGroupChat(BuildContext context, String groupId, String groupName,
      String userName) async {
    if (!widget.isAdmin) {
      await FireStoreRepository()
          .exitGroupWithRoleMember(groupId, groupName, userName);
      Navigator.of(context).pop();
    }
  }

  _getTitle() {
    if (!widget.isPrivateGroup) {
      return widget.groupName;
    } else {
      return widget.userName == widget.username1
          ? widget.username2
          : widget.username1;
    }
  }

  chatMessages() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final data = snapshot.data.docs.reversed.toList();
        return ListView.builder(
          controller: _scrollController,
          reverse: true,
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            var isSameSenderBefore = false;
            if (index > 0) {
              isSameSenderBefore =
                  data[index]['email'] == data[index - 1]['email'];
            }
            return MessageTile(
              message: data[index]['message'],
              sender: data[index]['sender'],
              sentByMe: widget.userName == data[index]['sender'],
              avatar: data[index]['avatar'],
              isSameSenderBefore: isSameSenderBefore,
              email: data[index]['email'],
              status: getStatusUser(data[index]['email']),
            );
          },
        );
      },
      stream: chats,
    );
  }

  getStatusUser(String email) {
    if (listUserInfoData != null) {
      final mappingResult = listUserInfoData
          ?.firstWhere((element) => element.email == email, orElse: null);
      if (mappingResult != null) {
        return mappingResult.status;
      }
    }

    return "Online";
  }

  sendMessage() {
    if (messaagesController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messaagesController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
        "avatar": widget.avatar,
        "email": widget.email,
      };
      FireStoreRepository().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messaagesController.clear();
      });
    }
  }

  _scrollToBottom(int seconds) {
    Timer(Duration(seconds: seconds), () {
      if(_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      }


      // update status read
      FireStoreRepository().updateStatusMessageToRead(widget.groupId);
    });
  }
}
