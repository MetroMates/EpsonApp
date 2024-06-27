import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/admin_regist_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdminRegistKeyView extends StatelessWidget {
  AdminRegistKeyView({super.key});
  final viewmodel = GetxManager.instance<AdminRegistViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프린터 키 등록'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const ListTile(
            title: Text(
              '이메일로 받은 프린터 인증 키를 등록해주세요.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller:
                      TextEditingController(text: 'api.epsonconnect.com'),
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'HostName'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an HostName';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'SecrectKey'),
                  onChanged: (value) => viewmodel.secretKey.value = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter SecretKey';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'ClientKey'),
                  onChanged: (value) => viewmodel.clientKey.value = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ClientKey';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
