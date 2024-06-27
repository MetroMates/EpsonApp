import 'package:get/get.dart';

final class AdminSaleReportViewModel extends GetxController {
  // 임의의 데이터
  RxList<Map<String, Object>> transactions = [
    {
      'usageDate': '2024-06-23 10:30',
      'usageLocation': '서울시 강남구',
      'userId': 'user1234',
      'amount': 120000.0,
    },
    {
      'usageDate': '2024-06-24 14:15',
      'usageLocation': '부산시 해운대구',
      'userId': 'user5678',
      'amount': 85000.0,
    },
    {
      'usageDate': '2024-06-25 09:00',
      'usageLocation': '대구시 중구',
      'userId': 'user9876',
      'amount': 50000.0,
    },
    {
      'usageDate': '2024-06-26 18:45',
      'usageLocation': '인천시 남구',
      'userId': 'user2468',
      'amount': 65000.0,
    },
    {
      'usageDate': '2024-06-27 12:00',
      'usageLocation': '광주시 서구',
      'userId': 'user1357',
      'amount': 75000.0,
    },
    {
      'usageDate': '2024-06-28 16:30',
      'usageLocation': '울산시 동구',
      'userId': 'user9876',
      'amount': 55000.0,
    },
    {
      'usageDate': '2024-06-29 09:15',
      'usageLocation': '제주시 중앙로',
      'userId': 'user4567',
      'amount': 48000.0,
    },
    {
      'usageDate': '2024-06-23 10:30',
      'usageLocation': '서울시 강남구',
      'userId': 'user1234',
      'amount': 120000.0,
    },
    {
      'usageDate': '2024-06-24 14:15',
      'usageLocation': '부산시 해운대구',
      'userId': 'user5678',
      'amount': 85000.0,
    },
    {
      'usageDate': '2024-06-25 09:00',
      'usageLocation': '대구시 중구',
      'userId': 'user9876',
      'amount': 50000.0,
    },
    {
      'usageDate': '2024-06-26 18:45',
      'usageLocation': '인천시 남구',
      'userId': 'user2468',
      'amount': 65000.0,
    },
    {
      'usageDate': '2024-06-27 12:00',
      'usageLocation': '광주시 서구',
      'userId': 'user1357',
      'amount': 75000.0,
    },
    {
      'usageDate': '2024-06-28 16:30',
      'usageLocation': '울산시 동구',
      'userId': 'user9876',
      'amount': 55000.0,
    },
    {
      'usageDate': '2024-06-29 09:15',
      'usageLocation': '제주시 중앙로',
      'userId': 'user4567',
      'amount': 48000.0,
    },
  ].obs;
}
