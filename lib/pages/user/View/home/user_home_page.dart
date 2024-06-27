import 'package:epson_app/pages/user/View/map/navar_map_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final List<Map<String, String>> infoCards = [
    {'status': '인쇄가능', 'location': '3POP PC', 'date': '2024.06.15 17:27'},
    {'status': '인쇄가능', 'location': '24시 프린트카페', 'date': '2024.06.15 17:24'},
    {'status': '인쇄가능', 'location': '24시 프린트카페', 'date': '2024.03.30 21:28'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AirEpson'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: const Color.fromARGB(255, 17, 76, 171),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '(서비스장애) AirEpson 앱 지도 내 핀 표시 장애 안내',
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
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: NaverMapView(),
                ),
              ),
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
              flex: 2,
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
            const Expanded(flex: 1, child: SizedBox())
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String status, String location, String date) {
    return Card(
      color: const Color(0xFF3D4757),
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
