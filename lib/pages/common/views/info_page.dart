import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/common/controllers/login_viewmodel.dart';
import 'package:epson_app/pages/common/controllers/tab_viewmodel.dart';
import 'package:epson_app/pages/common/views/login_page.dart';
import 'package:epson_app/pages/user/View/home/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({super.key});

  final LoginViewModel loginViewModel = GetxManager.instance<LoginViewModel>();
  final userTabViewModel = GetxManager.instance<TabViewModel>();
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
                  !loginViewModel.isLogined.value
                      ? 'please_login'.tr
                      : '${loginViewModel.userid.value}',
                  style: const TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    if (!loginViewModel.isLogined.value) {
                      Get.to(() => LoginPage());
                    } else {
                      userTabViewModel.selectedIndex.value = 0;
                      userTabViewModel.isAdminPage.value = false;
                      loginViewModel.kakaoLogout();
                    }
                  },
                  child: !loginViewModel.isLogined.value
                      ? Text('social_login'.tr)
                      : Text('logout'.tr),
                ),
                Obx(
                  () {
                    if (userTabViewModel.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            loginViewModel.isLogined.value
                                ? Column(
                                    children: [
                                      activityInfo(),
                                      userTabViewModel.isAdminPage.value
                                          ? const SizedBox()
                                          : benefitInfo(),
                                    ],
                                  )
                                : const SizedBox(),
                            appInfo(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget activityInfo() {
    return Column(
      children: [
        buildSectionTitle('my_activity'.tr),
        buildListTile('social_method'.tr, 'kakao', onTap: () {}),
        userTabViewModel.isAdminPage.value
            ? const SizedBox()
            : buildListTile(
                'usage_record'.tr, const Icon(Icons.keyboard_arrow_right),
                onTap: () {}),
        buildListTile(
            userTabViewModel.isAdminPage.value ? '사용자 전환' : 'admin_transfer'.tr,
            const Icon(Icons.keyboard_arrow_right), onTap: () {
          userTabViewModel.checkAmdin(loginViewModel.userid.value ?? '');
        }),
        buildSectionDivider(),
      ],
    );
  }

  Widget benefitInfo() {
    return Column(
      children: [
        buildSectionTitle('benefits'.tr),
        buildListTile('point'.tr, const Icon(Icons.keyboard_arrow_right),
            onTap: () {}),
        buildSectionDivider(),
      ],
    );
  }

  Widget appInfo() {
    return Column(
      children: [
        buildSectionTitle('app_info'.tr),
        buildListTile('ver_info'.tr, '1.0.0', onTap: () {}),
        buildListTile('term_use'.tr, const Icon(Icons.keyboard_arrow_right),
            onTap: () {}),
        buildListTile(
            'privacy_policy'.tr, const Icon(Icons.keyboard_arrow_right),
            onTap: () {}),
      ],
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

  Widget buildListTile(String title, dynamic trailing,
      {required VoidCallback onTap}) {
    return ListTile(
        title: Text(title),
        trailing: trailing is Widget ? trailing : Text(trailing.toString()),
        onTap: onTap);
  }

  Widget buildSectionDivider() {
    return const Divider(color: Colors.grey);
  }
}
