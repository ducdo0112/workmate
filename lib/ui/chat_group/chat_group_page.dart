import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/repository/firestore_repository.dart';
import 'package:workmate/ui/chat/page/widget/message_tile.dart';

class ChatGroupPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  final String avatar;
  final String email;

  const ChatGroupPage({
    Key? key,
    required this.userName,
    required this.groupId,
    required this.groupName,
    required this.avatar,
    required this.email,
  }) : super(key: key);

  @override
  State<ChatGroupPage> createState() => _ChatGroupPageState();
}

class _ChatGroupPageState extends State<ChatGroupPage> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messaagesController = TextEditingController();
  String admin = "";
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getChatandAdmin();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (_scrollController.hasClients) {
    //     _scrollController.animateTo(
    //       _scrollController.position.maxScrollExtent,
    //       curve: Curves.easeOut,
    //       duration: const Duration(milliseconds: 500),
    //     );
    //   }
    // });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName),
        backgroundColor: AppColor.orangePeel,
        actions: [
          IconButton(
              onPressed: () {
                // nextScreen(context, GroupInfo(groupId: widget.groupId, groupName: widget.groupName, adminName: admin,));
              },
              icon: const Icon(Icons.info_outline))
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
                color: AppColor.grayX11,
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: messaagesController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Vui lòng nhập",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        border: InputBorder.none,
                      ),
                    )),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                        _scrollToBottom();
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
            print("dongnd1 message: ${data[index]['message']}, index: $index");
            var isSameSenderBefore = false;
            if(index > 0) {
              isSameSenderBefore = data[index]['email'] == data[index-1]['email'];
            }
            return MessageTile(
              message: data[index]['message'],
              sender: data[index]['sender'],
              sentByMe: widget.userName == data[index]['sender'],
              avatar: data[index]['avatar'],
              isSameSenderBefore: isSameSenderBefore,
              email: data[index]['email'],
            );
          },
        );
      },
      stream: chats,
    );
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

  _scrollToBottom() {
    Timer(
        const Duration(seconds: 1),
        () => _scrollController
            .jumpTo(_scrollController.position.minScrollExtent));
  }
}
