import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class AdminScaffoldController extends GetxController {
  void showSnackBar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showDialog({
    required String title,
    required String content,
    VoidCallback? onConfirm,
  }) {
    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
        color: Colors.red,
      ),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textConfirm: 'OK',
      confirmTextColor: Colors.white,
      titlePadding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      contentPadding: const EdgeInsets.all(20.0),
      onConfirm: onConfirm,
      textCancel: 'Cancel',
      onCancel: () {},
    );
  }
}
