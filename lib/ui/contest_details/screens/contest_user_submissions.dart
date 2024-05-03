import 'package:cflytics/models/contest_standings.dart';
import 'package:cflytics/models/return_objects/submission.dart';
import 'package:cflytics/providers/api_provider.dart';
import 'package:cflytics/providers/secure_storage_provider.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:cflytics/utils/constants.dart';
import 'package:cflytics/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContestUserSubmissionsScreen extends ConsumerWidget {
  final ContestStandings contestStandings;
  final ScrollController? scrollController;
  final String? givenHandle;

  const ContestUserSubmissionsScreen(this.contestStandings,
      {this.givenHandle, this.scrollController, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final storage = ref.watch(secureStorageReadProvider);

    return storage.when(
      data: (data) {
        final handle = givenHandle ?? data[Constants.handleKey];


        if (handle == null || handle.isEmpty) {
          return Center(child: Text("Please Enter a handle name", style:textTheme.bodySmall,));
        }
        final getUserContestSubmissions = ref.watch(
          getUserContestSubmissionsProvider(
            contestStandings.result!.contest!.id!,
            handle,
          ),
        );
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$handle's Submissions",
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            Flexible(
              child: getUserContestSubmissions.when(
                data: (data) {
                  if (data == null) {
                    return const Text("NULL value received");
                  }
                  return ContestSubmissionsListWidget(
                    data,
                    scrollController: scrollController,
                  );
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  return const Center(
                    child: Text("Failed"),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return const Center(
          child: Text("Secure Storage Error"),
        );
      },
    );

  }
}

class ContestSubmissionsListWidget extends StatelessWidget {
  final List<Submission> submissionsList;
  final ScrollController? scrollController;

  const ContestSubmissionsListWidget(
    this.submissionsList, {
    this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      controller: scrollController,
      itemCount: submissionsList.length,
      itemBuilder: (context, index) {
        return ContestUserSubmissionCard(submissionsList[index]);
      },
    );
  }
}

class ContestUserSubmissionCard extends StatelessWidget {
  final Submission submission;
  const ContestUserSubmissionCard(this.submission, {super.key});
  @override
  Widget build(BuildContext context) {
    final passed = submission.verdict=="OK";

    final TextTheme textStyle = Theme.of(context).textTheme;
    return InkWell(
      onTap: () async {
        Utils.openSubmission(submission);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border(
            left: BorderSide(
              width: 10.0,
              color: passed ? AppColor.green : AppColor.red
            ),
            right: BorderSide(
              width: 1.0,
                color: passed ? AppColor.green : AppColor.red
            ),
            top: BorderSide(
              width: 1.0,
                color: passed ? AppColor.green : AppColor.red
            ),
            bottom: BorderSide(
              width: 1.0,
                color: passed ? AppColor.green : AppColor.red
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "${submission.problem!.index}. ${submission.problem!.name}",
              style: textStyle.bodyMedium,
            ),
            Row(
              children: [
                Text(
                  Utils.getTimeStringFromSeconds(
                      submission.relativeTimeSeconds!),
                  style: textStyle.labelMedium,
                ),
                const Icon(Icons.arrow_right_rounded, color: AppColor.primaryTextColor,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
