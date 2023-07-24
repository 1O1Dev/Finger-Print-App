// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:io';

// import 'package:fingerprint_app/configs/config.dart';
// import 'package:fingerprint_app/pages/page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(const FingerPrint());
// }

// class FingerPrint extends StatelessWidget {
//   const FingerPrint({super.key});

//   @override
//   Widget build(BuildContext context) {
//     if (Platform.isAndroid) {
//       // This work only android
//       SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.dark,
//           systemNavigationBarIconBrightness: Brightness.dark,
//           systemNavigationBarColor: whiteColor,
//         ),
//       );
//     }
//     SystemChrome.setPreferredOrientations(const [
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);

//     return MaterialApp(
//       title: appName,
//       theme: AppTheme.lightTheme,
//       home: const HomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class User {
  final String id;
  final String username;
  final String passwordHash;
  bool isAuthenticated;
  int authCount;
  List<String> authRecords; // Store authentication records

  User({
    required this.id,
    required this.username,
    required this.passwordHash,
    this.isAuthenticated = false,
    this.authCount = 0,
    this.authRecords = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'passwordHash': passwordHash,
      'isAuthenticated': isAuthenticated,
      'authCount': authCount,
      'authRecords': authRecords,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      username: map['username'] as String,
      passwordHash: map['passwordHash'] as String,
      isAuthenticated: map['isAuthenticated'] as bool,
      authCount: map['authCount'] as int,
      authRecords: List<String>.from(
        (map['authRecords'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsersFromSharedPreferences();
  }

  Future<void> _loadUsersFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userStrings = prefs.getStringList('users') ?? [];
    setState(() {
      _users = userStrings.map((userString) {
        return User.fromMap(Map<String, dynamic>.from(jsonDecode(userString)));
      }).toList();
    });
  }

  Future<void> _saveUsersToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userStrings =
        _users.map((user) => jsonEncode(user.toJson())).toList();
    prefs.setStringList('users', userStrings);
  }

  Future<bool> _authenticate() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
      );
    } catch (e) {
      print('Error during biometric authentication: $e');
      return false;
    }
  }

  void _logFingerprintTransaction(User user) {
    // In a real app, you would log the fingerprint authentication transaction for the specified user.
    print('Fingerprint transaction logged for user: ${user.username}');
  }

  void _addNewUser() async {
    bool isAuthenticated = await _authenticate();
    if (isAuthenticated) {
      User newUser = User(
        id: 'user_id_${_users.length + 1}',
        username: 'NewUser${_users.length + 1}',
        passwordHash: 'hashed_password_${_users.length + 1}',
      );
      _users.add(newUser);

      // Save the updated list of users to SharedPreferences
      _saveUsersToSharedPreferences();

      // Log the fingerprint transaction for the new user
      _logFingerprintTransaction(newUser);

      // Update the UI to reflect the new user added
      setState(() {});
    }
  }

  void _authenticateAllUsers() async {
    for (User user in _users) {
      bool isAuthenticated = await _authenticate();
      if (isAuthenticated) {
        user.isAuthenticated = true;

        // Increment the authentication count and store the record
        user.authCount++;
        user.authRecords.add(DateTime.now().toString());

        _logFingerprintTransaction(user);
      }
    }
    // Save the updated user data with authentication status to SharedPreferences
    _saveUsersToSharedPreferences();
    // Update the UI to reflect the changes
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fingerprint Auth Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: _users.length,
              itemBuilder: (context, index) {
                User user = _users[index];
                return ListTile(
                  title: Text(user.username),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.isAuthenticated
                          ? 'Authenticated'
                          : 'Not Authenticated'),
                      Text('Authentication Count: ${user.authCount}'),
                      Text('Authentication Records:'),
                      for (String record in user.authRecords) Text(record),
                    ],
                  ),
                  trailing: user.isAuthenticated
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Icon(Icons.not_interested, color: Colors.red),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addNewUser,
              child: Text('Add New User with Fingerprint'),
            ),
            ElevatedButton(
              onPressed: _authenticateAllUsers,
              child: Text('Authenticate All Users with Fingerprint'),
            ),
          ],
        ),
      ),
    );
  }
}
