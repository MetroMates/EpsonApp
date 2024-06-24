import 'dart:math';

import 'package:epson_app/services/socialLogin/firebase_auth_service.dart';
import 'package:epson_app/services/socialLogin/kakao_login_service.dart';
import 'package:epson_app/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class UserLoginViewModel extends GetxController {
  User? _user;
  final userid = Rx<Object?>(null);
  KakaoLoginService kakaoLoginService = KakaoLoginService();
  Rx<bool> isLogined = false.obs;

  // 자동 로그인
  Future<void> autoLogin() async {
    userid.value = await StorageService.read(key: 'id');
    print('${userid.value}!!!!!!!!!!!!!');
    if (userid.value != null) {
      isLogined.value = true;
    }
  }

  // 카카오 로그인
  Future<void> kakaoLogin() async {
    isLogined.value = await kakaoLoginService.login();
    if (isLogined.value) {
      _user = await UserApi.instance.me();
      if (_user != null) {
        userid.value = _user?.kakaoAccount?.email ?? '';
        await FirebaseAuthService().signup(
            email: _user?.kakaoAccount?.email ?? '',
            password: _user?.id.toString() ?? '');
        await StorageService.save(
            key: 'id', value: _user?.kakaoAccount?.email ?? '');
        print(_user?.kakaoAccount?.email);
      }
    }
  }

  Future<void> kakaoLogout() async {
    await kakaoLoginService.logout();
    isLogined.value = false;
    _user = null;
  }
}
