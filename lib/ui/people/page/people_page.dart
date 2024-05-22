import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart';
import 'package:workmate/model/user/user_info_data.dart';
import 'package:workmate/ui/people/bloc/people_bloc.dart';
import 'package:workmate/ui/people/bloc/people_event.dart';
import 'package:workmate/ui/people/bloc/people_state.dart';

import '../../../common/color/app_color.dart';
import '../../../main/main_dev.dart';
import '../../../repository/firestore_repository.dart';
import '../../add_chat_group/widget/profile_widget_chat.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  final TextEditingController _searchController = TextEditingController();
  late List<UserInfoData> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    // FireStoreRepository().getUserStream().snapshots().listen((event) async {
    //   print("onChange");
    //   final listUserChange = await FireStoreRepository().getAllExceptMe();
    //   listUserChange.forEach((element) {
    //     print(element.fullName);
    //   });
    //   setState(() {
    //     _filteredUsers = listUserChange;
    //   });
    // });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = getIt<PeopleBloc>().state.users.where((user) {
        return user.fullName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => getIt<PeopleBloc>()..add(const PeopleEventInitFetched()),
        child: BlocBuilder<PeopleBloc, PeopleState>(
          builder: (context, state) {
            if (_searchController.text.isEmpty) {
              _filteredUsers = context.read<PeopleBloc>().state.users;
            }
            else {
              final query = _searchController.text.toLowerCase();
              _filteredUsers = context.read<PeopleBloc>().state.users.where((user) {
                return user.fullName.toLowerCase().contains(query);
              }).toList();
            }
            return Scaffold(
              body: Column(
                children: [
                  _buildSearchField(context),
                  Expanded(child: _buildPeopleList(state)),
                ],
              ),
            );
          },
        ),
      ),
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
            if (state.isAdmin) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Xóa người dùng'),
                    content: const Text('Bạn có chắc chắn muốn xóa người dùng này?'),
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
                          getIt<PeopleBloc>().add(PeopleEventDeleteUser(uuid: _filteredUsers[index].uid));
                          setState(() {
                            _filteredUsers.removeWhere((element) => element.uid == _filteredUsers[index].uid);
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
          title: Text(_filteredUsers[index].fullName, style: const TextStyle(fontSize: 16)),
          trailing: _buildActivityIndicator(_filteredUsers[index].status == "Hoạt động"),
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
