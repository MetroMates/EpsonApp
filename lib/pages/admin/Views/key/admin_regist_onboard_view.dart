import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminRegistOnBoardView extends StatelessWidget {
  const AdminRegistOnBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('관리자 가입'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              final uri = Uri.parse(
                  'https://www.epsonconnect.com/guide/ko/html/p01.htm');
              if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $uri';
              }
            },
            child: ListTile(
              title: const Text(
                'Epson Connect 회원가입',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const ListTile(
            title: Text('1. 위 링크로 들어가서 절차대로 Epson Connect 회원가입을 진행해주세요.'),
          ),
          const ListTile(
            title: Text('2. 프린터 등록 후 계정 가입이 가능합니다.'),
          ),
          const ListTile(
            title: Text(
                '3. 계정 가입 후 가입 이메일로 프린터 인증 키가 발신됩니다. \n(Epson Connect 서버 상황에 따라 최대 30분 까지 소요될수 있습니다.)'),
          ),
        ],
      ),
    );
  }
}
