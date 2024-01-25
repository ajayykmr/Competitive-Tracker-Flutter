import 'package:competitive_tracker/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget{
  final List<Widget>? actions;
  const MyAppBar({this.actions, super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Competitive Tracker"),
      backgroundColor: AppColor.primary,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColor.primary,
      ),
      actions: widget.actions,
    );
  }
}
