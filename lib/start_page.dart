import 'package:epson_app/pages/home/home_page.dart';
import 'package:flutter/material.dart';

final class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
