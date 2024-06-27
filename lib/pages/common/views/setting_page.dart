import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/common/controllers/setting_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});

  final SettingViewModel settingViewModel =
      GetxManager.instance<SettingViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('change_theme'.tr),
                Obx(
                  () {
                    return DropdownButton<ThemeMode>(
                      value: settingViewModel.themeMode.value,
                      onChanged: (ThemeMode? newValue) {
                        settingViewModel.changeThemeMode(newValue!);
                      },
                      items: const [
                        DropdownMenuItem<ThemeMode>(
                          value: ThemeMode.system,
                          child: Text('System'),
                        ),
                        DropdownMenuItem<ThemeMode>(
                          value: ThemeMode.light,
                          child: Text('Light'),
                        ),
                        DropdownMenuItem<ThemeMode>(
                          value: ThemeMode.dark,
                          child: Text('Dark'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
