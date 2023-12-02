import 'package:competitive_tracker/ui/app_bar.dart';
import 'package:competitive_tracker/ui/drawer.dart';
import 'package:competitive_tracker/ui/settings_page/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class SettingsPageScaffold extends StatelessWidget {
  const SettingsPageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(3),
      body: SettingsScreen(),
    );
  }
}
