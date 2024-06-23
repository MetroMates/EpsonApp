import 'package:epson_app/pages/user/Controller/user_login_viewmodel.dart';
import 'package:epson_app/pages/user/View/user_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({super.key});

  final UserLoginViewModel userMapViewModel = Get.find<UserLoginViewModel>();

  Widget buildListTile(String title, dynamic trailing) {
    return ListTile(
      title: Text(title),
      trailing: trailing is Widget ? trailing : Text(trailing.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_info'.tr),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black12,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Color.fromARGB(255, 17, 76, 171),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  !userMapViewModel.isLogined.value
                      ? '로그인이 필요합니다.'
                      : '${userMapViewModel.userid.value}',
                  style: const TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    if (!userMapViewModel.isLogined.value) {
                      Get.to(() => const UserLoaginPage());
                    } else {
                      userMapViewModel.kakaoLogout();
                    }
                  },
                  child: !userMapViewModel.isLogined.value
                      ? const Text('로그인')
                      : const Text('로그아웃'),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        userMapViewModel.isLogined.value
                            ? Column(
                                children: [
                                  buildSectionTitle('내 활동'),
                                  buildListTile('소셜연동', '카카오'),
                                  buildListTile('이용내역',
                                      const Icon(Icons.keyboard_arrow_right)),
                                  buildListTile('관리자 전환',
                                      const Icon(Icons.compare_arrows)),
                                  buildSectionDivider(),
                                  buildSectionTitle('혜택'),
                                  buildListTile('포인트',
                                      const Icon(Icons.keyboard_arrow_right)),
                                  buildSectionDivider(),
                                ],
                              )
                            : const SizedBox(),
                        buildSectionTitle('앱 정보'),
                        buildListTile('버전정보', '1.0.0'),
                        buildListTile(
                            '이용약관', const Icon(Icons.keyboard_arrow_right)),
                        buildListTile(
                            '개인정보처리방침', const Icon(Icons.keyboard_arrow_right)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildSectionDivider() {
    return const Divider(color: Colors.grey);
  }
}
