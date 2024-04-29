import 'package:cflytics/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final String? title;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  const MyAppBar({this.actions, super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title ?? "CFlytics",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w400),
          )),
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColor.primary,
        statusBarColor: AppColor.primary,
        // systemNavigationBarDividerColor: AppColor.primary,
      ),
      actions: actions,
    );
  }


}
