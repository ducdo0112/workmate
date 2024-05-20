import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:workmate/common/color/app_color.dart';
import 'package:workmate/common/widget/base_page.dart';
import 'package:workmate/main/main_dev.dart';
import 'package:workmate/repository/firestore_repository.dart';
import 'package:workmate/routing/app_routing.dart';
import 'package:workmate/ui/chat/bloc/chat_bloc.dart';
import 'package:workmate/ui/chat/bloc/chat_event.dart';
import 'package:workmate/ui/chat/bloc/chat_state.dart';
import 'package:workmate/ui/chat/page/widget/group_tile.dart';

import '../../../model/user/user_info_data.dart';
import '../../../repository/shared_preferences_repository.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  String userName = "";
  String avatarCurrentUser = "";
  String email = "";
  Stream? conversations;
  String conversationName = "";
  Stream? streamData;

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    // await HelperFunction.getUserNameFromSF().then((value){
    //   setState(() {
    //     userName = value!;
    //   });
    // });
    // await HelperFunction.getUserEmailFromSF().then((val) => {
    //   setState((){
    //     email = val!;
    //   })
    // });
    //getting the list of snapshot in our stream
    final email = await SharedPreferencesHelper.getStringType(
        SharedPreferencesHelper.keyEmail);
    if (email.isNotEmpty) {
      QuerySnapshot userInfoSnapshot =
          await FireStoreRepository(uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);
      final currentUser = UserInfoData.fromQuerySnapshot(userInfoSnapshot);
      avatarCurrentUser = currentUser.profilePic;
      this.email = email;
      userName = currentUser.fullName;
    }
    await FireStoreRepository(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserConversations()
        .then((snapshot) {
      setState(() {
        conversations = snapshot;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return buildBasePage(
      appBar: _buildAppBar(),
      backgroundColor: AppColor.white,
      extendBodyBehindAppBar: true,
      showDrawer: false,
      resizeToAvoidBottomInset: false,
      body: _buildBodyWidget(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 0,
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatBloc>()..add(const ChatListEventFetched()),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Scaffold(
            body: groupList(),
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: _buildFloatingButton(context),
          );
        },
      ),
    );
  }

  _buildFloatingButton(BuildContext context) {
    final _key = GlobalKey<ExpandableFabState>();
    return ExpandableFab(
      key: _key,
      type: ExpandableFabType.up,
      distance: 60.0,
      overlayStyle: ExpandableFabOverlayStyle(
        // color: Colors.black.withOpacity(0.5),
        blur: 5,
      ),
      closeButtonBuilder: FloatingActionButtonBuilder(
        size: 56,
        builder: (BuildContext context, void Function()? onPressed,
            Animation<double> progress) {
          return IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.close,
              color: AppColor.gainsBoro,
              size: 40,
            ),
          );
        },
      ),
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: AppColor.orangePeel,
        shape: const CircleBorder(),
      ),
      children: [
        FloatingActionButton.small(
          // shape: const CircleBorder(),
          foregroundColor: Colors.white,
          backgroundColor: AppColor.orangePeel,
          heroTag: null,
          child: const Icon(Icons.person_add_alt_rounded),
          onPressed: () {
            _closeFloatingButton(_key);
            Navigator.of(context)
                .pushNamed(RouteDefine.addChatGroup.name, arguments: false);
          },
        ),
        FloatingActionButton.small(
          // shape: const CircleBorder(),
          heroTag: null,
          backgroundColor: AppColor.orangePeel,
          child: const Icon(Icons.group_add),
          onPressed: () {
            _closeFloatingButton(_key);
            Navigator.of(context)
                .pushNamed(RouteDefine.addChatGroup.name, arguments: true);
          },
        ),
      ],
    );
  }

  groupList() {
    return StreamBuilder(
      stream: conversations,
      builder: (context, AsyncSnapshot snapshot) {
        // make some check
        if (snapshot.hasData) {
          if (snapshot.data['conversations'] != null) {
            if (snapshot.data['conversations'].length != 0) {
              return ListView.separated(
                itemCount: snapshot.data['conversations'].length,
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Divider(),
                  );
                },
                itemBuilder: (context, index) {
                  int reveseIndex = snapshot.data['conversations'].length - index - 1;
                  return GroupTile(
                    key: UniqueKey(),
                    conversationName: getName(snapshot.data['conversations'][reveseIndex]),
                    conversationId: getId(snapshot.data['conversations'][reveseIndex]),
                    userName: snapshot.data['fullName'],
                    avatar: avatarCurrentUser,
                    email: email,
                    currentUserName: userName,
                    groupMessageUnread: snapshot.data['statusReadMessages'],
                  );
                },
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Bạn chưa có cuộc trò chuyện nào, nhấn + để thêm mới",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  _closeFloatingButton(GlobalKey<ExpandableFabState> key) {
    final state = key.currentState;
    if (state != null) {
      state.toggle();
    }
  }
}
