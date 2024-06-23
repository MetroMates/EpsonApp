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
      appBar: AppBar(
        title: const Text('코코마트'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Two items per row
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                  fit: BoxFit.cover,
                  'https://mediaserver.goepson.com/ImConvServlet/imconv/6e7b49a4f05650d689d137d9e162e28aa6e95b69/515Wx515H?use=productpictures&hybrisId=B2C&assetDescr=b10_Business_Large_All_in_one'), // Replace with actual image URL
              const Text('1번 프린터'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                child: const Text('인쇄'),
              ),
              TextButton(
                onPressed: () async {
                  final epson = EpsonService(printNm: DeviceName.one);
                  await epson.createAuth();
                  // await epson.printQueue(file.path);
                  // await epson.createAuth();
                  // await epson.getDeviceInfo();
                  await epson.scanQueue();
                  // await epson.printQueue(file.path);
                },
                child: const Text('스캔'),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                  fit: BoxFit.cover,
                  'https://mediaserver.goepson.com/ImConvServlet/imconv/0619af7cee83d401607612732bbefbf806d55a96/1200Wx1200H?use=banner&hybrisId=B2C&assetDescr=EKL_L6460_690_460_normal'), // Replace with actual image URL
              const Text('2번 프린터'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                child: const Text('인쇄'),
              ),
              TextButton(
                onPressed: () async {
                  final epson = EpsonService(printNm: DeviceName.one);
                  await epson.createAuth();
                  // await epson.printQueue(file.path);
                  // await epson.createAuth();
                  // await epson.getDeviceInfo();
                  await epson.scanQueue();
                  // await epson.printQueue(file.path);
                },
                child: const Text('스캔'),
              ),
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
