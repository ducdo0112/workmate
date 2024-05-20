import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../model/user/user_info_data.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({
    Key? key,
    required this.userSelected,
    required this.listUserInfo,
    required this.selectUserChange
  }) : super(key: key);
  final List<UserInfoData> userSelected;
  final List<UserInfoData> listUserInfo;
  final Function(List<UserInfoData>) selectUserChange;

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {

  late List<UserInfoData> userSelected;
  late List<UserInfoData> listUserInfo;

  @override
  void initState() {
    super.initState();
    userSelected = [...widget.userSelected];
    listUserInfo = [...widget.listUserInfo];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (builder, index) {
        final item = listUserInfo[index];
        final isSelected = userSelected
            .firstWhere((element) => element.uid == item.uid,
                orElse: () => UserInfoData("", "", "", "", "", "", false, Timestamp.now()))
            .uid
            .isNotEmpty;
        return ListTile(
          onLongPress: () {},
          onTap: () {
            if (isSelected) {
              setState(() {
                userSelected.removeWhere((element) => element.uid == item.uid,);
              });
            } else {
              setState(() {
                userSelected.add(item);
              });
            }
            widget.selectUserChange.call(userSelected);
          },
          title: Row(
            children: [
              const Text("Name :  "),
              Text(item.fullName),
            ],
          ),
          subtitle: Wrap(
            children: [
              const Text("Email    :   "),
              Text(item.email),
            ],
          ),
          leading: Icon(
            isSelected ? Icons.check_box : Icons.check_box_outline_blank,
            color: Theme.of(context).primaryColor,
          ),
        );
      },
      itemCount: widget.listUserInfo.length,
    );
  }
}
