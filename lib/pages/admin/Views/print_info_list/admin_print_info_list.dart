import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/print_info_viewmodel.dart';
import 'package:epson_app/pages/admin/Model/print_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class AdminPrintInfoList extends StatelessWidget {
  AdminPrintInfoList({super.key});

  final viewModel = GetxManager.instance<PrintInfoViewModel>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        viewModel.fetchPrintInfos();
        return ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: viewModel.printInfos.length,
          itemBuilder: (_, index) {
            final data = viewModel.printInfos[index];

            return PrintInfoCell(data: data);
          },
        );
      },
    );
  }
}

final class PrintInfoCell extends StatelessWidget {
  const PrintInfoCell({super.key, required this.data});

  final PrintInfo data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.printAlias),
      style: ListTileStyle.drawer,
      subtitle: Row(
        children: <Widget>[
          const Text('위치'),
          const SizedBox(width: 10),
          Text(data.address),
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
