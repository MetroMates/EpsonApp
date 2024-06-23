import 'package:epson_app/services/socialLogin/firebase_auth_service.dart';
import 'package:epson_app/services/socialLogin/kakao_login_service.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class UserLoginViewModel extends GetxController {
  User? _user;
  KakaoLoginService kakaoLoginService = KakaoLoginService();
  User? get user => _user;
  bool isLogined = false;

  // 카카오 로그인
  Future kakaoLogin() async {
    isLogined = await kakaoLoginService.login();
    if (isLogined) {
      _user = await UserApi.instance.me();
      FirebaseAuthService().signup(
          email: _user?.kakaoAccount?.email ?? '',
          password: _user!.id.toString());
      print(_user?.kakaoAccount?.email);
    }
  }

  Future kakaoLogout() async {
    await kakaoLoginService.logout();
    isLogined = false;
    _user = null;
  }
}
