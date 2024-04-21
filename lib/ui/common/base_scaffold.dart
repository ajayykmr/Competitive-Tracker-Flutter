import 'package:cflytics/ui/common/app_bar.dart';
import 'package:cflytics/ui/contests_page/screens/contests_list_screen.dart';
import 'package:cflytics/ui/home_page/home_page_tab_bar.dart';
import 'package:cflytics/ui/leaderboard_page/screens/leaderboard_screen.dart';
import 'package:cflytics/ui/settings_page/screens/settings_screen.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:cflytics/utils/constants.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({super.key});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  static int _index = 0;
  static const List<Widget> _body = [
    // HomePageTabBar(),
    HomePageTabBar(),
    LeaderBoardScreen(),
    ContestsListScreen(),
    SettingsScreen(),
  ];

  static const List<int> _lengths = [4, 0, 0, 0];

  void _selectIndex(int index) {
    if (_index == index) {
      return;
    }
    setState(() {
      _index = index;
    });
  }

  static List<IconData> homePageTabIcons = [
    Icons.home,
    Icons.people_rounded,
    Icons.bar_chart_rounded,
    Icons.menu_book_rounded
  ];

  static List<Tab> homePageTabs = List.generate(homePageTabIcons.length,
      (index) => Tab(icon: Icon(homePageTabIcons[index])));

  static List<List<Tab>> tabs = [homePageTabs, [], [], []];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _lengths[_index],
      child: Scaffold(
        appBar: const MyAppBar(),
        body: _body[_index],
        bottomNavigationBar: buildBottomNavigationBar(),
        drawer: buildDrawer(context),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Drawer(
      backgroundColor: AppColor.scaffoldBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: AppColor.primary,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).viewPadding.top,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Constants.drawerLogo,
                        height: 75,
                        width: 75,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CFlytics",
                              style: textStyle.titleLarge,
                            ),
                            Text(
                              "by Ajay",
                              style: textStyle.bodySmall
                                  ?.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ListTile(
            leading: const Icon(
              size: 32,
              Icons.home_rounded,
            ),
            selected: _index == 0,
            onTap: () {
              _selectIndex(0);
              Navigator.of(context).pop();
            },
            title: Text("Home", style: textStyle.bodyMedium,),
          ),

          ListTile(
            leading: const Icon(
              size: 32,
              Icons.leaderboard_rounded,
              // size: 24,
            ),
            selected: _index == 1,
            onTap: () {
              Navigator.of(context).pop();
              _selectIndex(1);
            },
            title: Text("LeaderBoard", style: textStyle.bodyMedium,),
          ),
          ListTile(
            leading: const Icon(
              size: 32,
              Icons.list_rounded,
              // size: 24,
            ),
            title: Text("Contests", style: textStyle.bodyMedium,),
            selected: _index == 2,
            onTap: () {
              // _selectDestination(2);
              Navigator.of(context).pop();
              _selectIndex(2);
            },
          ),
          ListTile(
            leading: const Icon(
              size: 32,
              Icons.settings_rounded,
              // size: 24,
            ),
            title: Text("Settings", style: textStyle.bodyMedium,),
            selected: _index == 3,
            onTap: () {
              Navigator.of(context).pop();
              _selectIndex(3);
            },
          ),
        ],
      ),
    );
  }

  Material? buildBottomNavigationBar() {
    return _lengths[_index] == 0
        ? null
        : Material(
            color: AppColor.primary,
            child: TabBar(
              // automaticIndicatorColorAdjustment: true,

              tabs: tabs[_index],

              labelColor: AppColor.primaryTextColor,
              unselectedLabelColor: AppColor.secondary,
              indicatorColor: AppColor.primaryTextColor,

              // labelColor: AppColor.secondary,
              // unselectedLabelColor: AppColor.primaryTextColor,
              // indicatorColor: AppColor.secondary,

              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: const EdgeInsets.all(5.0),
              indicatorWeight: 4,
              dividerColor: AppColor.primary,
            ),
          );
  }
}
