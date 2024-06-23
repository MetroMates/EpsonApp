import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/admin_scaffold_controller.dart';
import 'package:flutter/material.dart';

final class AdminSettingPage extends StatelessWidget {
  AdminSettingPage({super.key});

  final scaffoldController = GetxManager.instance<AdminScaffoldController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SETTING'),
      ),
      body: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('테마 설정'),
            ),
            const ListTile(
              leading: Icon(Icons.language_rounded),
              title: Text('언어 변경'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('로그아웃'),
              onTap: () {
                scaffoldController.showDialog(
                    title: '확인', content: '로그아웃 하시겠습니까?');
              },
            ),
            const ListTile(
              leading: Icon(Icons.dangerous_outlined),
              title: Text('회원탈퇴'),
            ),
          ],
        ),
      ),
    );
  }
}
