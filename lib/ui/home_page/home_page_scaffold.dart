import 'package:competitive_tracker/ui/app_bar.dart';
import 'package:competitive_tracker/ui/drawer.dart';
import 'package:competitive_tracker/ui/home_page/screens/friends_list_screen.dart';
import 'package:competitive_tracker/utils/colors.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/rating_history_screen.dart';
import 'screens/submissions_screen.dart';

class HomePageScaffold extends StatelessWidget {
  const HomePageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        // backgroundColor: AppColor.secondary,
        appBar: MyAppBar(),
        drawer: MyDrawer(0),
        body: TabBarView(
          children: [
            HomeScreen(),
            FriendsListScreen(),
            RatingHistoryScreen(),
            SubmissionsListScreen(),
          ],
        ),
        bottomNavigationBar: Material(
          color: AppColor.primary,
          child: TabBar(
            // automaticIndicatorColorAdjustment: true,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.people_rounded),
              ),
              Tab(
                icon: Icon(Icons.bar_chart_rounded),
              ),
              Tab(
                icon: Icon(Icons.menu_book_rounded),
              ),
            ],

            // labelColor: Colors.black,
            // unselectedLabelColor: AppColor.secondary,
            // indicatorColor: Colors.black,

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
