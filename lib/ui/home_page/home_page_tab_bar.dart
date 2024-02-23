import 'package:cflytics/ui/home_page/screens/friends_list_screen.dart';
import 'package:cflytics/ui/home_page/screens/home_screen.dart';
import 'package:cflytics/ui/home_page/screens/rating_history_screen.dart';
import 'package:cflytics/ui/home_page/screens/submissions_screen.dart';
import 'package:cflytics/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class HomePageTabBar extends StatelessWidget {
  const HomePageTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.readAll(),
      builder: (context, snapshot) {

        if (snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        } else if (snapshot.connectionState==ConnectionState.done && snapshot.hasError){
          return Center(child: Text("An error occurred in retrieving handle name from local storage"),);
        }
        String? handle = snapshot.data?[Constants.handleKey];
        String? apiKey = snapshot.data?[Constants.apiKeyKey];
        String? apiSecret = snapshot.data?[Constants.apiSecretKey];

        if (handle==null || handle.isEmpty){
          return const Center(child: Text("Please Enter a handle name in settings"));
        } else if (apiKey==null || apiSecret==null || apiKey.isEmpty || apiSecret.isEmpty) {
          return TabBarView(children: [
            HomeScreen(handle),
            const Center(child: Text("Please enter both API Key and API Secret to view friends list")),
            RatingHistoryScreen(handle),
            SubmissionsListScreen(handle)
          ]);
        } else {
          return TabBarView(children: [
            HomeScreen(handle),
            FriendsListScreen(handle, apiKey, apiSecret),
            RatingHistoryScreen(handle),
            SubmissionsListScreen(handle)
          ]);
        }
      },
    );
  }
}
