import 'dart:convert';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/model.dart';

class FingerPrintService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  List<User> users = [];
  Future<List<User>> getUserWithHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> userStrings = pref.getStringList('users') ?? [];
    return userStrings.map((userString) {
      return User.fromJson(jsonDecode(userString));
    }).toList();
  }

  Future<void> saveUsersToSharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> userStrings =
        users.map((user) => jsonEncode(user.toJson())).toList();
    pref.setStringList('users', userStrings);
  }

  Future<bool> authenticate() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
      );
    } catch (e) {
      print('Error during biometric authentication: $e');
      return false;
    }
  }

  void logFingerprintTransaction(User user) {
    // In a real app, you would log the fingerprint authentication transaction for the specified user.
    print('Fingerprint transaction logged for user: ${user.username}');
  }

  void addNewUser() async {
    bool isAuthenticated = await authenticate();
    if (isAuthenticated) {
      User newUser = User(
        id: 'user_id_${users.length + 1}',
        username: 'NewUser${users.length + 1}',
        passwordHash: 'hashed_password_${users.length + 1}',
      );
      users.add(newUser);

      // Save the updated list of users to SharedPreferences
      saveUsersToSharedPreferences();

      // Log the fingerprint transaction for the new user
      logFingerprintTransaction(newUser);

      // Update the UI to reflect the new user added
    }
  }

  void authenticateAllUsers(List<User> userList) async {
    for (User user in userList) {
      bool isAuthenticated = await authenticate();
      if (isAuthenticated) {
        user.isAuthenticated = true;

        // Increment the authentication count and store the record
        user.authCount++;
        user.authRecords.add(DateTime.now().toString());

        logFingerprintTransaction(user);
      }
    }
    // Save the updated user data with authentication status to SharedPreferences
    saveUsersToSharedPreferences();
    // Update the UI to reflect the changes
  }
}
