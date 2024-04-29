import 'package:cflytics/models/contest_standings.dart';
import 'package:cflytics/providers/api_provider.dart';
import 'package:cflytics/ui/common/app_bar.dart';
import 'package:cflytics/ui/contest_details/screens/contest_problems_screen.dart';
import 'package:cflytics/ui/contest_details/screens/contest_standings_friends_screen.dart';
import 'package:cflytics/ui/contest_details/screens/contest_standings_screen.dart';
import 'package:cflytics/ui/contest_details/screens/contest_user_submissions.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContestDetailsScaffold extends ConsumerStatefulWidget {
  final int contestId;

  const ContestDetailsScaffold(this.contestId, {super.key});

  @override
  ConsumerState<ContestDetailsScaffold> createState() =>
      _ContestDetailsScaffoldState();
}

class _ContestDetailsScaffoldState
    extends ConsumerState<ContestDetailsScaffold> {
  String? appBarTitle;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    appBarTitle = widget.contestId.toString();
  }

  @override
  Widget build(BuildContext context) {
    final contestStandings =
        ref.watch(getContestStandingsProvider(widget.contestId));

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // backgroundColor: AppColor.secondary,
        appBar: MyAppBar(
          key: ValueKey(appBarTitle),
          title: appBarTitle,
          // actions: const [
          // IconButton(
          //     onPressed: () {
          //       // ref.invalidate(getContestStandingsProvider(contestId));
          //     },
          //     icon: const Icon(Icons.refresh_rounded))
          // ],
        ),
        body: contestStandings.when(
          data: (data) {
            if (data == null) {
              return const Text("NULL value received");
            }

            Future.delayed(const Duration(milliseconds: 0), () {
              setState(() {
                isLoaded = true;
                appBarTitle = data.result?.contest?.name;
              });
            });

            return ContestDetailsTabBarViewWidget(data);
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

        bottomNavigationBar: !isLoaded ? null : Material(
          color: AppColor.primary,
          child: TabBar(
            isScrollable: true,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
            // automaticIndicatorColorAdjustment: true,
            tabs: const [
              Tab(
                icon: Icon(Icons.list_alt_rounded),
                text: "Problems",
              ),
              Tab(
                icon: Icon(Icons.table_rows_outlined),
                text: "Common Standings",
              ),
              Tab(
                icon: Icon(Icons.table_rows_rounded),
                text: "Friends Standings",
              ),
              Tab(
                icon: Icon(Icons.menu_book_rounded),
                text: "My Submissions",
              ),
            ],

            labelColor: AppColor.primaryTextColor,
            unselectedLabelColor: AppColor.secondary,
            indicatorColor: AppColor.primaryTextColor,

            // labelColor: AppColor.secondary,
            // unselectedLabelColor: AppColor.primaryTextColor,
            // indicatorColor: AppColor.secondary,

            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: const EdgeInsets.all(5.0),
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
        ContestUserSubmissionsScreen(contestStandings),
      ],
    );
  }
}
