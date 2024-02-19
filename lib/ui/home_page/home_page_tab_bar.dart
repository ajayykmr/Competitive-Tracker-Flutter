import 'package:cflytics/ui/home_page/screens/friends_list_screen.dart';
import 'package:cflytics/ui/home_page/screens/home_screen.dart';
import 'package:cflytics/ui/home_page/screens/rating_history_screen.dart';
import 'package:cflytics/ui/home_page/screens/submissions_screen.dart';
import 'package:flutter/material.dart';

class HomePageTabBar extends StatelessWidget {
  const HomePageTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        HomeScreen(),
        FriendsListScreen(),
        RatingHistoryScreen(),
        SubmissionsListScreen(),
      ],
    );
  }
}
