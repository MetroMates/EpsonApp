import 'package:epson_app/pages/print_regist/print_regist_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class QRScannerView extends StatelessWidget {
  const QRScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.off(() => const PrintRegistPage());
        },
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR스캔'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 100),
            const Text(
              '화면의 테두리 안에 QR코드를 스캔해주세요.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 100),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.qr_code_2,
                size: 150.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
