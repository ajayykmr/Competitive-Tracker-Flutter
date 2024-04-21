import 'package:cflytics/main.dart';
import 'package:cflytics/providers/api_provider.dart';
import 'package:cflytics/ui/home_page/line_chart.dart';
import 'package:cflytics/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/return_objects/user.dart';
import '../../../utils/colors.dart';

class HomeScreen extends ConsumerWidget {
  final String handle;

  const HomeScreen(this.handle, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(GetSingleUserProvider(handle));

    return user.when(
      data: (data) {
        if (data == null) {
          return const Center(child: Text("NULL value received"));
        }
        return UserDetails(user: data);
      },
      error: (error, stackTrace) {
        return const Center(child: Text("Network Call Failed"));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class UserDetails extends ConsumerWidget {
  final User user;
  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratingChanges = ref.watch(GetUserRatingHistoryProvider(user.handle!));
    final textStyle = Theme.of(context).textTheme;
    return ListView(
      children: [
        TopContainer(
            imagePath: user.titlePhoto!,
            name:
                "${user.firstName!.capitalizeFirstLetter()} ${user.lastName!.capitalizeFirstLetter()}"),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                TextSpan(
                  children: [
                    TextSpan(
                        text: "Institution: ", style: textStyle.labelMedium),
                    TextSpan(
                        text: user.organization!, style: textStyle.titleMedium)
                  ],
                ),
              ),
              Text.rich(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Location: ",
                      style: textStyle.labelMedium,
                    ),
                    TextSpan(
                        text: "${user.city!}, ${user.country!}",
                        style: textStyle.titleMedium)
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          margin:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.handle!,
                  style: textStyle.titleLarge?.copyWith(
                    color: Utils.ratingColor(user.rating!),
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Max\nRating",
                      style: textStyle.labelSmall?.copyWith(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(width: 36),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.maxRating!.toString(),
                          style: textStyle.titleMedium?.copyWith(
                            color: Utils.ratingColor(user.maxRating!),
                          ),
                        ),
                        Text(
                          user.maxRank.toString().capitalizeFirstLetter(),
                          style: textStyle.titleMedium?.copyWith(
                            color: Utils.ratingColor(user.maxRating!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Current\nRating",
                      style: textStyle.labelSmall?.copyWith(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.rating!.toString(),
                          style: textStyle.titleMedium?.copyWith(
                            color: Utils.ratingColor(user.rating!),
                          ),
                        ),
                        Text(
                          user.rank.toString().capitalizeFirstLetter(),
                          style: textStyle.titleMedium?.copyWith(
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                TextSpan(
                  children: [
                    TextSpan(text: "Friends: ", style: textStyle.labelMedium),
                    TextSpan(
                        text: user.friendOfCount!.toString(),
                        style: textStyle.titleMedium)
                  ],
                ),
              ),
              Text.rich(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Member Since: ",
                      style: textStyle.labelMedium,
                    ),
                    TextSpan(
                        text: Utils.getDateStringFromEpochSeconds(
                            user.registrationTimeSeconds!),
                        style: textStyle.titleMedium)
                  ],
                ),
              ),
              Text.rich(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Contribution: ",
                      style: textStyle.labelMedium,
                    ),
                    TextSpan(
                        text: user.contribution!.toString(),
                        style: textStyle.titleMedium)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 500,
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Center(
              child: ratingChanges.when(
                data: (data) {
                  if (data == null) {
                    return const Center(
                        child: Text("data==null in Rating History"));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 32, right: 16, left: 4, bottom: 16),
                    child: RatingLineChart(ratingChanges: data),
                  );
                },
                error: (error, stackTrace) {
                  return const Center(child: Text("Error in retrieving Rating History"));
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TopContainer extends StatelessWidget {
  final String imagePath;
  final String name;

  const TopContainer({super.key, required this.imagePath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: 300,
            color: AppColor.primary,
          ),
        ),
        Column(
          children: [
            CircularStrokeProfilePhoto(imagePath: imagePath),
            Text(name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400)),
          ],
        ),
      ],
    );
  }
}

class CircularStrokeProfilePhoto extends StatelessWidget {
  final String imagePath;

  const CircularStrokeProfilePhoto({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.secondary,
        border: Border.all(
          color: AppColor.scaffoldBackground,
          width: 16,
        ),
      ),
      child: CircleAvatar(
        radius: 100,
        backgroundImage: NetworkImage(imagePath),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 100);
    path.lineTo(size.width, 70);
    path.lineTo(size.width, 0);
    // path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
