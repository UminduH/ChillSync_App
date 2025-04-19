import 'package:chillsync/models/user_model.dart';
import 'package:chillsync/services/user_service.dart';
import 'package:chillsync/utils/helpers.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> fetchUser(String deviceId) async {
    _isLoading = true;
    notifyListeners();

    try {
      UserModel? userData = await _userService.getUserByDeviceId(deviceId);
      _user = userData;

    } catch (e) {
      Helpers.debugPrintWithBorder("Error fetching user: $e");
    }

    await Future.delayed(Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
  }
}