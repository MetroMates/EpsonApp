import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/print_info_viewmodel.dart';
import 'package:epson_app/pages/user/View/map/navar_map_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

final class AdminPrintRegistPage extends StatefulWidget {
  const AdminPrintRegistPage({super.key});
  @override
  State<AdminPrintRegistPage> createState() => _AdminPrintRegistPageState();
}

class _AdminPrintRegistPageState extends State<AdminPrintRegistPage> {
  final _formKey = GlobalKey<FormState>();
  final formController = GetxManager.instance<PrintInfoViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Printer Form'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Printer Alias'),
                onChanged: (value) => formController.alias.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter printer alias';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Printer Model'),
                onChanged: (value) => formController.model.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter printer model';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Print Name (Email)'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => formController.printEmail.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price per Page'),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    formController.perPrice.value = double.parse(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price per page';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                onChanged: (value) => formController.address.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: formController.postcodeController,
                decoration: const InputDecoration(
                  hintText: '우편번호',
                ),
                readOnly: true,
              ),
              TextFormField(
                controller: formController.addressController,
                decoration: const InputDecoration(
                  hintText: '기본주소',
                ),
                readOnly: true,
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                controller: formController.addressDetailController,
                decoration: const InputDecoration(
                  hintText: '상세주소 입력',
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  formController.searchAddress(context);
                },
                child: const Text('주소검색'),
              ),
              const SizedBox(
                height: 250,
                child: NaverMapView(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async =>
                    formController.submitData(formKey: _formKey),
                child: Text('Submit'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
