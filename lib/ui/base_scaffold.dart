import 'package:competitive_tracker/ui/app_bar.dart';
import 'package:competitive_tracker/ui/contests_page/screens/contests_list_screen.dart';
import 'package:competitive_tracker/ui/home_page/home_page_tab_bar.dart';
import 'package:competitive_tracker/ui/leaderboard_page/screens/leaderboard_screen.dart';
import 'package:competitive_tracker/ui/settings_page/screens/settings_screen.dart';
import 'package:competitive_tracker/utils/colors.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({super.key});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  static int _index = 0;
  static const List<Widget> _body = [
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

  static List<IconData> homePageTabIcons = [Icons.home, Icons.people_rounded, Icons.bar_chart_rounded, Icons.menu_book_rounded];
  static List<Tab> homePageTabs = List.generate(homePageTabIcons.length, (index) => Tab(icon: Icon(homePageTabIcons[index])));

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
    return Drawer(
      backgroundColor: AppColor.secondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: AppColor.primary,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).viewPadding.top,
                  ),
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ajay Kumar",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "qubitt",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Competitive Tracker",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    "by Ajay",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.home_rounded,
            ),
            selected: _index == 0,
            onTap: () {
              _selectIndex(0);
              Navigator.of(context).pop();
            },
            title: const Text("Home"),
          ),
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.leaderboard_rounded,
              // size: 24,
            ),
            selected: _index == 1,
            onTap: () {
              Navigator.of(context).pop();
              _selectIndex(1);
            },
            title: const Text("LeaderBoard"),
          ),
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.list_rounded,
              // size: 24,
            ),
            title: const Text("Contests"),
            selected: _index == 2,
            onTap: () {
              // _selectDestination(2);
              Navigator.of(context).pop();
              _selectIndex(2);
            },
          ),
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.settings_rounded,
              // size: 24,
            ),
            title: const Text("Settings"),
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

              // labelColor: Colors.black,
              // unselectedLabelColor: AppColor.secondary,
              // indicatorColor: Colors.black,

              labelColor: AppColor.secondary,
              unselectedLabelColor: Colors.black,
              indicatorColor: AppColor.secondary,

              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: const EdgeInsets.all(5.0),
              indicatorWeight: 4,
              dividerColor: AppColor.primary,
            ),
          );
  }
}
