import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:laradart/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';

enum SnackBarType {
  SUCCESS,
  ERROR,
  INFO,
}

@lazySingleton
class AlertService {
  final _snackbarService = locator<SnackbarService>();

  /// Show a snackbar [Snackbar]
  ///
  /// @param [String] message
  /// @param [IconData] icon
  /// @param [SnackBarType] type
  /// @return void
  void showSnackbar({
    @required String message,
    SnackBarType type,
  }) {
    _snackbarService.showCustomSnackBar(
      message: message,
      borderRadius: 15,
      icon: getIconByType(type),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      shouldIconPulse: false,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      duration: const Duration(seconds: 2),
      isDismissible: true,
    );
  }

  /// Get the corresponding icon and icon color
  /// based on provided [SnackBarType] type given.
  ///
  /// @param [SnackBarType] type
  /// @return [Icon]
  getIconByType(SnackBarType type) {
    switch (type) {
      case SnackBarType.SUCCESS:
        return Icon(
          Icons.check_circle_outline,
          color: Colors.green,
        );
      case SnackBarType.ERROR:
        return Icon(
          Icons.error_outline,
          color: Colors.red,
        );
      case SnackBarType.INFO:
        return Icon(
          Icons.info_outline,
          color: Colors.blue,
        );
      default:
        return Icon(
          Icons.info_outline,
          color: Colors.blue,
        );
    }
  }
}
