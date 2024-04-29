import 'package:cflytics/main.dart';
import 'package:cflytics/models/return_objects/user.dart';
import 'package:cflytics/providers/api_provider.dart';
import 'package:cflytics/ui/common/app_bar.dart';
import 'package:flutter/cupertino.dart';
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
        Text("Friends", style: textStyle.bodyLarge,),
        Expanded(child: Center(child: Text("Coming Soon...", style: textStyle.labelLarge,),)),
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
      // separatorBuilder: (context, index) {
      //   return Divider(
      //     color: Colors.black26,
      //     indent: 75,
      //     // endIndent: 10,
      //   );
      // },

      itemCount: userList.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(top: 4),
          // color: Utils.ratingColor(userList[index].rating!).withOpacity(0.05),

          child: ListTile(
            onTap: () async {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              // )
              // );
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Scaffold(
                    appBar: const MyAppBar(),
                    body: UserPopupWidget(userList[index])
                  );
                },
              ));
            },
            // contentPadding: EdgeInsets.all(10),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(userList[index].avatar!),
              radius: 25,
            ),
            title: Text(
              userList[index].handle.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Utils.ratingColor(userList[index].rating!),
              ),
            ),
            subtitle: Text(
              "${userList[index].firstName.toString().capitalizeFirstLetter()} ${userList[index].lastName.toString().capitalizeFirstLetter()}",
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userList[index].rating.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Utils.ratingColor(userList[index].rating!),
                  ),
                ),
                Text(
                  userList[index].rank.toString().capitalizeFirstLetter(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Utils.ratingColor(userList[index].rating!),
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

class UserPopupWidget extends StatelessWidget {
  final User user;

  const UserPopupWidget(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          child: Column(
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
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                ),
              ),

              //Card
              Card(
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
                          fontSize: 28,
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
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: AppColor.secondaryTextColor,
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
                                  fontSize: 16,
                                  color: AppColor.specialist,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                user.maxRank!,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: AppColor.secondaryTextColor,
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
                                  fontSize: 16,
                                  color: AppColor.pupil,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                user.rank!,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 16,
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
          ),
        );
      },
    );
  }
}
