import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/admin_info_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class AdminDevelopRegistPage extends StatefulWidget {
  const AdminDevelopRegistPage({super.key});

  @override
  State<AdminDevelopRegistPage> createState() => _AdminDevelopRegistPageState();
}

class _AdminDevelopRegistPageState extends State<AdminDevelopRegistPage> {
  final _formKey = GlobalKey<FormState>();

  final viewModel = GetxManager.instance<AdminInfoViewModel>();

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
                onChanged: (value) => viewModel.secretKey.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter SecretKey';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ClientKey'),
                onChanged: (value) => viewModel.clientKey.value = value,
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
                onChanged: (value) => viewModel.hostName.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an HostName';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async => viewModel.submitData(formKey: _formKey),
                child: Text('Submit'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
