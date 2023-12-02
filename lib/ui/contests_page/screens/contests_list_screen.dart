import 'package:competitive_tracker/api/services.dart';
import 'package:competitive_tracker/models/return_objects/contest.dart';
import 'package:competitive_tracker/utils/colors.dart';
import 'package:competitive_tracker/utils/utils.dart';
import 'package:flutter/material.dart';

class ContestsListScreen extends StatelessWidget {
  const ContestsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

        Expanded(
          child: FutureBuilder<List<Contest>?>(
            future: ApiServices().getContestsList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                return ContestListWidget(snapshot.data!);
              } else if (snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text("Failed"),);
              }
            },
          ),
        )
      ],
    );
  }
}

class ContestListWidget extends StatelessWidget {
  final List<Contest> contestList;
  const ContestListWidget(this.contestList, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contestList.length,
      itemBuilder: (context, index) {
        return Card(
          color: AppColor.secondary,
          child: ListTile(
            title: Text(
              contestList[index].name.toString(),
            ),
            trailing: Text(
              Utils.getDateTimeFromEpochSeconds(contestList[index].startTimeSeconds!).toString()
            ),
          ),
        );
      },
    );
  }
}

