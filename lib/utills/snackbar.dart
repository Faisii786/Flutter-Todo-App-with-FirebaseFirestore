import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBar {
  static void showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
    );
  }
}
