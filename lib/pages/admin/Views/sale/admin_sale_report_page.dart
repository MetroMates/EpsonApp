import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Views/%08sale/admin_sale_repot_viewmodel.dart';
import 'package:flutter/material.dart';

final class AdminSaleReportPage extends StatelessWidget {
  AdminSaleReportPage({super.key});

  final viewModel = GetxManager.instance<AdminSaleReportViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('판매 현황'),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: const MaterialStatePropertyAll(Colors.lightBlue),
            dividerThickness: 2.0,
            horizontalMargin: 20.0,
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            columns: const [
              DataColumn(label: Text('사용일시')),
              DataColumn(label: Text('사용위치')),
              DataColumn(label: Text('사용자아이디')),
              DataColumn(label: Text('사용금액')),
            ],
            rows: viewModel.transactions.map(
              (data) {
                return DataRow(cells: [
                  DataCell(Text(data['usageDate'].toString())),
                  DataCell(Text(data['usageLocation'].toString())),
                  DataCell(Text(data['userId'].toString())),
                  DataCell(Text(data['amount'].toString())),
                ]);
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
