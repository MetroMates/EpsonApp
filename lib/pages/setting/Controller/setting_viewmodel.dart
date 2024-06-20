import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingViewModel extends GetxController {
  var selectedLanguage = Get.deviceLocale?.languageCode.obs;
  var themeMode = ThemeMode.system.obs;

  void changeLanguage(String languageCode) {
    Locale locale;
    switch (languageCode) {
      case 'ko':
        locale = const Locale('ko', 'KR');
        break;
      case 'ja':
        locale = const Locale('ja', 'JP');
        break;
      case 'en':
      default:
        locale = const Locale('en', 'US');
    }
    Get.updateLocale(locale);
    selectedLanguage?.value = languageCode;
  }

  void changeThemeMode(ThemeMode mode) {
    Get.changeThemeMode(mode);
    themeMode.value = mode;
  }
}
