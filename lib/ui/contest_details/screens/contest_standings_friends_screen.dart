import 'package:cflytics/models/contest_standings.dart';
import 'package:cflytics/providers/api_provider.dart';
import 'package:cflytics/providers/secure_storage_provider.dart';
import 'package:cflytics/ui/contest_details/screens/contest_standings_screen.dart';
import 'package:cflytics/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContestStandingsFriendsScreen extends ConsumerWidget {
  final ContestStandings contestStandings;

  const ContestStandingsFriendsScreen(this.contestStandings, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.watch(secureStorageReadProvider);

    return Column(
      children: [
        Text("Friends Standings", style: Theme.of(context).textTheme.bodyLarge,),
        storage.when(data: (data) {
          final myHandle = data[Constants.handleKey];
          final apiKey = data[Constants.apiKeyKey];
          final apiSecret = data[Constants.apiSecretKey];

          if (myHandle == null || myHandle.isEmpty) {
            return const Center(
                child: Text(
                    "Please enter your handle name to display friends ranking"));
          } else if (apiSecret == null ||
              apiKey == null ||
              apiSecret.isEmpty ||
              apiKey.isEmpty) {
            return const Center(
                child: Text(
                    "Please enter API Key and API Secret to access friends data"));
          }
          final getContestStandingsFriends = ref.watch(
              GetContestStandingsFriendsProvider(myHandle, apiKey, apiSecret,
                  contestStandings.result!.contest!.id!));

          return getContestStandingsFriends.when(
            data: (data) {
              if (data == null) {
                return const Text("NULL value received");
              }
              return Flexible(
                  child: StandingsTable(
                data,
                myHandle: myHandle,
              ));
            },
            error: (error, stackTrace) {
              return const Center(
                child: Text("Error:"),
              );
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          );
        }, error: (error, stackTrace) {
          return const Text(
              "Please try again.\n Also, ensure that you have entered API keys");
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }),
      ],
    );

    return const Center(child: Text("EMPTY BODY"));
  }
}
