import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Views/home/admin_home_page.dart';
import 'package:epson_app/pages/user/Controller/user_login_viewmodel.dart';
import 'package:epson_app/pages/user/View/user_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({super.key});

  final UserLoginViewModel userMapViewModel =
      GetxManager.instance<UserLoginViewModel>();

  Widget buildListTile(String title, dynamic trailing) {
    return ListTile(
      title: Text(title),
      trailing: trailing is Widget ? trailing : Text(trailing.toString()),
      onTap: () {
        Get.offAll(() => const AdminHomePage());
      },
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
                      ? 'please_login'.tr
                      : '${userMapViewModel.userid.value}',
                  style: const TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    if (!userMapViewModel.isLogined.value) {
                      Get.to(() => UserLoaginPage());
                    } else {
                      userMapViewModel.kakaoLogout();
                    }
                  },
                  child: !userMapViewModel.isLogined.value
                      ? Text('social_login'.tr)
                      : Text('logout'.tr),
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
                                  buildSectionTitle('my_activity'.tr),
                                  buildListTile('social_method'.tr, 'kakao'),
                                  buildListTile('usage_record'.tr,
                                      const Icon(Icons.keyboard_arrow_right)),
                                  buildListTile('admin_transfer'.tr,
                                      const Icon(Icons.compare_arrows)),
                                  buildSectionDivider(),
                                  buildSectionTitle('benefits'.tr),
                                  buildListTile('point'.tr,
                                      const Icon(Icons.keyboard_arrow_right)),
                                  buildSectionDivider(),
                                ],
                              )
                            : const SizedBox(),
                        buildSectionTitle('app_info'.tr),
                        buildListTile('ver_info'.tr, '1.0.0'),
                        buildListTile('term_use'.tr,
                            const Icon(Icons.keyboard_arrow_right)),
                        buildListTile('privacy_policy'.tr,
                            const Icon(Icons.keyboard_arrow_right)),
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
