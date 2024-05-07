import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.red,
      child: const Center(
        child: Text("CalendarPage"),
      ),
    );
  }
}
