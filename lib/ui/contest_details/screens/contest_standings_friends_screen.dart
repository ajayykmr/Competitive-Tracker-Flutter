import 'package:cflytics/api/services.dart';
import 'package:cflytics/models/contest_standings.dart';
import 'package:cflytics/ui/contest_details/screens/contest_standings_screen.dart';
import 'package:cflytics/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class ContestStandingsFriendsScreen extends StatefulWidget {
  final ContestStandings contestStandings;

  const ContestStandingsFriendsScreen(this.contestStandings, {super.key});

  @override
  State<ContestStandingsFriendsScreen> createState() =>
      _ContestStandingsFriendsScreenState();
}

class _ContestStandingsFriendsScreenState
    extends State<ContestStandingsFriendsScreen>
    with AutomaticKeepAliveClientMixin<ContestStandingsFriendsScreen> {
  @override
  bool get wantKeepAlive => true;

  late final Map<String, String> _values;

  String? myHandle;
  late final String? apiKey;
  late final String? apiSecret;
  @override
  void initState() {
    super.initState();
    _fetchValues();
  }

  Future<void> _fetchValues() async {
    _values = await storage.readAll();
    myHandle = _values[Constants.handleKey];
    apiKey = _values[Constants.apiKeyKey];
    apiSecret = _values[Constants.apiSecretKey];

    if (context.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (myHandle == null || myHandle!.isEmpty) {
      return const Center(child: Text("Please enter your handle name to display friends ranking"));
    } else if (apiSecret==null || apiKey==null || apiSecret!.isEmpty || apiKey!.isEmpty){
      return const Center(child: Text("Please enter API Key and API Secret to access friends data"));
    }
    return Column(
      children: [
        const Text(
          "Friends Standings",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        FutureBuilder(
          future: ApiServices().getContestStandingsFriends(
              myHandle!, apiKey!, apiSecret!,widget.contestStandings.result!.contest!.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              return Flexible(
                  child: StandingsTable(
                snapshot.data!,
                myHandle: myHandle,
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return const Expanded(
                child: Center(
                  child: Text("Please try again.\n Also, ensure that you have entered API keys"),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
