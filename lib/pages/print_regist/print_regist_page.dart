import 'dart:io';
import 'package:epson_app/services/epson/epson_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

/// EpsonConnect 등록
final class PrintRegistPage extends StatelessWidget {
  const PrintRegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3POP PC방'),
        centerTitle: true,
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

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프린터 이용하기'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(),
            SizedBox(height: 16),
            StatusSection(),
            SizedBox(height: 16),
            InfoSection(),
            SizedBox(height: 16),
            ButtonSection(),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '세븐일레븐 - 인계베스트점',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlotInfo(title: '이용가능', count: 2),
            SizedBox(width: 32),
            SlotInfo(title: '이용불가', count: 1),
          ],
        ),
      ],
    );
  }
}

class SlotInfo extends StatelessWidget {
  final String title;
  final int count;

  const SlotInfo({super.key, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          '$count',
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ],
    );
  }
}

class StatusSection extends StatelessWidget {
  const StatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusRow(
            label: '기기상태',
            value: 'ON',
            valueColor: Colors.green,
          ),
          StatusRow(
            label: '세부위치',
            value: '취식대 위',
          ),
        ],
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const StatusRow(
      {super.key, required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          Text(value,
              style: TextStyle(
                  color: valueColor ?? Colors.black,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(icon: Icons.phone, label: '매장전화', value: '-'),
          InfoRow(
              icon: Icons.monetization_on,
              label: '요금정보',
              value: '1시간당 / 1,100원'),
          InfoRow(
              icon: Icons.access_time, label: '운영시간', value: '00:00 - 24:00'),
          InfoRow(
              icon: Icons.web, label: '웹주소', value: 'm.7-eleven.co.kr:444/'),
          InfoRow(icon: Icons.info, label: '기타안내', value: ''),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 8),
          Text(label),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('QR 스캔'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('길 찾기'),
          ),
        ),
      ],
    );
  }
}
