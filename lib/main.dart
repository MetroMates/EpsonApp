import 'package:epson_app/env/env_constant.dart';
import 'package:epson_app/services/epson/epson_service.dart';
import 'package:flutter/material.dart';

import 'services/storage_service.dart';
import 'start_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await Env.initEnv(isDebug: true);
  await EpsonService.createAuth();

  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const StartPage();
  }
}
