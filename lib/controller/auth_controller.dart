
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();

  var isEmailValid = true.obs;
  var isPasswordValid = true.obs;
  var isFullNameValid = true.obs;

  String? validateEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
    return emailRegex.hasMatch(email) ? null : 'Enter a valid email address';
  }

  String? validatePassword(String password) {
    return password.length >= 8
        ? null
        : 'Password must be at least 8 characters';
  }

  String? validateName(String name) {
    return name.isNotEmpty && RegExp(r'^[a-zA-Z]+$').hasMatch(name)
        ? null
        : 'Name must only contain letters';
  }

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text;

    isEmailValid.value = validateEmail(email) == null;
    isPasswordValid.value = validatePassword(password) == null;

    if (isEmailValid.value && isPasswordValid.value) {
      Get.snackbar(
        'Success',
        'Logged In Successfully',
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        'Error',
        'Please correct the errors before proceeding',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  void signup({required String email, required String password, required String fullName}) {
    String email = emailController.text.trim();
    String password = passwordController.text;
    String fullName = fullNameController.text;

    isEmailValid.value = validateEmail(email) == null;
    isPasswordValid.value = validatePassword(password) == null;
    isFullNameValid.value = validateName(fullName) == null;

    if (isEmailValid.value && isPasswordValid.value && isFullNameValid.value) {
      Get.snackbar(
        'Success',
        'Logged In Successfully',
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        'Error',
        'Please correct the errors before proceeding',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
