import 'package:flutter/material.dart';

final class AdminPrintInfoList extends StatelessWidget {
  const AdminPrintInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: 20,
      itemBuilder: (_, index) {
        return const PrintInfoCell();
      },
    );
  }
}

final class PrintInfoCell extends StatelessWidget {
  const PrintInfoCell({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('프린터 이름'),
      style: ListTileStyle.drawer,
      subtitle: const Row(
        children: <Widget>[
          Text('위치'),
          SizedBox(width: 10),
          Text('경기도 수원시 단원구'),
        ],
      ),
      trailing: InkWell(
        onTap: () {},
        child: const Text(
          'QR출력',
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
