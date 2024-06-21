import 'dart:math';

import 'package:epson_app/services/socialLogin/kakao_login_service.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class UserLoginViewModel extends GetxController {
  User? _user;
  KakaoLoginService kakaoLoginService;
  User? get user => _user;
  bool isLogined = false;

  UserLoginViewModel({required this.kakaoLoginService});
  // 카카오 로그인
  Future kakaoLogin() async {
    isLogined = await kakaoLoginService.login();
    if (isLogined) {
      _user = await UserApi.instance.me();
      print(_user?.kakaoAccount?.email);
    }
  }

  Future kakaoLogout() async {
    await kakaoLoginService.logout();
    isLogined = false;
    _user = null;
  }
}
