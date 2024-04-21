import 'package:cflytics/providers/secure_storage_provider.dart';
import 'package:cflytics/ui/home_page/screens/friends_list_screen.dart';
import 'package:cflytics/ui/home_page/screens/home_screen.dart';
import 'package:cflytics/ui/home_page/screens/rating_history_screen.dart';
import 'package:cflytics/ui/home_page/screens/submissions_screen.dart';
import 'package:cflytics/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageTabBar extends ConsumerWidget {
  const HomePageTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final storage = ref.watch(secureStorageReadProvider);

    return storage.when(
      data: (data) {
        final handle = data[Constants.handleKey];
        final apiKey = data[Constants.apiKeyKey];
        final apiSecret = data[Constants.apiSecretKey];

        if (handle == null || handle.isEmpty) {
          return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Please Enter handle name in settings", style: textStyle.bodyMedium),
              ));
        } else if (apiKey == null ||
            apiSecret == null ||
            apiKey.isEmpty ||
            apiSecret.isEmpty) {
          return TabBarView(children: [
            HomeScreen(handle),
            Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      "Please enter both API Key and API Secret to view friends list", style: textStyle.bodyMedium,),
                ),),
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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Text(
            "An error occurred while retrieving handle name from local storage: ${err.toString()}", style: textStyle.bodyMedium),
      ),
    );
  }
}
