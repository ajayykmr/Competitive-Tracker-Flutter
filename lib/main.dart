import 'package:cflytics/utils/theme_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/common/base_scaffold.dart';

extension CapitalizedExtension on String {

  String capitalizeFirstLetter() {
    if (length == 0) {
      return "";
    } else {
      return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
    }
  }
}


void main() {

  final runnableApp = _buildRunnableApp(
    isWeb: kIsWeb,
    webAppWidth: 425.0,
    app: MyApp(),
  );
  runApp(ProviderScope(child: runnableApp));

  // runApp(
  //   const ProviderScope(
  //     child: MyApp(),
  //   ),
  // );
}

Widget _buildRunnableApp({
  required bool isWeb,
  required double webAppWidth,
  required Widget app,
}) {
  if (!isWeb) {
    return app;
  }

  return Center(
    child: ClipRect(
      child: SizedBox(
        width: webAppWidth,
        child: app,
      ),
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

