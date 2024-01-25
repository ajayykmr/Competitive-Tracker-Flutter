import 'package:competitive_tracker/api/services.dart';
import 'package:competitive_tracker/models/contest_standings.dart';
import 'package:competitive_tracker/ui/app_bar.dart';
import 'package:competitive_tracker/ui/contest_details/screens/contest_problems_screen.dart';
import 'package:competitive_tracker/ui/contest_details/screens/contest_standings_friends_screen.dart';
import 'package:competitive_tracker/ui/contest_details/screens/contest_standings_screen.dart';
import 'package:competitive_tracker/ui/contest_details/screens/contest_user_submissions.dart';
import 'package:competitive_tracker/utils/colors.dart';
import 'package:flutter/material.dart';

class ContestDetailsScaffold extends StatefulWidget {
  final int contestId;

  const ContestDetailsScaffold(this.contestId, {super.key});

  @override
  State<ContestDetailsScaffold> createState() => _ContestDetailsScaffoldState();
}

class _ContestDetailsScaffoldState extends State<ContestDetailsScaffold> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // backgroundColor: AppColor.secondary,
        appBar: MyAppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh_rounded))
          ],
        ),
        body: FutureBuilder<ContestStandings?>(
          future: ApiServices().getContestStandings(widget.contestId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return ContestDetailsTabBarViewWidget(snapshot.data!);
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

        bottomNavigationBar: const Material(
          color: AppColor.primary,
          child: TabBar(
            isScrollable: true,
            // automaticIndicatorColorAdjustment: true,
            tabs: [
              Tab(
                // icon: Icon(Icons.list_alt_rounded),
                text: "Problems",
              ),
              Tab(
                // icon: Icon(Icons.table_rows_rounded),
                text: "Common\nStandings",
              ),
              Tab(
                // icon: Icon(Icons.table_rows_rounded),
                text: "Friends\nStandings",
              ),
              Tab(
                text: "My\nSubmissions",
              ),
            ],

            labelColor: AppColor.secondary,
            unselectedLabelColor: Colors.black,
            indicatorColor: AppColor.secondary,

            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorWeight: 4,
            dividerColor: AppColor.primary,
          ),
        ),
      ),
    );
  }
}

class ContestDetailsTabBarViewWidget extends StatelessWidget {
  final ContestStandings contestStandings;

  const ContestDetailsTabBarViewWidget(
    this.contestStandings, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        ContestProblemsScreen(contestStandings),
        ContestStandingsScreen(contestStandings),
        ContestStandingsFriendsScreen(contestStandings),
        ContestUserSubissionsScreen(contestStandings),
      ],
    );
  }
}
