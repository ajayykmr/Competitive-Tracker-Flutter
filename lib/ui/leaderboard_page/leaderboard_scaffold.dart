import 'package:competitive_tracker/ui/app_bar.dart';
import 'package:competitive_tracker/ui/drawer.dart';
import 'package:competitive_tracker/ui/leaderboard_page/screens/leaderboard_screen.dart';
import 'package:flutter/material.dart';

class LeaderBoardPageScaffold extends StatefulWidget {
  const LeaderBoardPageScaffold({super.key});

  @override
  State<LeaderBoardPageScaffold> createState() => _LeaderBoardPageScaffoldState();
}

class _LeaderBoardPageScaffoldState extends State<LeaderBoardPageScaffold> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: MyDrawer(1),
      appBar: MyAppBar(),
      body: LeaderBoardScreen(),
    );
  }
}

