import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:workmate/common/widget/base_page.dart';
import 'package:workmate/model/event/event.dart';
import 'package:workmate/routing/app_routing.dart';
import 'package:workmate/service/firebase/firebase_remote_message_service.dart';
import 'package:workmate/ui/calendar/bloc/calender_bloc.dart';
import 'package:workmate/ui/calendar/bloc/calender_event.dart';
import 'package:workmate/ui/calendar/bloc/calender_state.dart';
import 'package:workmate/ui/events/page/add_event_page.dart';
import 'package:workmate/utils/timestamp.dart';

import '../../../common/bloc/bloc_consumer_creation.dart';
import '../../../common/color/app_color.dart';
import '../../../main/main_dev.dart';
import '../../../service/firebase/alarm_manager_service.dart';
import '../widget/calendar_avatar_header.dart';
import '../widget/horizontal_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  PreferredSizeWidget? appBar;
  bool hasBuildAppBarWithImage = false;
  bool hasDateSelectedChange = false;
  Widget? avatarIcon;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<CalendarBloc>()
          ..add(CalendarEventInitFetched(DateTime.now())),
        child: createBlocConsumer<CalendarEvent, CalendarState, CalendarBloc>(
          listener: (p0, p1) {},
          buildWhen: (previous, current) =>
              previous.status != current.status ||
              previous.dateTimeSelected != current.dateTimeSelected ||
              previous.needRebuildAppBar != current.needRebuildAppBar,
          builder: (context, state) {
            return buildBasePage(
              appBar: _buildAppBar(state, context),
              backgroundColor: AppColor.white,
              extendBodyBehindAppBar: true,
              showDrawer: false,
              resizeToAvoidBottomInset: false,
              showFloatingActionButton: true,
              body: _buildBodyWidget(state, context),
              floatingButtonAction: () async {
                Navigator.of(context).pushNamed(RouteDefine.addEvent.name,
                    arguments: AddEventPageArgs(
                      eventId: null,
                      dateTime: state.dateTimeSelected ?? DateTime.now(),
                    ));
              },
            );
          },
        ));
  }

  Widget _buildBodyWidget(CalendarState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 120),
        _buildHorizontalDateTimeView(state, context),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text("Danh sách công việc hôm nay"),
        ),
        const SizedBox(height: 16),
        Expanded(child: _buildEventList(context))
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(
      CalendarState calendarState, BuildContext context) {
    if (avatarIcon == null && calendarState.user != null) {
      avatarIcon = IconButton(
        onPressed: () async {},
        icon: CalendarAvatarHeader(
          imageBase64: calendarState.user?.profilePic ?? '',
        ),
      );
    }
    if (true) {
      if (calendarState.user != null) {
        hasBuildAppBarWithImage = true;
      }

      if (hasDateSelectedChange) {
        hasDateSelectedChange = false;
      }

      // if(calendarState.needRebuildAppBar) {
      //   context.read<CalendarBloc>().add(const CalendarChangeStateRebuildAppbar(false));
      // }
      appBar = null;

      appBar = AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: avatarIcon,
        title: GestureDetector(
          onTap: () {
            _showDatePicker(context, calendarState);
          },
          child: Text(TimestampUtil.getNameOfMonthInVietName(
            calendarState.dateTimeSelected ?? DateTime.now(),
          )),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      );
    }
    return appBar!;
  }

  _showDatePicker(BuildContext context, CalendarState calendarState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: calendarState.dateTimeSelected ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      locale: Locale('vi', 'VN'),
    );

    if (picked != null) {
      hasDateSelectedChange = true;
      context.read<CalendarBloc>().add(CalendarEventInitFetched(picked));
    }
    print("dongnd1 picker: $picked");
  }

  _buildHorizontalDateTimeView(
      CalendarState calendarState, BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (previous, current) =>
          previous.dateTimeSelected != current.dateTimeSelected,
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: 1,
              color: AppColor.brightGray,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: HorizontalCalendar(
                initDateTime: state.dateTimeSelected,
                daySelect: (DateTime dateTime) {
                  context
                      .read<CalendarBloc>()
                      .add(CalendarEventInitFetched(dateTime));
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: AppColor.brightGray,
            ),
          ],
        );
      },
    );
  }

  _buildEventList(BuildContext context) {
    return createBlocConsumer<CalendarEvent, CalendarState, CalendarBloc>(
      buildWhen: (previous, current) =>
          previous.eventsStream != current.eventsStream,
      shouldShowLoadingFullScreen: true,
      builder: (context, state) {
        return StreamBuilder(
          stream: state.eventsStream,
          builder: (context, AsyncSnapshot snapshot) {
            // make some check
            if (snapshot.hasData) {
              final test1 = snapshot.data.docs;
              final List<dynamic> test = test1
                  .map((doc) =>
                      Event.fromJson((doc.data() as Map<String, dynamic>)))
                  .toList();
              final test2 = test
                  .where((element) =>
                      element.users?.contains(state.user?.uid) ?? false)
                  .toList();
              test2.sort((a, b) => mySortComparison(a.hourStart, b.hourStart));
              if (test2.isEmpty) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: const Center(
                    child: Text("Không có sự kiện nào hôm nay, nhấn + để thêm"),
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: test2.length,
                itemBuilder: (context, index) {
                  final item = test2[index];
                  return _buildItemEvent(
                      item.id,
                      item.title,
                      item.note,
                      item.hourStart,
                      item.hourEnd,
                      item.tag,
                      context,
                      state.dateTimeSelected ?? DateTime.now());
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.orangePeel,
                ),
              );
            }
          },
        );
      },
    );
  }

  int mySortComparison(String timeOfDay1String, String timeOfDay2String) {
    TimeOfDay timeOfDay1 =
        TimestampUtil.convertStringToTimeOfDay(timeOfDay1String)!;
    TimeOfDay timeOfDay2 =
        TimestampUtil.convertStringToTimeOfDay(timeOfDay2String)!;
    final propertyA = timeOfDay1.hour * 60 + timeOfDay1.minute;
    final propertyB = timeOfDay2.hour * 60 + timeOfDay2.minute;
    if (propertyA < propertyB) {
      return -1;
    } else if (propertyA > propertyB) {
      return 1;
    } else {
      return 0;
    }
  }

  _buildItemEvent(String id, String title, String note, String hourStart,
      String hourEnd, String tag, BuildContext context, DateTime dateTime) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteDefine.addEvent.name,
            arguments: AddEventPageArgs(eventId: id, dateTime: dateTime));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          color: getColorForCardItemByTag(tag),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('''
            
    $hourStart
        ~
    $hourEnd
      '''),
              SizedBox(
                width: 8,
              ),
              const Dash(
                  direction: Axis.vertical,
                  length: 100,
                  dashLength: 2,
                  dashColor: Colors.white),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(note.isEmpty ? "Không có thông tin ghi chú" : note,
                        style: const TextStyle(
                          fontSize: 12,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getColorForCardItemByTag(String color) {
    switch (color) {
      case "red":
        return Colors.red.withOpacity(0.1);
      case "green":
        return Colors.green.withOpacity(0.1);
      case "blue":
        return Colors.blue.withOpacity(0.1);
      default:
        return Colors.red.withOpacity(0.1);
    }
  }
}
