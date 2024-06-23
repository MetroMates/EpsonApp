import 'package:epson_app/pages/admin/Views/home/admin_drawer.dart';
import 'package:epson_app/pages/admin/Views/print_info_list/admin_print_info_list.dart';
import 'package:flutter/material.dart';

final class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프린터 현황'),
        centerTitle: true,
      ),
      drawer: AdminDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.3,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: AdminPrintInfoList(),
        ),
      ),
    );
  }
}
