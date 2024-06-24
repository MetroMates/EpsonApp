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
    // switch (mode) {
    //   case ThemeMode.dark:
    //     Get.changeTheme(darkTheme());
    //   case ThemeMode.light:
    //     Get.changeTheme(lightTheme());
    //   case ThemeMode.system:
    // }
    themeMode.value = mode;
  }
}

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    shadowColor: Colors.white,
    canvasColor: Colors.black,
    hoverColor: Colors.tealAccent,
    focusColor: Colors.white,
    searchBarTheme: SearchBarThemeData(
      backgroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.3)),
      constraints: const BoxConstraints(
        minHeight: 35.0,
        maxHeight: 40.0,
      ),
      elevation: const MaterialStatePropertyAll(0.0),
    ),
    // indicatorColor: Colors.green,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.amberAccent,
      elevation: 0.0,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      selectedIconTheme: IconThemeData(
        color: Colors.amberAccent,
      ),
    ),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    primaryColor: Colors.black,
    // colorSchemeSeed: Colors.,
    shadowColor: Colors.black,
    hoverColor: Colors.teal,
    canvasColor: Colors.white,
    focusColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        // textStyle: MaterialStateTextStyle.resolveWith(
        //   (states) => const TextStyle(color: Colors.white),
        // ),
        overlayColor: MaterialStateColor.resolveWith(
            (states) => Colors.grey.withOpacity(0.3)),
      ),
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: MaterialStatePropertyAll(Colors.black.withOpacity(0.2)),
      constraints: const BoxConstraints(
        minHeight: 35.0,
        maxHeight: 40.0,
      ),
      elevation: const MaterialStatePropertyAll(0.0),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.orange,
      elevation: 0.0,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      selectedIconTheme: IconThemeData(
        color: Colors.orange,
      ),
    ),
  );
}
