import 'package:cflytics/api/services.dart';
import 'package:cflytics/main.dart';
import 'package:cflytics/models/return_objects/rating_changes.dart';
import 'package:cflytics/ui/home_page/line_chart.dart';
import 'package:flutter/material.dart';
import '../../../models/return_objects/user.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

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
          return userDetails(snapshot.data![0]);
        } else {
          return const Center(child: Text("Please  Try Again"));
        }
      },
    );
  }
}
Widget userDetails(User user) => ListView(
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
        backgroundImage: NetworkImage(user.titlePhoto!),
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
                      style: TextStyle(
                        fontSize: 14,
                        color: Utils.ratingColor(user.maxRating!),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.maxRank!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        color: Utils.ratingColor(user.maxRating!),
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
                      style: TextStyle(
                        fontSize: 14,
                        color: Utils.ratingColor(user.rating!),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.rank!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        color: Utils.ratingColor(user.rating!),
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

    Card(
      color: AppColor.secondary,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 20),
        child: SizedBox(
          height: 500,
          // color: AppColor.greyText,
          child: FutureBuilder<List<RatingChanges>?>(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return RatingLineChart(ratingChanges: snapshot.data!);
              } else {
                const Text("Please Try Again");
              }

              return const Text("PLease Try Again");
            },
            future: ApiServices().getUserRatingHistory(user.handle!),
          ),
        ),
      ),
    ),
  ],
);

