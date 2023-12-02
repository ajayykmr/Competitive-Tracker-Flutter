import 'package:competitive_tracker/ui/app_bar.dart';
import 'package:competitive_tracker/ui/contests_page/screens/contests_list_screen.dart';
import 'package:competitive_tracker/ui/drawer.dart';
import 'package:flutter/material.dart';

class ContestsPageScaffold extends StatelessWidget {
  const ContestsPageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(2),
      body: ContestsListScreen(),
    );
  }
}
