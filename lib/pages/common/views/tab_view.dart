import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Views/key/admin_develop_regist_page.dart';
import 'package:epson_app/pages/admin/Views/shop/admin_shop_regist_page.dart';
import 'package:epson_app/pages/admin/Views/%08sale/admin_sale_report_page.dart';
import 'package:epson_app/pages/common/controllers/tab_viewmodel.dart';
import 'package:epson_app/pages/common/views/setting_page.dart';
import 'package:epson_app/pages/common/views/info_page.dart';
import 'package:epson_app/pages/user/View/home/user_home_page.dart';
import 'package:epson_app/pages/user/View/map/user_map_page.dart';
import 'package:epson_app/pages/user/View/qr/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabView extends StatelessWidget {
  TabView({super.key});

  final controller = GetxManager.instance<TabViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final List<Widget> pages = controller.isAdminPage.value
            ? [
                const AdminShopRegistPage(),
                AdminSaleReportPage(),
                UserInfoPage(),
                SettingView(),
              ]
            : [
                const UserHomePage(),
                const UserMapPage(),
                UserInfoPage(),
                SettingView(),
              ];

        return pages[controller.selectedIndex.value];
      }),
      floatingActionButton: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 30.0), // 플로팅 버튼을 더 내리기 위해 추가한 패딩
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 17, 76, 171),
            onPressed: () {
              // Handle center button action
              Get.to(() => controller.isAdminPage.value
                  ? const AdminDevelopRegistPage()
                  : const QRScannerView());
            },
            child: Icon(
              controller.isAdminPage.value ? Icons.key : Icons.qr_code,
              color: Colors.white,
            ),
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
                icon: controller.isAdminPage.value
                    ? Icons.store_outlined
                    : Icons.home_outlined,
                label: controller.isAdminPage.value ? '매장' : 'home'.tr,
                onTap: () => controller.selectedIndex.value = 0,
                selected: controller.selectedIndex.value == 0,
              ),
              const Spacer(),
              buildNavItem(
                context: context,
                icon: controller.isAdminPage.value
                    ? Icons.attach_money_rounded
                    : Icons.map_outlined,
                label: controller.isAdminPage.value ? '수익' : 'map'.tr,
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
