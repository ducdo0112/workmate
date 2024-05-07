import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black26,
      child: const Center(
        child: Text("Chat page"),
      ),
    );
  }
}
