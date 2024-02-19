import 'package:cflytics/api/services.dart';
import 'package:cflytics/models/return_objects/rating_changes.dart';
import 'package:cflytics/ui/contest_details/contest_details_scaffold.dart';
import 'package:cflytics/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class RatingHistoryScreen extends StatefulWidget {
  const RatingHistoryScreen({super.key});

  @override
  State<RatingHistoryScreen> createState() => _RatingHistoryScreenState();
}

class _RatingHistoryScreenState extends State<RatingHistoryScreen>
    with AutomaticKeepAliveClientMixin<RatingHistoryScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Rating Changes",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Constants.pageTitleSize,
          ),
        ),
        Expanded(
          child: FutureBuilder<List<RatingChanges>?>(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return RatingChangesListWidget(snapshot.data!.reversed.toList());
              } else {
                const Text("Please Try Again");
              }

              return const Text("PLease Try Again");
            },
            future: ApiServices().getUserRatingHistory(Constants.userID),
          ),
        ),
      ],
    );
  }
}

class RatingChangesListWidget extends StatelessWidget {
  final List<RatingChanges> ratingChangeList;

  const RatingChangesListWidget(this.ratingChangeList, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ratingChangeList.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: ((ratingChangeList[index].newRating! -
                          ratingChangeList[index].oldRating! >=
                      0)
                  ? AppColor.plus
                  : AppColor.minus)
              .withOpacity(0.3),
          child: ListTile(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContestDetailsScaffold(
                        ratingChangeList[index].contestId!),
                  ));
            },
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            leading: Container(
              padding: const EdgeInsets.only(right: 8.0),
              decoration: const BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1.0, color: Colors.black26))),
              child: Text(
                (ratingChangeList.length - index).toString(),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            title: Text(
              ratingChangeList[index].contestName.toString(),
              style: const TextStyle(
                color: AppColor.blackText,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Rank: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.blackText,
                      ),
                    ),
                    Text(
                      ratingChangeList[index].rank.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.blackText,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Date: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.blackText,
                      ),
                    ),
                    Text(
                      "${Utils.getDateStringFromEpochSeconds(ratingChangeList[index]
                          .ratingUpdateTimeSeconds!)} | ${Utils.getTimeStringFromEpochSeconds(ratingChangeList[index]
                          .ratingUpdateTimeSeconds!)}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.blackText,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ratingChangeList[index].newRating.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        Utils.ratingColor(ratingChangeList[index].newRating!),
                  ),
                ),
                Text(
                  Utils.ratingDelta(ratingChangeList[index].newRating!,
                      ratingChangeList[index].oldRating!),
                  style: TextStyle(
                    fontSize: 14,
                    color: (ratingChangeList[index].newRating! -
                                ratingChangeList[index].oldRating! >=
                            0)
                        ? AppColor.plus
                        : AppColor.minus,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
