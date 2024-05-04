import 'package:cflytics/models/return_objects/contest.dart';
import 'package:cflytics/providers/api_provider.dart';
import 'package:cflytics/ui/contest_details/contest_details_scaffold.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:cflytics/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContestsListScreen extends ConsumerWidget {
  const ContestsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contestList = ref.watch(getContestsListProvider);
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        Center(
          child: Text("Contests", style: textStyle.bodyLarge),
        ),
        contestList.when(
          data: (data) {
            if (data == null) {
              return Center(child: const Text("NULL value received"));
            }
            return Expanded(
              child: ContestListWidget(data),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text("Error:"),
            );
          },
        ),
      ],
    );
  }
}

class ContestListWidget extends StatelessWidget {
  final List<Contest> contestList;

  const ContestListWidget(this.contestList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: ListView.builder(
        itemCount: contestList.length,
        itemBuilder: (context, index) {
          return ContestCard(contest: contestList[index]);
        },
      ),
    );
  }
}

class ContestCard extends StatelessWidget {
  final Contest contest;

  const ContestCard({super.key, required this.contest});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    // final bool isUpcomingContest = Utils.getDateTimeFromEpochSeconds(contest.startTimeSeconds!).isAfter(DateTime.now());
    final bool isUpcomingContest = contest.phase == "BEFORE";
    return InkWell(
      onTap: () {
        if (!isUpcomingContest) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContestDetailsScaffold(
                contest.id!,
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border(
            left: BorderSide(
              width: 10.0,
              color: isUpcomingContest
                  ? AppColor.secondaryTextColor
                  : AppColor.primary,
            ),
            right: BorderSide(
              width: 1.0,
              color: isUpcomingContest
                  ? AppColor.secondaryTextColor
                  : AppColor.primary,
            ),
            top: BorderSide(
              width: 1.0,
              color: isUpcomingContest
                  ? AppColor.secondaryTextColor
                  : AppColor.primary,
            ),
            bottom: BorderSide(
              width: 1.0,
              color: isUpcomingContest
                  ? AppColor.secondaryTextColor
                  : AppColor.primary,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contest.name!,
                      style: textTheme.bodySmall,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Type: ", style: textTheme.labelSmall),
                          TextSpan(
                            text: contest.type,
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      maxLines: 1,
                      TextSpan(
                        children: [
                          TextSpan(text: "ID: ", style: textTheme.labelSmall),
                          TextSpan(
                            text: contest.id.toString(),
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          Utils.getDateStringFromEpochSeconds(
                              contest.startTimeSeconds!),
                          style: textTheme.bodySmall),
                      Text(
                        Utils.getTimeStringFromEpochSeconds(
                            contest.startTimeSeconds!),
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  if (!isUpcomingContest)
                    const Icon(
                      Icons.arrow_right_rounded,
                      color: AppColor.primaryTextColor,
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
