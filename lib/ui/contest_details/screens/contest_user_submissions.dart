import 'package:cflytics/api/services.dart';
import 'package:cflytics/models/contest_standings.dart';
import 'package:cflytics/models/return_objects/submission.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:cflytics/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();
class ContestUserSubmissionsScreen extends StatefulWidget {
  final ContestStandings contestStandings;
  late final ScrollController? scrollController;
  String? givenHandle;
  ContestUserSubmissionsScreen(this.contestStandings,
      {this.givenHandle, this.scrollController, super.key});

  
  @override
  State<ContestUserSubmissionsScreen> createState() =>
      _ContestUserSubmissionsScreenState();
}

class _ContestUserSubmissionsScreenState
    extends State<ContestUserSubmissionsScreen>
    with AutomaticKeepAliveClientMixin<ContestUserSubmissionsScreen> {
  @override
  bool get wantKeepAlive => true;

  late final Map<String, String> _values;
  String? handle;
  @override
  void initState() {
    super.initState();
    _fetchValues();
  }

  Future<void> _fetchValues() async {
    _values = await storage.readAll();
    handle = widget.givenHandle ?? _values['handle'];
    if (context.mounted) {setState(() {});}
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    if (handle==null || handle!.isEmpty){
      return Center(child: const Text("Please Enter a handle name"));
    }
    return Column(
      children: [
        Text(
          "${handle}'s Submissions",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const Divider(

        ),
        Expanded(
          child: FutureBuilder<List<Submission>?>(
            future: ApiServices().getUserContestSubmissions(
                widget.contestStandings.result!.contest!.id!, handle!),
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
