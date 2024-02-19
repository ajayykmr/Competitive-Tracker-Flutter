import 'package:flutter/material.dart';

import 'ui/base_scaffold.dart';
import 'utils/colors.dart';

extension CapitalizedExtension on String {
  String capitalizeFirstLetter() {
    if (this.length == 0) {
      return "";
    }
    return this.substring(0, 1).toUpperCase() + this.substring(1).toLowerCase();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Competitive Tracker',
      theme: ThemeData(
        primaryColor: AppColor.primary,
        // colorSchemeSeed: AppColor.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
        useMaterial3: true,
      ),
      home: const BaseScaffold(),
      // home: Scaffold(appBar: MyAppBar(), body: Test()),
    );
  }
}
