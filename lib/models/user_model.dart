import 'dart:convert';

class User {
  final String id;
  final String username;
  final String passwordHash;
  bool isAuthenticated;
  int authCount;
  List<dynamic> authRecords; // Store authentication records

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
      authRecords: List<dynamic>.from(
        (map['authRecords'] as List<dynamic>),
      ),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
