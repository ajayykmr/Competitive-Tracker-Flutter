import 'package:competitive_tracker/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LineChartData lineChartData = LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: 1.0,
      ),
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(),
      ),
      borderData: FlBorderData(
        show: true,
      ),
      lineBarsData: [
        LineChartBarData(
          // spots: spots,
          spots: [
            FlSpot(0, 3),
            FlSpot(1, 1),
            FlSpot(2, 4),
            FlSpot(3, 2),
          ],
          // isCurved: true, // Optional: make the line curved
          color: AppColor.primary.withOpacity(0.9),
          barWidth: 2,
          isCurved: false,
          show: true,

          // isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,

          ),
          belowBarData: BarAreaData(
            show: true,
            color: AppColor.primary.withOpacity(0.2),
          ),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 500,
        child: Card(
          color: AppColor.secondary,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LineChart(
              lineChartData,
            ),
          ),
        ),
      ),
    );
  }
}
