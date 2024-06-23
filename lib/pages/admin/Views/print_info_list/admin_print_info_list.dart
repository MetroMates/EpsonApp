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
    return const ListTile(
      title: Text('프린터 이름'),
    );
  }
}
