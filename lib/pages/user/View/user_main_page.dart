import 'package:epson_app/pages/user/View/user_drawer_view.dart';
import 'package:epson_app/pages/user/View/user_map_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  final List<Map<String, String>> infoCards = [
    {'status': '반납가능', 'location': '2층 바르셀로', 'date': '2024.06.15 17:27'},
    {'status': '대여점', 'location': '1층 드래곤와', 'date': '2024.06.15 17:24'},
    {'status': '대여점', 'location': '6층 스텝커피', 'date': '2024.03.30 21:28'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const UserDrawerView(),
      appBar: AppBar(
        title: const Text('Epson Printer'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '(서비스장애) 충전돼지 앱 지도 내 핀 표시 장애 안내',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'find_printer'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const Expanded(
              flex: 3,
              child: NaverMapView(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'recent_usage'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: infoCards.length,
                  itemBuilder: (context, index) {
                    final card = infoCards[index];
                    return _buildInfoCard(
                      card['status']!,
                      card['location']!,
                      card['date']!,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String status, String location, String date) {
    return Card(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status,
              style: const TextStyle(color: Colors.green),
            ),
            const SizedBox(height: 5),
            Text(
              location,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              date,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
