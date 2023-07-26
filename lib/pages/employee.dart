import 'package:fingerprint_app/providers/provider.dart';
import 'package:fingerprint_app/services/finger_print_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../configs/app_config.dart';
import '../models/model.dart';

class EmployeePage extends ConsumerStatefulWidget {
  const EmployeePage({super.key});

  @override
  StateEmployeePage createState() => StateEmployeePage();
}

class StateEmployeePage extends ConsumerState {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    final userPro = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee"),
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
          IconButton(
            onPressed: () => FingerPrintService().addNewUser(),
            splashRadius: 20,
            icon: const CircleAvatar(
              backgroundColor: appColor,
              child: Icon(
                Icons.person_add_alt_1_rounded,
                color: whiteColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: userPro.map(
        data: (data) {
          users = data.value;
          return RefreshIndicator(
            onRefresh: () => Future.delayed(
              const Duration(seconds: 3),
              () => ref.refresh(userProvider),
            ),
            child: ListView.builder(
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
                    ],
                  ),
                );
              },
            ),
          );
        },
        error: (error) => const Center(
          child: Text("Error getting users"),
        ),
        loading: (loading) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
