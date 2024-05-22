import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../common/bloc/bloc_consumer_creation.dart';
import '../../../main/main_dev.dart';
import '../../../model/statistic/statistic_point.dart';
import '../bloc/statistic_bloc.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  StatisticType? selectedStatisticLabel = StatisticType.sumOfActiveUser;

  @override
  void initState() {
    super.initState();
    getIt<StatisticBloc>()
        .add(const SelectStatisticTypeEvent(StatisticType.sumOfActiveUser));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
        ),
        home: Scaffold(
            body: SafeArea(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: DropdownButton<StatisticType>(
                value: selectedStatisticLabel,
                hint: const Text('Chọn loại thống kê'),
                onChanged: (StatisticType? label) {
                  setState(() {
                    setState(() {
                      selectedStatisticLabel = label;
                      getIt<StatisticBloc>().add(SelectStatisticTypeEvent(label!));
                    });
                  });
                },
                items: StatisticType.values
                    .map<DropdownMenuItem<StatisticType>>(
                        (StatisticType label) {
                  return DropdownMenuItem<StatisticType>(
                    value: label,
                    child: Text(label.label),
                  );
                }).toList(),
              ),
            ),
            Expanded(
                child: BlocProvider(
                    create: (context) => getIt<StatisticBloc>()
                      ..add(const SelectStatisticTypeEvent(
                          StatisticType.sumOfActiveUser)),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: createBlocConsumer<
                            StatisticEvent,
                            StatisticState,
                            StatisticBloc>(builder: (context, state) {
                          if (state.totalUsers != 0) {
                            print("Run 1");
                            return selectedStatisticLabel!.page(
                                state.totalUsers,
                                state.activeUsers,
                                state.dataUserCreate);
                          } else if (state.selectedType ==
                              StatisticType.userCreatedByTime) {
                            print("Run 2");
                            return selectedStatisticLabel!.page(
                                state.totalUsers,
                                state.activeUsers,
                                state.dataUserCreate);
                          } else {
                            print("Run 3");
                            return selectedStatisticLabel!.page(
                                state.totalUsers,
                                state.activeUsers,
                                state.dataUserCreate);
                          }
                        })))),
          ]),
        )));
  }
}

Widget _buildSumOfActiveUserPage(int? usersNumber, int? activeUser) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 240, // Giảm kích thước của PieChart
        width: 240,
        child: PieChart(
          PieChartData(
            borderData: FlBorderData(show: true),
            sectionsSpace: 4,
            sections: _buildPieChartSections(usersNumber ?? 0, activeUser ?? 0),
          ),
        ),
      ),
      const SizedBox(
        height: 32,
      ),
      _buildLegend(usersNumber ?? 0, activeUser ?? 0),
    ],
  );
}

List<PieChartSectionData> _buildPieChartSections(
    int usersNumber, int activeUser) {
  double inActiveUsers = (usersNumber - activeUser).toDouble();
  return [
    PieChartSectionData(
      color: Colors.blue,
      value: activeUser.toDouble(),
      title: activeUser.toDouble().toString(),
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      color: Colors.purple,
      value: inActiveUsers,
      title: inActiveUsers.toString(),
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      color: Colors.lightGreen,
      value: usersNumber.toDouble(),
      title: usersNumber.toDouble().toString(),
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ];
}

Widget _buildLegend(int usersNumber, int activeUser) {
  return Column(
    children: [
      _buildLegendItem(Colors.blue, "Người dùng đang hoạt động: ${activeUser}"),
      const SizedBox(height: 4),
      _buildLegendItem(
          Colors.purple, "Người dùng vắng mặt: ${usersNumber - activeUser}"),
      const SizedBox(height: 4),
      _buildLegendItem(Colors.lightGreen, "Tổng số người dùng: ${usersNumber}"),
    ],
  );
}

Widget _buildLegendItem(Color color, String text) {
  return Row(
    children: [
      Container(
        width: 16,
        height: 16,
        color: color,
      ),
      const SizedBox(width: 8),
      Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    ],
  );
}

Widget _buildCreateUserByDayPage(List<StatisticPoint> data) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            title: const ChartTitle(text: 'Lượng người dùng tạo mới hàng tháng'),
            legend: const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<StatisticPoint, String>>[
              LineSeries<StatisticPoint, String>(
                  dataSource: data,
                  xValueMapper: (StatisticPoint sales, _) => sales.month,
                  yValueMapper: (StatisticPoint sales, _) => sales.value,
                  name: 'Người dùng',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            //Initialize the spark charts widget
            child: SfSparkLineChart.custom(
              //Enable the trackball
              trackball: const SparkChartTrackball(
                  activationMode: SparkChartActivationMode.tap),
              //Enable marker
              marker: const SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all),
              //Enable data label
              labelDisplayMode: SparkChartLabelDisplayMode.all,
              xValueMapper: (int index) => data[index].month,
              yValueMapper: (int index) => data[index].value,
              dataCount: 5, // Change this number to show number of data
            ),
          ),
        )
      ],
    ),
  );
}

List<StatisticPoint> data = [
  StatisticPoint("20", 60),
  StatisticPoint("10", 70),
  StatisticPoint("30", 80),
  StatisticPoint("10", 90),
  StatisticPoint("50", 100),
];

Widget _buildSumOfGroupChat() {
  // Replace with actual data and UI
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            title: const ChartTitle(text: 'Lượng người dùng tạo mới hàng tháng'),
            legend: const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<StatisticPoint, String>>[
              LineSeries<StatisticPoint, String>(
                  dataSource: data,
                  xValueMapper: (StatisticPoint sales, _) => sales.month,
                  yValueMapper: (StatisticPoint sales, _) => sales.value,
                  name: 'Người dùng',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
      ],
    ),
  );
}

extension StatisticTypeExtension on StatisticType {
  String get label {
    switch (this) {
      case StatisticType.sumOfActiveUser:
        return "Người dùng đang hoạt động";
      case StatisticType.userCreatedByTime:
        return "Tài khoản tạo mới";
      case StatisticType.sumOfGroupChat:
        return "Nhóm chat";
    }
  }

  Widget page(
      int? totalUsers, int? activeUsers, List<StatisticPoint>? dataUserCreate) {
    switch (this) {
      case StatisticType.sumOfActiveUser:
        return _buildSumOfActiveUserPage(totalUsers, activeUsers);
      case StatisticType.userCreatedByTime:
        return _buildCreateUserByDayPage(dataUserCreate ?? []);
      case StatisticType.sumOfGroupChat:
        return _buildSumOfGroupChat();
    }
  }
}
