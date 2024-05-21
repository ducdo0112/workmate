import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmate/model/user/user_info_data.dart';
import 'package:workmate/ui/people/bloc/people_bloc.dart';
import 'package:workmate/ui/people/bloc/people_event.dart';
import 'package:workmate/ui/people/bloc/people_state.dart';

import '../../../common/color/app_color.dart';
import '../../../main/main_dev.dart';
import '../../add_chat_group/widget/profile_widget_chat.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  final TextEditingController _searchController = TextEditingController();
  late List<UserInfoData> _originalUsers;

  @override
  void initState() {
    super.initState();
    _originalUsers = getIt<PeopleBloc>().state.users;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => getIt<PeopleBloc>()..add(const PeopleEventInitFetched()),
        child: BlocBuilder<PeopleBloc, PeopleState>(
          builder: (context, state) {
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
        style: const TextStyle(color: Colors.black), // Màu chữ
        onChanged: (query) {
          getIt<PeopleBloc>().add(PeopleEventSearch(query: query));
        },
      ),
    );
  }

  Widget _buildPeopleList(PeopleState state) {
    return ListView.builder(
      itemCount: state.users.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ProfileWidgetChat(
              imageBase64: state.users[index].profilePic,
            ),
          ),
          title: Text(state.users[index].fullName, style: const TextStyle(fontSize: 16)),
          trailing: _buildActivityIndicator(state.users[index].status == "Hoạt động"),
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
