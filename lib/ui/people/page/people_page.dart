import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart';
import 'package:workmate/common/bloc/bloc_consumer_creation.dart';
import 'package:workmate/model/user/user_info_data.dart';
import 'package:workmate/ui/people/bloc/people_bloc.dart';
import 'package:workmate/ui/people/bloc/people_event.dart';
import 'package:workmate/ui/people/bloc/people_state.dart';

import '../../../common/color/app_color.dart';
import '../../../main/main_dev.dart';
import '../../../repository/firestore_repository.dart';
import '../../../repository/shared_preferences_repository.dart';
import '../../add_chat_group/widget/profile_widget_chat.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _users = [];
  List<dynamic> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    final userID = SharedPreferencesHelper.getStringType(
        SharedPreferencesHelper.keyUUID);
    if (query.isEmpty) {
      // No search query, show all users
      setState(() {
        _filteredUsers = _users.where((user) =>
        user.uid != userID && !user.isAdmin).toList();
      });
    } else {
      // Apply search filter
      setState(() {
        _filteredUsers = _users.where((user) =>
        user.fullName.toLowerCase().contains(query) &&
            user.uid != userID && !user.isAdmin).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
          create: (context) =>
              getIt<PeopleBloc>()..add(const PeopleEventInitFetched()),
          child: createBlocConsumer<PeopleEvent, PeopleState, PeopleBloc>(
              buildWhen: (previous, current) =>
                  previous.usersStream != current.usersStream,
              shouldShowLoadingFullScreen: true,
              builder: (context, state) {
                return StreamBuilder(
                    stream: state.usersStream,
                    builder: (context, AsyncSnapshot snapshot) {
                      // make some check
                      if (snapshot.hasData) {
                        final userDocs = snapshot.data.docs;
                        final userID = SharedPreferencesHelper.getStringType(
                            SharedPreferencesHelper.keyUUID);
                        final List<dynamic> allUsers = userDocs
                            .map((doc) => UserInfoData.fromJson(
                                (doc.data() as Map<String, dynamic>)))
                            .toList();

                        final users = allUsers.where((element) => element.uid != userID && element.isAdmin == false).toList();
                        if (_users.isEmpty) {
                          _users.addAll(users);
                          _filteredUsers.addAll(users);
                        }
                        return Scaffold(
                          body: Column(
                            children: [
                              _buildSearchField(context),
                              Expanded(child: _buildPeopleList(state)),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: Text("Something is wrong"));
                      }
                    });
              })),
    );
  }

  Widget _buildSearchField(context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.orangePeel), // Màu biên viền
        borderRadius: BorderRadius.circular(8), // Bo tròn góc
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Tìm kiếm...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
        ),
        onChanged: (query) {
          _onSearchChanged();
        },
        style: const TextStyle(color: Colors.black), // Màu chữ
      ),
    );
  }

  Widget _buildPeopleList(PeopleState state) {
    return ListView.builder(
      itemCount: _filteredUsers.length,
      itemBuilder: (context, index) {
        return ListTile(
          onLongPress: () {
            if (state.isAdmin == true) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Xóa người dùng'),
                    content:
                        const Text('Bạn có chắc chắn muốn xóa người dùng này?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Hủy'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          getIt<PeopleBloc>().add(PeopleEventDeleteUser(
                              uuid: _filteredUsers[index].uid));
                          setState(() {
                            _filteredUsers.removeWhere((element) =>
                                element.uid == _filteredUsers[index].uid);
                          });
                        },
                        child: const Text('Xóa'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ProfileWidgetChat(
              imageBase64: _filteredUsers[index].profilePic,
            ),
          ),
          title: Text(_filteredUsers[index].fullName,
              style: const TextStyle(fontSize: 16)),
          trailing: _buildActivityIndicator(
              _filteredUsers[index].status == "Hoạt động"),
        );
      },
    );
  }

  Widget _buildActivityIndicator(bool isActive) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.green : Colors.grey,
      ),
    );
  }
}
