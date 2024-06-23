import 'dart:developer';

import 'package:epson_app/env/env_constant.dart';
import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/common/controllers/setting_viewmodel.dart';
import 'package:epson_app/pages/user/Controller/user_login_viewmodel.dart';
import 'package:epson_app/pages/user/Controller/user_main_viewmodel.dart';
import 'package:epson_app/pages/user/Controller/user_map_viewmodel.dart';
import 'package:epson_app/pages/user/Controller/user_tab_viewmodel.dart';
import 'package:epson_app/pages/user/View/user_main_page.dart';
import 'package:epson_app/pages/user/View/user_tab_view.dart';
import 'package:epson_app/services/firebase/firebase_options.dart';
import 'package:epson_app/services/translation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'services/storage_service.dart';
import 'start_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await Env.initEnv(isDebug: true);
  KakaoSdk.init(nativeAppKey: Env.kakaoNativeKey);
  await NaverMapSdk.instance.initialize(
      clientId: Env.naverMapKey,
      onAuthFailed: (error) {
        log('Auth failed: $error');
      });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetxManager.init();

  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingViewModel settingViewModel = Get.put(SettingViewModel());
    final UserMainViewModel userMainViewModel = Get.put(UserMainViewModel());
    final UserMapViewModel userMapViewModel = Get.put(UserMapViewModel());
    final UserLoginViewModel userLoginViewModel = Get.put(UserLoginViewModel());
    Get.put(UserTabViewModel());
    userLoginViewModel.autoLogin();
    userMapViewModel.setCenter();
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() async {
        Get.put(SettingViewModel());
        Get.put(UserLoginViewModel());
        Get.put(UserMainViewModel());
      }),
      translations: MyTranslations(),
      locale: Get.deviceLocale, // 기기 설정 언어로 초기화
      fallbackLocale: const Locale('en', 'US'), // 지원되지 않는 언어일 때 기본 언어
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: settingViewModel.themeMode.value,
      home: UserTabView(),
    );
  }
}
