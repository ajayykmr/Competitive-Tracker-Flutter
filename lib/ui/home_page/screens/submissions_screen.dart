import 'package:cflytics/models/return_objects/submission.dart';
import 'package:cflytics/providers/api_provider.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:cflytics/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubmissionsListScreen extends ConsumerWidget {

  final String handle;
  const SubmissionsListScreen(this.handle, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final getUserAllSubmissions =
        ref.watch(GetUserAllSubmissionsProvider(handle));
    return Column(

      children: [
        Text(
          "My Submissions",
          style: textTheme.bodyLarge,
        ),
        Expanded(
          child: getUserAllSubmissions.when(
            data: (submissionsList) {
              if (submissionsList == null) {
                return const Center(
                  child: Text("NULL values received"),
                );
              }
              return SubmissionsListWidget(submissionsList);
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (error, stack) {
              return const Center(
                child: Text("Error in retrieving data"),
              );
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
        final submission = submissionsList[index];
        return SubmissionCard(submission: submission);
      },
    );
  }


}

class SubmissionCard extends StatelessWidget {
  final Submission submission;

  const SubmissionCard({super.key, required this.submission});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    var submissionPassed = submission.verdict == "OK";

    return InkWell(
      onTap: () {
        Utils.openSubmission(submission);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border(
            left: BorderSide(
              width: 10.0,
              color: (submissionPassed)
                  ? AppColor.green
                  : AppColor.red,
            ),
            right: BorderSide(
              width: 1.0,
              color: (submissionPassed)
                  ? AppColor.green
                  : AppColor.red,
            ),
            top: BorderSide(
              width: 1.0,
              color: (submissionPassed)
                  ? AppColor.green
                  : AppColor.red,
            ),
            bottom: BorderSide(
              width: 1.0,
              color: (submissionPassed)
                  ? AppColor.green
                  : AppColor.red,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      submission.problem!.name!,
                      style: textTheme.bodySmall,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: submission.id.toString(),
                            style: textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      maxLines: 1,
                      TextSpan(
                        children: [
                          TextSpan(
                              text: Utils.getDateStringFromEpochSeconds(
                                  submission.creationTimeSeconds!),
                              style: textTheme.labelSmall),
                          TextSpan(text: " | ", style: textTheme.labelSmall),
                          TextSpan(
                              text: Utils.getTimeStringFromEpochSeconds(
                                  submission.creationTimeSeconds!),
                              style: textTheme.labelSmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      textAlign: TextAlign.end,
                      Utils.getSubmissionVerdict(submission.verdict!),
                      style: textTheme.titleSmall?.copyWith(
                        color: (submissionPassed)
                            ? AppColor.plus
                            : AppColor.minus,
                      ),
                    ),
                    Text(
                        "${(submission.memoryConsumedBytes! / 1000000).toStringAsFixed(2)}MB",
                        style: textTheme.labelSmall),
                    Text(
                      "${submission.timeConsumedMillis}ms",
                      style: textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
