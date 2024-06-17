import 'package:epson_app/env/env_constant.dart';
import 'package:epson_app/pages/admin/Controller/admin_info_viewmodel.dart';
import 'package:epson_app/services/epson/epson_service.dart';
import 'package:epson_app/services/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'services/storage_service.dart';
import 'start_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await Env.initEnv(isDebug: true);
  await EpsonService.createAuth();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const StartPage();
  }
}
