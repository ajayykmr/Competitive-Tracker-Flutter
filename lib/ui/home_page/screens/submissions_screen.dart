import 'package:competitive_tracker/api/services.dart';
import 'package:competitive_tracker/models/return_objects/submission.dart';
import 'package:competitive_tracker/utils/colors.dart';
import 'package:competitive_tracker/utils/constants.dart';
import 'package:competitive_tracker/utils/utils.dart';
import 'package:flutter/material.dart';

class SubmissionsListScreen extends StatefulWidget {
  const SubmissionsListScreen({super.key});

  @override
  State<SubmissionsListScreen> createState() => _SubmissionsListScreenState();
}

class _SubmissionsListScreenState extends State<SubmissionsListScreen> with AutomaticKeepAliveClientMixin<SubmissionsListScreen>{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const Text(
          "My Submissions",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Submission>?>(
            future: ApiServices().getUserAllSubmissions(Constants.userID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return SubmissionsListWidget(snapshot.data!);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text("Failed"),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class SubmissionsListWidget extends StatelessWidget {
  final List<Submission> submissionsList;

  const SubmissionsListWidget(
    this.submissionsList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: submissionsList.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: ((submissionsList[index].verdict=="OK") ? AppColor.plus : AppColor.minus).withOpacity(0.3),
          child: ListTile(
            onTap: () async {
              Utils.openSubmission(submissionsList[index]);
            },
            isThreeLine: false,
            contentPadding: const EdgeInsets.all(10),
            title: Text(
              submissionsList[index].problem!.name!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  submissionsList[index].id.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${Utils.getDateStringFromEpochSeconds(submissionsList[index].creationTimeSeconds!)}  ||  ${Utils.getTimeStringFromEpochSeconds(submissionsList[index].creationTimeSeconds!)}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  submissionsList[index].verdict!,
                  style: TextStyle(fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: (submissionsList[index].verdict=="OK")?
                      AppColor.plus: AppColor.minus,
                  ),
                ),
                Text(
                  "${(submissionsList[index].memoryConsumedBytes! / 1000000).toStringAsFixed(2)}MB",
                  style: const TextStyle(fontSize: 12,
                  ),
                ),
                Text(
                  "${submissionsList[index].timeConsumedMillis}ms",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
