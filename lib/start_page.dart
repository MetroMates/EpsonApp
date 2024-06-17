import 'package:epson_app/pages/regist/regist_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

final class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: RegistPage(),
    );
  }
}
