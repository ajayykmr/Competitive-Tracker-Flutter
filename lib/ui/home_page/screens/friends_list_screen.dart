import 'package:cflytics/main.dart';
import 'package:cflytics/models/return_objects/user.dart';
import 'package:cflytics/providers/api_provider.dart';
import 'package:cflytics/ui/home_page/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/colors.dart';
import '../../../utils/utils.dart';

class FriendsListScreen extends ConsumerWidget {
  final String handle, apiKey, apiSecret;

  const FriendsListScreen(this.handle, this.apiKey, this.apiSecret,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          "Friends",
          style: textStyle.bodyLarge,
        ),
        Expanded(
            child: Center(
          child: Text(
            "Coming Soon...",
            style: textStyle.labelLarge,
          ),
        )),
      ],
    );
    final friendsList =
        ref.watch(GetFriendsListProvider(handle, apiKey, apiSecret));
    return Column(
      children: [
        const Text(
          textAlign: TextAlign.center,
          "Friends",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        // Divider(
        //   color: AppColor.primary,
        // ),
        friendsList.when(
          data: (data) {
            if (data == null) {
              return const Text("NULL value received");
            }
            data.sort((a, b) => b.rating!.compareTo(a.rating!));
            return UsersListWidget(data);
          },
          error: (error, stackTrace) => const Center(
              child: Text(
                  "Please Try Again\nAlso, please ensure that you entered the correct API keys\n")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}

class UsersListWidget extends StatelessWidget {
  final List<User> userList;

  const UsersListWidget(
    this.userList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return UserCard(user: userList[index]);
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Color borderColor = Utils.ratingColor(user.rating!);
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: AppColor.scaffoldBackground,

          enableDrag: true,
          showDragHandle: true,
          isScrollControlled: true,
          context: context,
          useSafeArea: false,
          isDismissible: true,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),

          builder: (context) {
            return UserDetails(user: user);
          },
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
              color: borderColor,
            ),
            right: BorderSide(
              width: 1.0,
              color: borderColor,
            ),
            top: BorderSide(
              width: 1.0,
              color: borderColor,
            ),
            bottom: BorderSide(
              width: 1.0,
              color: borderColor,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar!),
                    radius: 30,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.handle!,
                            style: textTheme.titleMedium,
                          ),
                          Text(
                            "${user.firstName!.capitalizeFirstLetter()} ${user.lastName!.capitalizeFirstLetter()}",
                            style: textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            user.rating.toString(),
                            style: textTheme.titleSmall,
                          ),
                          Text(
                            user.rank!.capitalizeFirstLetter(),
                            style: textTheme.bodySmall,
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_right_rounded,
                      color: AppColor.primaryTextColor,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
