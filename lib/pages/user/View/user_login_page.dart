import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/user/Controller/user_login_viewmodel.dart';
import 'package:epson_app/pages/user/View/user_main_page.dart';
import 'package:epson_app/pages/user/View/user_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLoaginPage extends StatelessWidget {
  UserLoaginPage({super.key});

  final UserLoginViewModel userLoginViewModel =
      GetxManager.instance<UserLoginViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${'user'.tr} ${'social_login'.tr}'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'login_message'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildSocialLoginButton(
                context,
                color: const Color.fromARGB(255, 255, 230, 0),
                icon: 'https://cdn-icons-png.flaticon.com/512/2111/2111466.png',
                text: 'kakao_login'.tr,
                onPressed: () async {
                  // await userLoginViewModel.kakaoLogout();
                  await userLoginViewModel.kakaoLogin();
                  if (userLoginViewModel.isLogined.value) {
                    Get.offAll(() => UserTabView());
                  }
                },
                textColor: Colors.black,
              ),
              const SizedBox(height: 10),
              _buildSocialLoginButton(
                context,
                color: Colors.white,
                icon: 'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                text: 'google_login'.tr,
                onPressed: () {
                  // 구글 로그인 처리
                },
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton(
    BuildContext context, {
    required Color color,
    required String icon,
    required String text,
    required VoidCallback onPressed,
    Color textColor = Colors.white,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            icon,
            width: 30,
            height: 20,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
