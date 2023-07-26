import 'package:fingerprint_app/providers/provider.dart';
import 'package:fingerprint_app/services/finger_print_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../configs/config.dart';
import '../models/model.dart';

class ScanPage extends ConsumerStatefulWidget {
  const ScanPage({super.key});

  @override
  StateScanPage createState() => StateScanPage();
}

class StateScanPage extends ConsumerState {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    final userPro = ref.watch(userProvider);
    return Scaffold(
      body: userPro.map(
        data: (data) {
          users = data.value;
          return Container(
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Scan Here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  "Scan to unlock the door and recorded your enter and exit time when you enter to the office",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: greyColor,
                  ),
                ),
                const SizedBox(height: 80),
                InkWell(
                  onTap: () => FingerPrintService().authenticateAllUsers(users),
                  borderRadius: BorderRadius.circular(70),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      gradient: LinearGradient(
                        colors: [
                          appColor.shade100,
                          appColor.shade200,
                          appColor.shade300,
                          appColor.shade400,
                          appColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: appColor.withOpacity(0.1),
                          spreadRadius: 10,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.fingerprint,
                      size: 100,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
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
