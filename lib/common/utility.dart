import 'package:flutter/material.dart';
import 'package:airhost_todo/common/constants.dart';

typedef ConfirmCallback = void Function();
typedef CancelCallback = void Function();

class Utility {
  static void confirm(
    BuildContext context, {
    required String title,
    required String content,
    required ConfirmCallback onConfirm,
    required CancelCallback onCancel,
    String confirmButtonText = 'Confirm',
    String cancelButtonText = 'Cancel',
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: Text(cancelButtonText),
            onPressed: onCancel,
          ),
          TextButton(
            child: Text(confirmButtonText),
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }

  static void showSnackBar(
    BuildContext context, {
    required String content,
    int seconds = Constants.snackBarDuration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(seconds: Constants.snackBarDuration),
      ),
    );
  }
}
