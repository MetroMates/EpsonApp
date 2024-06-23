import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/admin_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class AdminDevelopRegistPage extends StatefulWidget {
  AdminDevelopRegistPage({super.key});

  final formController = GetxManager.instance<AdminFormController>();

  @override
  State<AdminDevelopRegistPage> createState() => _AdminDevelopRegistPageState();
}

class _AdminDevelopRegistPageState extends State<AdminDevelopRegistPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Develope Form'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'SecrectKey'),
                onChanged: (value) =>
                    widget.formController.secretKey.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter SecretKey';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ClientKey'),
                onChanged: (value) =>
                    widget.formController.clientKey.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ClientKey';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'HostName'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) =>
                    widget.formController.hostName.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an HostName';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async =>
                    widget.formController.submitData(formKey: _formKey),
                child: Text('Submit'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
