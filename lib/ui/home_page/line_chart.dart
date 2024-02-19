import 'dart:math';

import 'package:cflytics/models/return_objects/rating_changes.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:cflytics/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RatingLineChart extends StatefulWidget {
  final List<RatingChanges> ratingChanges;

  const RatingLineChart({required this.ratingChanges, super.key});

  @override
  State<RatingLineChart> createState() => _RatingLineChartState();
}

class _RatingLineChartState extends State<RatingLineChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = widget.ratingChanges
        .map((ratingChange) => FlSpot(
            ratingChange.ratingUpdateTimeSeconds!.toDouble(),
            ratingChange.newRating!.toDouble()))
        .toList();

    Widget sideTitleWidgets(double value, TitleMeta meta) {

      int maxRating = widget.ratingChanges.first.newRating!;
      int minRating = widget.ratingChanges.first.newRating!;
      for (int i = 1; i < widget.ratingChanges.length; i++) {
        maxRating = max(maxRating, widget.ratingChanges[i].newRating!);
        minRating = min(minRating, widget.ratingChanges[i].newRating!);
      }

      if (maxRating % 100 != 0 &&
          value != maxRating &&
          maxRating - value < 100) {
        return Container();
      } else if (minRating % 100 != 0 &&
          value != minRating &&
          value - minRating < 100) {
        return Container();
      }
      return SideTitleWidget(
        child: Text(value.toStringAsFixed(0)),
        axisSide: meta.axisSide,
        // space: 10,
      );
    }

    Widget bottomTitleWidgets(double value, TitleMeta meta) {

      if (value == widget.ratingChanges.first.ratingUpdateTimeSeconds){
        return Container();
      }
      DateTime dateTime = Utils.getDateTimeFromEpochSeconds(value.toInt());

      String month = Utils.monthFromInteger(dateTime.month);
      String year = dateTime.year.toString();
      year = year.substring(2);

      return SideTitleWidget(
        axisSide: meta.axisSide,
        // space: 10,
        child: Column(
          children: [
            Text(
              month,
              style: const TextStyle(
                fontSize: 10,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              year,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      );
    }

    double timeInterval = ((widget.ratingChanges.last.ratingUpdateTimeSeconds! -
            widget.ratingChanges.first.ratingUpdateTimeSeconds!) /
        7);
    LineChartData lineChartData = LineChartData(
      gridData: const FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: 100,
      ),

      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: timeInterval,
            getTitlesWidget: bottomTitleWidgets,
            reservedSize: 40,
          ),
        ),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
          getTitlesWidget: sideTitleWidgets,
          interval: 100,
          showTitles: true,
          reservedSize: 45,
        )),
        rightTitles: const AxisTitles(),
      ),
      borderData: FlBorderData(
        show: true,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          show: true,
          // isCurved: true,
          isStrokeJoinRound: true,

          color: AppColor.primary.withOpacity(1),
          barWidth: 2,
          // isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: AppColor.primary.withOpacity(0.2),
          ),
        ),
      ],
    );

    print(timeInterval);
    return LineChart(
      lineChartData,
    );
  }
}
