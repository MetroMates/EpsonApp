import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminSignViewModel extends GetxController {
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var addressController = TextEditingController().obs;

  var isEmailValid = false.obs;

  void checkEmail(String email) {
    isEmailValid.value = GetUtils.isEmail(email);
  }
}
