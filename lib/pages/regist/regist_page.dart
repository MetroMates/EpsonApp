import 'package:epson_app/services/epson/epson_service.dart';
import 'package:flutter/material.dart';

/// EpsonConnect 등록
final class RegistPage extends StatelessWidget {
  const RegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text('스캔 목록에 넣어보기'),
              TextButton(
                  onPressed: () {
                    EpsonService.scanQueue();
                  },
                  child: const Text('동작')),
            ],
          ),
        ],
      ),
    );
  }
}
