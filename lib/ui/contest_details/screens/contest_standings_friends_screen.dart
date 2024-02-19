import 'package:cflytics/api/services.dart';
import 'package:cflytics/models/contest_standings.dart';
import 'package:cflytics/ui/contest_details/screens/contest_standings_screen.dart';
import 'package:flutter/material.dart';

class ContestStandingsFriendsScreen extends StatefulWidget {
  final ContestStandings contestStandings;
  const ContestStandingsFriendsScreen(this.contestStandings, {super.key});

  @override
  State<ContestStandingsFriendsScreen> createState() => _ContestStandingsFriendsScreenState();
}

class _ContestStandingsFriendsScreenState extends State<ContestStandingsFriendsScreen> with AutomaticKeepAliveClientMixin<ContestStandingsFriendsScreen> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const Text(
          "Friends Standings",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        FutureBuilder(future: ApiServices().getContestStandingsFriends(widget.contestStandings.result!.contest!.id!), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return Flexible(child: StandingsTable(snapshot.data!));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            return const Center(child: Text("Failed"),);
          }
        },)
      ],
    );
  }
}
