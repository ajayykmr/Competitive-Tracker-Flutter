import 'package:competitive_tracker/api/services.dart';
import 'package:competitive_tracker/models/contest_standings.dart';
import 'package:competitive_tracker/models/return_objects/submission.dart';
import 'package:competitive_tracker/utils/colors.dart';
import 'package:competitive_tracker/utils/constants.dart';
import 'package:competitive_tracker/utils/utils.dart';
import 'package:flutter/material.dart';

class ContestUserSubissionsScreen extends StatefulWidget {
  final ContestStandings contestStandings;
  late final String userID;
  late final ScrollController? scrollController;

  ContestUserSubissionsScreen(this.contestStandings,
      {String? handle, this.scrollController, super.key}) {
    userID = handle ?? Constants.userID;
  }

  @override
  State<ContestUserSubissionsScreen> createState() =>
      _ContestUserSubissionsScreenState();
}

class _ContestUserSubissionsScreenState
    extends State<ContestUserSubissionsScreen>
    with AutomaticKeepAliveClientMixin<ContestUserSubissionsScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Text(
          "${widget.userID}'s Submissions",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const Divider(

        ),
        Expanded(
          child: FutureBuilder<List<Submission>?>(
            future: ApiServices().getUserContestSubmissions(
                widget.contestStandings.result!.contest!.id!, widget.userID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return ContestSubmissionsListWidget(
                  snapshot.data!,
                  scrollController: widget.scrollController,
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Center(child: CircularProgressIndicator()),
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

class ContestSubmissionsListWidget extends StatelessWidget {
  final List<Submission> submissionsList;
  late final ScrollController? scrollController;

  ContestSubmissionsListWidget(
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
