import 'package:competitive_tracker/api/services.dart';
import 'package:competitive_tracker/main.dart';
import 'package:flutter/material.dart';

import '../../../models/return_objects/user.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<User>?>(
      future: ApiServices().getUsers([Constants.userID]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          return home(snapshot.data![0]);
        } else {
          return const Center(child: Text("Please  Try Again"));
        }
      },
    );
  }

  Widget home(User user) => ListView(
        padding: const EdgeInsets.only(
          top: 12,
          left: 4,
          right: 4,
        ),
        children: [
          //Image
          Center(
            child: CircleAvatar(
              radius: 75,
              backgroundImage: NetworkImage(user.avatar!),
            ),
          ),

          //UserName
          Text(
            "${user.firstName.toString().capitalizeFirstLetter()} ${user.lastName.toString().capitalizeFirstLetter()}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),

          //Card
          Card(
            elevation: 0,
            color: AppColor.secondary,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.handle.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppColor.pupil,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Max\nRating",
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: AppColor.greyText,
                        ),
                      ),
                      const SizedBox(
                        width: 36,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.maxRating.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColor.specialist,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.maxRank!,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColor.specialist,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Current\nRating",
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: AppColor.greyText,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.rating.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColor.pupil,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.rank!,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColor.pupil,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 500,
            color: AppColor.secondary,
          ),
        ],
      );
}
