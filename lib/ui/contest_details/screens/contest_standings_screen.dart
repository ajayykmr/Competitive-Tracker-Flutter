import 'package:competitive_tracker/models/contest_standings.dart';
import 'package:competitive_tracker/ui/contest_details/screens/contest_user_submissions.dart';
import 'package:competitive_tracker/utils/colors.dart';
import 'package:competitive_tracker/utils/constants.dart';
import 'package:competitive_tracker/utils/utils.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ContestStandingsScreen extends StatefulWidget {
  final ContestStandings contestStandings;

  const ContestStandingsScreen(this.contestStandings, {super.key});

  @override
  State<ContestStandingsScreen> createState() => _ContestStandingsScreenState();
}

class _ContestStandingsScreenState extends State<ContestStandingsScreen>
    with AutomaticKeepAliveClientMixin<ContestStandingsScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const Text(
          "Standings",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        Flexible(child: StandingsTable(widget.contestStandings)),
      ],
    );
  }
}

class StandingsTable extends StatelessWidget {

  final ContestStandings contestStandings;
  late final int numberOfProblems;

  StandingsTable(this.contestStandings, {super.key}) {
    numberOfProblems = contestStandings.result!.problems!.length;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DataTable2(
        bottomMargin: 10,
        columnSpacing: 10,
        horizontalMargin: 0,
        fixedLeftColumns: 1,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.grey.shade200),
        dataRowHeight: 55,
        fixedColumnsColor: AppColor.secondary,
        minWidth: 700,
        lmRatio: 2,
        smRatio: 0.75,
        columns: buildColumns(),
        rows: buildRows(context),
      ),
    );
  }

  List<DataColumn2> buildColumns() {
    return <DataColumn2>[
          const DataColumn2(
            label: Text("Handle"),
            size: ColumnSize.L,
          ),
          const DataColumn2(
            // numeric: true,
            label: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Rank",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "(Points)",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ] +
        List<DataColumn2>.generate(
          numberOfProblems,
          (index) {
            return DataColumn2(
              label: Material(
                color: Colors.grey.shade200,
                child: InkWell(

                  onTap: () => Utils.openProblem(contestStandings.result!.problems![index]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        contestStandings.result!.problems![index].index!,
                        style: const TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                      if (contestStandings.result!.problems![index].points != null)
                        Text(
                          "(${contestStandings.result!.problems![index].points!.toStringAsFixed(0)})",
                          style: const TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }

  List<DataRow2> buildRows(BuildContext context) {
    return List<DataRow2>.generate(
      contestStandings.result!.rows!.length,
      (INDEX) {
        return DataRow2(
          onTap: () {
            showModalBottomSheet(

              enableDrag: true,
              isDismissible: true,
              isScrollControlled: true,

              backgroundColor: AppColor.secondary,

              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    minChildSize: 0.1,
                    maxChildSize:  0.95,
                    expand: false,
                    builder: (context, scrollController) =>  ContestUserSubissionsScreen(contestStandings,
                        handle: contestStandings
                            .result!.rows![INDEX].party!.members![0].handle, scrollController: scrollController,),
                  ),
                );
              },
            );
          },
          cells: <DataCell>[
                buildHandleDataCell(INDEX),
                buildRankDataCell(INDEX),
              ] +
              List<DataCell>.generate(
                numberOfProblems,
                (index) {
                  return buildProblemDataCell(INDEX, index);
                },
              ),
        );
      },
    );
  }

  DataCell buildHandleDataCell(int INDEX) {
    final rank = contestStandings.result!.rows![INDEX].rank!;
    final String handle =
        contestStandings.result!.rows![INDEX].party!.members![0].handle!;
    if (rank > 0) {
      return DataCell(Text(
        "${INDEX + 1}. $handle",
        style: TextStyle(
          fontWeight:
              (handle == Constants.userID) ? FontWeight.w800 : FontWeight.w500,
          decoration:
              (handle == Constants.userID) ? TextDecoration.underline : null,
        ),
      ));
    } else {
      return DataCell(
        Text(
          "* ${contestStandings.result!.rows![INDEX].party!.members![0].handle!}",
          style: TextStyle(
            fontWeight: (handle == Constants.userID)
                ? FontWeight.w400
                : FontWeight.normal,
            decoration:
                (handle == Constants.userID) ? TextDecoration.underline : null,
          ),
        ),
      );
    }
  }

  DataCell buildRankDataCell(int INDEX) {
    final rank = contestStandings.result!.rows![INDEX].rank!;

    if (rank == 0) {
      return const DataCell(
        Text(
          "Practice",
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    } else {
      return DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            contestStandings.result!.rows![INDEX].rank.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            textAlign: TextAlign.center,
            "(${contestStandings.result!.rows![INDEX].points!.toInt()})",
            style: const TextStyle(fontSize: 12),
          )
        ],
      ));
    }
  }

  DataCell buildProblemDataCell(int INDEX, int index) {
    final int points = contestStandings
        .result!.rows![INDEX].problemResults![index].points!
        .toInt();
    final int rejectedCount = contestStandings
        .result!.rows![INDEX].problemResults![index].rejectedAttemptCount!;
    final int rank = contestStandings.result!.rows![INDEX].rank!;

    if (rank == 0) {
      if (points > 0) {
        return const DataCell(
          // Text(
          //   "Solved",
          //   style: TextStyle(
          //     color: AppColor.plus,
          //   ),
          // ),
          Icon(
            Icons.check_rounded,
            color: AppColor.plus,
          ),
        );
      } else {
        return const DataCell(
          Text(
            "-",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      }
    }

    if (points > 0) {
      return DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            points.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.plus,
                fontSize: 14),
          ),
          Text(
            Utils.getTimeStringFromSeconds(contestStandings.result!.rows![INDEX]
                .problemResults![index].bestSubmissionTimeSeconds!),
            style: const TextStyle(fontSize: 12),
          )
        ],
      ));
    } else if (rejectedCount > 0) {
      return DataCell(Text(
        "-${contestStandings.result!.rows![INDEX].problemResults![index].rejectedAttemptCount!}",
        style:
            const TextStyle(color: AppColor.minus, fontWeight: FontWeight.bold),
      ));
    } else {
      return const DataCell(Text(
        "-",
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
    }
  }
}
