import 'package:competitive_tracker/models/return_objects/rating_changes.dart';
import 'package:competitive_tracker/utils/colors.dart';
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


    LineChartData lineChartData = LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: 100,

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
          spots: spots,
          show: true,
          // isCurved: true,

          color: AppColor.primary.withOpacity(1),
          barWidth: 2,
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

    return LineChart(
      lineChartData,
    );
  }
}
