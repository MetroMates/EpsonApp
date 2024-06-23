import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/common/setting_page.dart';
import 'package:epson_app/pages/user/Controller/user_tab_viewmodel.dart';
import 'package:epson_app/pages/user/View/user_info_page.dart';
import 'package:epson_app/pages/user/View/user_main_page.dart';
import 'package:epson_app/pages/user/View/user_map_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTabView extends StatelessWidget {
  UserTabView({super.key});
  final List<Widget> _pages = [
    const UserMainPage(),
    const UserMapPage(),
    UserInfoPage(),
    SettingView(),
  ];

  final controller = GetxManager.instance<UserTabViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[controller.selectedIndex.value]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 30.0), // 플로팅 버튼을 더 내리기 위해 추가한 패딩
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 17, 76, 171),
          onPressed: () {
            // Handle center button action
          },
          child: const Icon(
            Icons.qr_code,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 1.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildNavItem(
                context: context,
                icon: Icons.home_outlined,
                label: 'home'.tr,
                onTap: () => controller.selectedIndex.value = 0,
                selected: controller.selectedIndex.value == 0,
              ),
              const Spacer(),
              buildNavItem(
                context: context,
                icon: Icons.map_outlined,
                label: 'map'.tr,
                onTap: () => controller.selectedIndex.value = 1,
                selected: controller.selectedIndex.value == 1,
              ),
              const Spacer(
                flex: 5,
              ),
              buildNavItem(
                context: context,
                icon: Icons.person_outline,
                label: 'my_info'.tr,
                onTap: () => controller.selectedIndex.value = 2,
                selected: controller.selectedIndex.value == 2,
              ),
              const Spacer(),
              buildNavItem(
                context: context,
                icon: Icons.settings_outlined,
                label: 'setting'.tr,
                onTap: () => controller.selectedIndex.value = 3,
                selected: controller.selectedIndex.value == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool selected,
  }) {
    return MaterialButton(
      minWidth: 30,
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            color: selected
                ? const Color.fromARGB(255, 17, 76, 171)
                : Theme.of(context).primaryColor,
            size: 30,
          ),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
