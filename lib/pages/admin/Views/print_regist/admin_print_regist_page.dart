import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/admin_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class AdminPrintRegistPage extends StatefulWidget {
  const AdminPrintRegistPage({super.key});
  @override
  State<AdminPrintRegistPage> createState() => _AdminPrintRegistPageState();
}

class _AdminPrintRegistPageState extends State<AdminPrintRegistPage> {
  final _formKey = GlobalKey<FormState>();
  final formController = GetxManager.instance<AdminFormController>();

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
