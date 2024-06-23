import 'dart:io';

import 'package:epson_app/pages/common/setting_page.dart';
import 'package:epson_app/services/epson/epson_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

/// EpsonConnect 등록
final class PrintRegistPage extends StatelessWidget {
  const PrintRegistPage({super.key});

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
              const Text('1'),
              TextButton(
                  onPressed: () async {
                    final epson = EpsonService(printNm: DeviceName.one);
                    await epson.createAuth();
                    // await epson.getDeviceInfo();
                    // await epson.scanQueue();
                  },
                  child: const Text('동작')),
            ],
          ),
          Row(
            children: <Widget>[
              const Text('2'),
              TextButton(
                  onPressed: () async {
                    final file = await pickPdfFile();
                    if (file != null) {
                      final epson = EpsonService(printNm: DeviceName.one);
                      await epson.createAuth();
                      await epson.printQueue(file.path);
                      // await epson.createAuth();
                      // await epson.getDeviceInfo();
                      // await epson.scanQueue();
                      // await epson.printQueue(file.path);
                    }
                  },
                  child: const Text('동작')),
            ],
          ),
          Row(
            children: <Widget>[
              const Text('3'),
              TextButton(
                  onPressed: () async {
                    final epson = EpsonService(printNm: DeviceName.three);
                    // await epson.createAuth();
                    // await epson.getDeviceInfo();
                    // await epson.scanQueue();
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
      allowedExtensions: [
        'pdf',
        'png',
        'jpeg',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'ppt',
        'pptx',
        'bmp',
        'gif',
        'tiff'
      ],
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    } else {
      // User canceled the picker
      return null;
    }
  }
}
