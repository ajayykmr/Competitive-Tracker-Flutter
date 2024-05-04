import 'package:cflytics/providers/api_provider.dart';
import 'package:cflytics/ui/home_page/screens/friends_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderBoardScreen extends ConsumerWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final leaderBoard = ref.watch(getLeaderBoardProvider);
    return leaderBoard.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Failed"),),
      data: (data) {
        if (data==null) {
          return const Center(child: Text("No Data Received"),);
        } else {
          return Column(
            children: [
              Text("Leaderboard", style: Theme.of(context).textTheme.bodyLarge),
              Expanded(child: UsersListWidget(data)),
            ],
          );
        }
      },
    );

  }
}