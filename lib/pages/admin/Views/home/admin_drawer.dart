import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/admin_scaffold_controller.dart';
import 'package:epson_app/pages/admin/Views/develop_regist/admin_develop_regist_page.dart';
import 'package:epson_app/pages/admin/Views/print_regist/admin_print_regist_page.dart';
import 'package:epson_app/pages/admin/Views/sale_report/admin_sale_report_page.dart';
import 'package:epson_app/pages/admin/Views/settings/admin_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class AdminDrawer extends StatelessWidget {
  AdminDrawer({super.key});

  final scaffoldController = GetxManager.instance<AdminScaffoldController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      // width: MediaQuery.of(context).size.width * 0.7,
      child: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            _drawerHeader,
            ListTile(
              leading: const Icon(Icons.devices),
              title: const Text('개발자 등록'),
              onTap: () => Get.to(() => AdminDevelopRegistPage()),
            ),
            ListTile(
              leading: const Icon(Icons.app_registration_rounded),
              title: const Text('프린터 정보 등록'),
              onTap: () => Get.to(() => const AdminPrintRegistPage()),
            ),
            // ListTile(
            //   leading: const Icon(Icons.print_sharp),
            //   title: const Text('프린터 현황'),
            //   onTap: () => Get.to(() => const AdminPrintInfoList()),
            // ),
            ListTile(
              leading: const Icon(Icons.attach_money_rounded),
              title: const Text('판매 현황'),
              onTap: () => Get.to(() => AdminSaleReportPage()),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('설정'),
              onTap: () => Get.to(() => AdminSettingPage()),
            ),
            ListTile(
              onTap: () {
                scaffoldController.showDialog(
                    title: '확인',
                    content: '사용자 모드로 전환하시겠습니까?',
                    onConfirm: () {
                      // Get.offAll(page);
                    });
              },
              leading: const Icon(
                Icons.switch_camera_outlined,
                size: 20.0,
              ),
              title: const Text(
                '사용자 모드로 전환',
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _drawerHeader {
    return const SizedBox(
      width: double.infinity,
      child: DrawerHeader(
        decoration: BoxDecoration(color: Colors.lightBlue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Admin님 안녕하세요'),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text('판매금액'),
                SizedBox(width: 5),
                Text('12,000원'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
