import 'package:competitive_tracker/ui/contests_page/contests_page_scaffold.dart';
import 'package:competitive_tracker/ui/home_page/home_page_scaffold.dart';
import 'package:competitive_tracker/ui/leaderboard_page/leaderboard_scaffold.dart';
import 'package:competitive_tracker/ui/settings_page/settings_page_scaffold.dart';
import 'package:competitive_tracker/utils/colors.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  final int _index;

  const MyDrawer(this._index, {super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // static int _selectedDestination = 0;

  // void _selectDestination(int index) {
  //   setState(() {
  //     _selectedDestination = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: MediaQuery.of(context).viewPadding.top,),
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
            selected: widget._index == 0,
            onTap: () {

              // _selectDestination(0);
              Navigator.of(context).pop();
              if (widget._index!=0) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomePageScaffold(),
              ));
              }


            },
            title: const Text("Home"),
          ),
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.leaderboard_rounded,
              // size: 24,
            ),
            selected: widget._index == 1,
            onTap: () {
              Navigator.of(context).pop();
              // _selectDestination(1);
              if (widget._index!=1) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LeaderBoardPageScaffold(),
              ));
              }

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
            selected: widget._index == 2,
            onTap: () {
              // _selectDestination(2);
              Navigator.of(context).pop();
              if (widget._index!=2) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const ContestsPageScaffold(),
              ));
              }

            },
          ),
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.settings_rounded,
              // size: 24,
            ),
            title: const Text("Settings"),
            selected: widget._index == 3,
            onTap: () {
              // _selectDestination(3);
              Navigator.of(context).pop();
              if (widget._index!=3) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const SettingsPageScaffold(),
              ));
              }

            },
          ),
        ],
      ),
    );
  }
}
