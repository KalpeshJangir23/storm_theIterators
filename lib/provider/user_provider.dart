import 'package:flutter/material.dart';

import 'package:nexus/model/user.dart';
import 'package:nexus/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user = (User(
    email: "",
    uid: "",
    photoUrl: "",
    username: "",
    followers: [],
    following: [],
    bio: '',
  ));
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
