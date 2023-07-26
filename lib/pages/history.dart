import 'package:fingerprint_app/providers/provider.dart';
import 'package:fingerprint_app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../configs/app_config.dart';
import '../models/model.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  StateHistoryPage createState() => StateHistoryPage();
}

class StateHistoryPage extends ConsumerState {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    final userPro = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 20,
            icon: const CircleAvatar(
              backgroundColor: appColor,
              child: Icon(
                Icons.search,
                color: whiteColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          const Duration(seconds: 3),
          () => ref.refresh(userProvider),
        ),
        child: userPro.map(
          data: (data) {
            users = data.value;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                    vertical: defaultPadding / 2,
                  ),
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor.shade100),
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(backgroundColor: appColor),
                          const SizedBox(width: defaultPadding),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    user.username,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: defaultPadding / 2),
                                  Icon(
                                    Icons.verified,
                                    color: user.isAuthenticated
                                        ? blueColor
                                        : redColor,
                                    size: 18,
                                  ),
                                ],
                              ),
                              Text(
                                user.username,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: greyColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total scan:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${user.authRecords.length}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: user.authRecords.length,
                        itemBuilder: (context, index) {
                          final record = user.authRecords[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding / 2,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: greyColor.shade100,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.fingerprint,
                                  size: 25,
                                  color: blueColor,
                                ),
                                const SizedBox(width: defaultPadding / 2),
                                Text(formatDateTime(record)),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          error: (error) => const Center(
            child: Text("Error getting users"),
          ),
          loading: (loading) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
