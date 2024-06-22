import 'package:epson_app/pages/admin/View/admin_login_page.dart';
import 'package:epson_app/pages/common/controllers/setting_viewmodel.dart';
import 'package:epson_app/pages/regist/regist_page.dart';
import 'package:epson_app/pages/user/View/user_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

final class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingViewModel settingViewModel = Get.find<SettingViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Epson Printer Reservation'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('change_language'.tr),
                  Obx(
                    () {
                      return DropdownButton<String>(
                        value: settingViewModel.selectedLanguage?.value,
                        onChanged: (String? newValue) {
                          settingViewModel.changeLanguage(newValue!);
                        },
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'en',
                            child: Text('English'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'ko',
                            child: Text('한국어'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'ja',
                            child: Text('日本語'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const AdminLoginPage());
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.7),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.admin_panel_settings_outlined),
                          Text('admin'.tr),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const UserLoaginPage());
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.7),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.person_4_outlined),
                          Text('user'.tr),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )

            // const SizedBox(height: 20),
            // Text('change_theme'.tr),
            // Obx(() {
            //   return DropdownButton<ThemeMode>(
            //     value: settingViewModel.themeMode.value,
            //     onChanged: (ThemeMode? newValue) {
            //       settingViewModel.changeThemeMode(newValue!);
            //     },
            //     items: const [
            //       DropdownMenuItem<ThemeMode>(
            //         value: ThemeMode.system,
            //         child: Text('System'),
            //       ),
            //       DropdownMenuItem<ThemeMode>(
            //         value: ThemeMode.light,
            //         child: Text('Light'),
            //       ),
            //       DropdownMenuItem<ThemeMode>(
            //         value: ThemeMode.dark,
            //         child: Text('Dark'),
            //       ),
            //     ],
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}
