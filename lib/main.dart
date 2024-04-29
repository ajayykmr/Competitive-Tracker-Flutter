import 'package:cflytics/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/common/base_scaffold.dart';

extension CapitalizedExtension on String {
  String capitalizeFirstLetter() {
    if (this.length == 0) {
      return "";
    }
    return this.substring(0, 1).toUpperCase() + this.substring(1).toLowerCase();
  }
}

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Competitive Tracker',
      theme: lightTheme,
      home: const BaseScaffold(),
    );
  }
}

