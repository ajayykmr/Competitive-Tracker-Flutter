import 'package:cflytics/models/contest_standings.dart';
import 'package:cflytics/providers/secure_storage_provider.dart';
import 'package:cflytics/ui/contest_details/screens/contest_user_submissions.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:cflytics/utils/constants.dart';
import 'package:cflytics/utils/utils.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class ContestStandingsScreen extends ConsumerStatefulWidget {
  final ContestStandings contestStandings;

  const ContestStandingsScreen(this.contestStandings, {super.key});

  @override
  ConsumerState<ContestStandingsScreen> createState() =>
      _ContestStandingsScreenState();
}

class _ContestStandingsScreenState
    extends ConsumerState<ContestStandingsScreen> {
  String? myHandle;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    final storage = ref.watch(secureStorageReadProvider);

    storage.whenData((value) => (value) {
          setState(() {
            myHandle = value[Constants.handleKey];
          });
        });

    return Column(
      children: [
        Text("Standings", style: textStyle.bodyLarge),
        Flexible(
            child: StandingsTable(
          widget.contestStandings,
          myHandle: myHandle,
        )),
      ],
    );
  }
}

class StandingsTable extends StatelessWidget {
  final ContestStandings contestStandings;
  late final int numberOfProblems;
  final String? myHandle;
  late final TextTheme textStyle;

  StandingsTable(this.contestStandings, {this.myHandle, super.key}) {
    numberOfProblems = contestStandings.result!.problems!.length;
  }

  @override
  Widget build(BuildContext context) {
    textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DataTable2(
        bottomMargin: 10,
        columnSpacing: 10,
        horizontalMargin: 0,
        fixedLeftColumns: 1,
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => AppColor.tableHeadingRowColor),
        dataRowHeight: 60,
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
          DataColumn2(
            label: Text("Handle", style: textStyle.titleMedium),
            size: ColumnSize.L,
          ),
          DataColumn2(
            // numeric: true,
            label: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Rank", style: textStyle.titleSmall),
                Text("(Points)", style: textStyle.bodySmall),
              ],
            ),
          ),
        ] +
        List<DataColumn2>.generate(
          numberOfProblems,
          (index) {
            return DataColumn2(
              label: Material(
                color: AppColor.tableHeadingRowColor,
                child: InkWell(
                  onTap: () => Utils.openProblem(
                      contestStandings.result!.problems![index]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(contestStandings.result!.problems![index].index!,
                          style: textStyle.titleSmall?.copyWith(
                            color: AppColor.hyperlink,
                            decoration: TextDecoration.underline,
                          )),
                      if (contestStandings.result!.problems![index].points !=
                          null)
                        Text(
                          "(${contestStandings.result!.problems![index].points!.toStringAsFixed(0)})",
                          style: textStyle.bodySmall,
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
              backgroundColor: AppColor.scaffoldBackground,
              context: context,
              // showDragHandle: true,
              useSafeArea: true,
              builder: (context) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.1,
                  maxChildSize: 1,
                  expand: false,
                  builder: (context, scrollController) {

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ContestUserSubmissionsScreen(
                        contestStandings,
                        givenHandle: contestStandings
                            .result!.rows![INDEX].party!.members![0].handle,
                        scrollController: scrollController,
                      ),
                    );
                  },
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
        style: textStyle.titleSmall?.copyWith(
          fontWeight: (handle == myHandle) ? FontWeight.w800 : FontWeight.w500,
          decoration: (handle == myHandle) ? TextDecoration.underline : null,
        ),
      ));
    } else {
      return DataCell(
        Text(
          "* ${contestStandings.result!.rows![INDEX].party!.members![0].handle!}",
          style: textStyle.titleSmall?.copyWith(
            fontWeight:
                (handle == myHandle) ? FontWeight.w400 : FontWeight.normal,
            decoration: (handle == myHandle) ? TextDecoration.underline : null,
          ),
        ),
      );
    }
  }

  DataCell buildRankDataCell(int INDEX) {
    final rank = contestStandings.result!.rows![INDEX].rank!;

    if (rank == 0) {
      return DataCell(
        Text("Practice", style: textStyle.bodySmall),
      );
    } else {
      return DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(contestStandings.result!.rows![INDEX].rank.toString(),
              textAlign: TextAlign.center, style: textStyle.titleSmall),
          Text(
              textAlign: TextAlign.center,
              "(${contestStandings.result!.rows![INDEX].points!.toInt()})",
              style: textStyle.bodySmall)
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
        return DataCell(
          Text("-", style: textStyle.titleSmall),
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
            style: textStyle.titleSmall?.copyWith(
              color: AppColor.plus,
            ),
          ),
          Text(
              Utils.getTimeStringFromSeconds(contestStandings
                  .result!
                  .rows![INDEX]
                  .problemResults![index]
                  .bestSubmissionTimeSeconds!),
              style: textStyle.bodySmall)
        ],
      ));
    } else if (rejectedCount > 0) {
      return DataCell(Text(
          "-${contestStandings.result!.rows![INDEX].problemResults![index].rejectedAttemptCount!}",
          style: textStyle.titleSmall?.copyWith(color: AppColor.minus)));
    } else {
      return DataCell(Text("-", style: textStyle.titleSmall));
    }
  }
}
