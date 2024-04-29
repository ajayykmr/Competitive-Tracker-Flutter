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
    return Column(
      children: [
        const Center(
          child: Text(
            "Contests",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        contestList.when(
          data: (data) {
            if (data == null) {
              return const Text("NULL value received");
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
          bool isContestUpcoming = Utils.getDateTimeFromEpochSeconds(
                  contestList[index].startTimeSeconds!)
              .isAfter(DateTime.now());
          return Card(
            color: isContestUpcoming
                ? AppColor.secondary.withOpacity(0.75)
                : AppColor.secondary,
            // color: AppColor.secondary,
            child: ListTile(
              onTap: () {
                if (!isContestUpcoming) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ContestDetailsScaffold(contestList[index].id!),
                  ));
                }
              },
              title: Text(
                contestList[index].name.toString(),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Utils.getDateStringFromEpochSeconds(
                      contestList[index].startTimeSeconds!)),
                  Text(
                    Utils.getTimeStringFromEpochSeconds(
                        contestList[index].startTimeSeconds!),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
