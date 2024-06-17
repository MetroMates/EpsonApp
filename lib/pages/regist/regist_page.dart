import 'dart:io';

import 'package:epson_app/services/epson/epson_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

/// EpsonConnect 등록
final class RegistPage extends StatelessWidget {
  const RegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text('Epson Printer'),
            ),
          ],
        ),
      ),
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
          Row(
            children: <Widget>[
              const Text('출력 목록에 넣어보기'),
              TextButton(
                  onPressed: () async {
                    final file = await pickPdfFile();
                    if (file != null) {
                      await EpsonService.printQueue(file.path);
                    }
                  },
                  child: const Text('동작')),
            ],
          ),
          Row(
            children: <Widget>[
              const Text('프린터 정보가져오기'),
              TextButton(
                  onPressed: () async {
                    await EpsonService.getDeviceInfo();
                  },
                  child: const Text('동작')),
            ],
          ),
        ],
      ),
    );
  }

  Future<File?> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    } else {
      // User canceled the picker
      return null;
    }
  }
}
