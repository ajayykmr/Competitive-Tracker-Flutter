import 'package:cflytics/models/return_objects/rating_changes.dart';
import 'package:cflytics/providers/api_provider.dart';
import 'package:cflytics/ui/contest_details/contest_details_scaffold.dart';
import 'package:cflytics/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/colors.dart';

class RatingHistoryScreen extends ConsumerWidget {
  final String handle;

  const RatingHistoryScreen(this.handle, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final userRatingHistory = ref.watch(GetUserRatingHistoryProvider(handle));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Rating Changes",
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge,
        ),
        userRatingHistory.when(
          data: (ratingChangeList) {
            if (ratingChangeList == null) {
              return const Center(
                child: Text("NULL values received"),
              );
            }
            return Expanded(
              child:
                  RatingChangesListWidget(ratingChangeList.reversed.toList()),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (error, stack) {
            return const Center(
              child: Text("Error in retrieving data"),
            );
          },
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
        final ratingChange = ratingChangeList[index];
        return RatingChangeCard(
            ratingChange: ratingChange,
            position: ratingChangeList.length - index);
      },
    );
  }
}

class RatingChangeCard extends StatelessWidget {
  final RatingChanges ratingChange;
  final int position;

  const RatingChangeCard(
      {super.key, required this.ratingChange, required this.position});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContestDetailsScaffold(
              ratingChange.contestId!,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border(
            left: BorderSide(
              width: 10.0,
              color: (ratingChange.newRating! - ratingChange.oldRating! >= 0)
                  ? AppColor.green
                  : AppColor.red,
            ),
            right: BorderSide(
              width: 1.0,
              color: (ratingChange.newRating! - ratingChange.oldRating! >= 0)
                  ? AppColor.green
                  : AppColor.red,
            ),
            top: BorderSide(
              width: 1.0,
              color: (ratingChange.newRating! - ratingChange.oldRating! >= 0)
                  ? AppColor.green
                  : AppColor.red,
            ),
            bottom: BorderSide(
              width: 1.0,
              color: (ratingChange.newRating! - ratingChange.oldRating! >= 0)
                  ? AppColor.green
                  : AppColor.red,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 8.0),
                    decoration: const BoxDecoration(
                        // border: Border(
                        //   right: BorderSide(width: 1.0, color: AppColor.secondaryTextColor),
                        // ),
                        ),
                    child: Text(
                      position.toString(),
                      style: textTheme.bodySmall,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ratingChange.contestName!,
                            style: textTheme.bodySmall,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: "Rank: ",
                                    style: textTheme.labelSmall),
                                TextSpan(
                                  text: ratingChange.rank!.toString(),
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            maxLines: 1,
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: "Date: ",
                                    style: textTheme.labelSmall),
                                TextSpan(
                                  text: Utils.getDateStringFromEpochSeconds(
                                      ratingChange.ratingUpdateTimeSeconds!),
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ratingChange.newRating!.toString(),
                        style: textTheme.titleMedium?.copyWith(
                          color: Utils.ratingColor(ratingChange.newRating!),
                        ),
                      ),
                      Text(
                        Utils.ratingDelta(
                            ratingChange.newRating!, ratingChange.oldRating!),
                        style: textTheme.titleSmall?.copyWith(
                          color: (ratingChange.newRating! -
                                      ratingChange.oldRating! >=
                                  0)
                              ? AppColor.plus
                              : AppColor.minus,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_right_rounded, color: AppColor.primaryTextColor,)
                ],

              ),
            )
          ],
        ),
      ),
    );
  }
}
