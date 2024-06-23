import 'package:epson_app/pages/common/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDrawerView extends StatelessWidget {
  const UserDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPXjqDxw6z5IaV8CIDPGuT2xFEvLEjNQRa6Q&s', // 여기에 이미지 경로를 지정하세요.
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: Text('usage_record'.tr),
              onTap: () {
                // 이용내역 클릭 시 동작
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('setting'.tr),
              onTap: () {
                Get.to(() => SettingView());
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('logout'.tr),
              onTap: () {
                // 로그아웃 클릭 시 동작
              },
            ),
          ],
        ),
      ),
    );
  }
}
