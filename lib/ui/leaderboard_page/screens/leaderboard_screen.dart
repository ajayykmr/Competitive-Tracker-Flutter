import 'package:cflytics/api/services.dart';
import 'package:cflytics/models/return_objects/user.dart';
import 'package:cflytics/ui/home_page/screens/friends_list_screen.dart';
import 'package:flutter/material.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text("LeaderBoard",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),

        Expanded(
          child: FutureBuilder<List<User>?> (
            future: ApiServices().getLeaderBoard(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                return UsersListWidget(snapshot.data!);
              } else if (snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text("Failed"),);
              }
            },
          ),
        )
      ],
    );
  }
}