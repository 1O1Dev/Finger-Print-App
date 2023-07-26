import 'dart:io';
import 'package:fingerprint_app/configs/config.dart';
import 'package:fingerprint_app/pages/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: FingerPrint()));
}

class FingerPrint extends StatelessWidget {
  const FingerPrint({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      // This work only android
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: whiteColor,
        ),
      );
    }
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: appName,
      theme: AppTheme.lightTheme,
      home: const AppPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
