import 'package:cflytics/models/contest_standings.dart';
import 'package:cflytics/models/return_objects/submission.dart';
import 'package:cflytics/providers/api_provider.dart';
import 'package:cflytics/providers/secure_storage_provider.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:cflytics/utils/constants.dart';
import 'package:cflytics/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContestUserSubmissionsScreen extends ConsumerWidget {
  final ContestStandings contestStandings;
  final ScrollController? scrollController;
  final String? givenHandle;

  const ContestUserSubmissionsScreen(this.contestStandings,
      {this.givenHandle, this.scrollController, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final storage = ref.watch(secureStorageReadProvider);

    return storage.when(
      data: (data) {
        final handle = givenHandle ?? data[Constants.handleKey];

        if (handle==null || handle.isEmpty){
          return const Center(child: Text("Please Enter a handle name"));
        }
        final getUserContestSubmissions = ref.watch(getUserContestSubmissionsProvider(
          contestStandings.result!.contest!.id!,
          handle,),
        );
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${handle}'s Submissions",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const Divider(

            ),
            getUserContestSubmissions.when(
              data: (data) {
                if (data == null) {
                  return const Text("NULL value received");
                }
                return Expanded(
                  child: ContestSubmissionsListWidget(
                    data,
                    scrollController: scrollController,
                  ),
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

    return const Center(child: Text("EMPTY BODY"));
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
        return Card(
          elevation: 0,
          color: ((submissionsList[index].verdict == "OK")
                  ? AppColor.plus
                  : AppColor.minus)
              .withOpacity(0.3),
          child: ListTile(
            onTap: () async {
              Utils.openSubmission(submissionsList[index]);
            },
            isThreeLine: false,
            // contentPadding: const EdgeInsets.all(10),
            title: Text(
              "${submissionsList[index].problem!.index}. ${submissionsList[index].problem!.name}",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: Text(
              Utils.getTimeStringFromSeconds(
                  submissionsList[index].relativeTimeSeconds!),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        );
      },
    );
  }
}
