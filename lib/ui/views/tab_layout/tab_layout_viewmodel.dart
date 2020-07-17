import 'package:flutter/material.dart';
import 'package:laradart/app/locator.dart';
import 'package:laradart/datamodels/user.dart';
import 'package:laradart/services/authentication_service.dart';
import 'package:stacked/stacked.dart';

class TabLayoutViewModel extends IndexTrackingViewModel {
  final _authService = locator<AuthenticationService>();

  User get user => _authService.user;

  int _currentIndex = 1;
  int get currentIndex => _currentIndex;
  setIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
