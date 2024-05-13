import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workmate/common/color/app_color.dart';

import '../../../model/calendar_item/calendar_item.dart';

class HorizontalCalendar extends StatefulWidget {
  const HorizontalCalendar({Key? key, required this.daySelect})
      : super(key: key);
  final ValueChanged<DateTime> daySelect;

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  late List<DateTime> listDayOfMonth;
  late DateTime selectedDateTime;
  final ScrollController _scrollController = ScrollController();
  int indexDaySelect = 0;

  @override
  void initState() {
    super.initState();
    listDayOfMonth = getDaysOfMonth(DateTime.now());
    selectedDateTime = DateTime.now();
    indexDaySelect = selectedDateTime.day - 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToItem(indexDaySelect);
    });
  }

  void scrollToItem(int index) {
    if (index > 5) {
      index = index - 2;
    }
    _scrollController.animateTo(
      index * 54.0,
      duration: const Duration(milliseconds: 500), // Thời gian di chuyển
      curve: Curves.easeInOut, // Kiểu di chuyển
    );
  }

  List<DateTime> getDaysOfMonth(DateTime month) {
    List<DateTime> days = [];
    DateTime firstDay = DateTime(month.year, month.month, 1);
    DateTime lastDay = DateTime(month.year, month.month + 1, 0);

    for (DateTime date = firstDay;
        date.isBefore(lastDay);
        date = date.add(const Duration(days: 1))) {
      days.add(date);
    }

    days.add(lastDay);

    return days;
  }

  String getDayOfWeekInEnglish(DateTime date) {
    DateFormat formatter = DateFormat('EEEE', 'en');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: listDayOfMonth.length,
          itemBuilder: (BuildContext context, int index) {
            final item = listDayOfMonth[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(getDayOfWeekInEnglish(item).substring(0, 1)),
                  const SizedBox(height: 4),
                  Expanded(
                      child: item.day == selectedDateTime.day
                          ? Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                // Hình dạng của container là hình tròn
                                color: AppColor
                                    .orangePeel, // Màu nền của container
                              ),
                              child: Center(
                                child: Text(
                                  listDayOfMonth[index].day.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.white),
                                ),
                              ))
                          : Container(
                              width: 30,
                              height: 30,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDateTime = item;
                                  });
                                  widget.daySelect.call(selectedDateTime);
                                },
                                child: Center(
                                    child: Text(
                                        listDayOfMonth[index].day.toString())),
                              ),
                            )),
                ],
              ),
            );
          }),
    );
  }
}
