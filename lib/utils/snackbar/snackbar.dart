import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  static void showSnackbar({
    required String type,
    String? heading,
    required String message,
  }) {
    if (type == "Error") {
      Get.snackbar(type, message,
          icon: const Icon(Icons.error, color: Colors.white),
          colorText: Colors.white,
          backgroundColor: const Color.fromARGB(255, 236, 18, 18),
          margin: const EdgeInsets.only(bottom: 0.0),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
    if (type == "Success") {
      Get.snackbar(type, message,
          icon: const Icon(Icons.done_rounded, color: Colors.white),
          colorText: Colors.white,
          backgroundColor: Colors.green,
          margin: const EdgeInsets.only(bottom: 0.0),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
    if (type == "Warning") {
      Get.snackbar(type, message,
          icon: const Icon(Icons.warning_sharp, color: Colors.white),
          colorText: Colors.white,
          backgroundColor: const Color(0xFFFFC017),
          margin: const EdgeInsets.only(bottom: 0.0),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
    if (type == "Information") {
      Get.snackbar(type, message,
          icon: const Icon(Icons.info_sharp, color: Colors.white),
          colorText: Colors.white,
          backgroundColor: const Color.fromARGB(255, 23, 131, 255),
          margin: const EdgeInsets.only(bottom: 0.0),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
    if (type == "Revision") {
      Get.snackbar(type, message,
          icon: const Icon(Icons.info_sharp, color: Colors.white),
          colorText: Colors.white,
          backgroundColor: const Color(0xFF00BBA2),
          margin: const EdgeInsets.only(bottom: 0.0),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1));
    }
    if (type == "permission_access") {
      Get.snackbar(heading!, message,
          icon: const Icon(Icons.error, color: Colors.white),
          colorText: Colors.white,
          backgroundColor: const Color.fromARGB(255, 236, 18, 18),
          margin: const EdgeInsets.only(bottom: 0.0),
          snackPosition: SnackPosition.BOTTOM,
          mainButton: TextButton(
              onPressed: () {
                // openAppSettings();
              },
              child: const Text(
                'Open Settings',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          duration: const Duration(seconds: 5));
    }
  }
}
