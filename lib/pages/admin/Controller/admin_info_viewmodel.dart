import 'dart:developer';

import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/admin_scaffold_controller.dart';
import 'package:epson_app/pages/admin/Model/admin_info.dart';
import 'package:epson_app/services/encrypt_service.dart';
import 'package:epson_app/services/firebase/firestore_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

final class AdminInfoViewModel extends GetxController {
  late final AdminInfo adminInfo;

  /// SecretKey
  Rx<String> secretKey = ''.obs;

  /// ClientKey
  Rx<String> clientKey = ''.obs;

  /// HostName
  Rx<String> hostName = ''.obs;

  final _firebaseService = FireStoreService.shared;

  Future<T?> fetchAdminInfo<T extends FireStoreObject>({
    required T Function(Map<String, dynamic>? decodeData) fromJson,
  }) async {
    final lineDatas = await _firebaseService.read<T>(
      col: "Admin",
      docID: "swjtwin79@gmail.com",
      fromJson: fromJson,
    );

    return lineDatas;
  }

  _setAdminInfo() {
    adminInfo = AdminInfo(
      clientID: EncryptService().setEncrypt(clientKey.value),
      clientSecretID: EncryptService().setEncrypt(secretKey.value),
      hostName: hostName.value,
    );
  }

  Future<void> submitData({
    required GlobalKey<FormState> formKey,
  }) async {
    final scaffoldController = GetxManager.instance<AdminScaffoldController>();
    final firestore = FireStoreService.shared;

    try {
      if (formKey.currentState!.validate()) {
        _setAdminInfo();

        firestore.update(
          col: '/Admin',
          docID: 'swjtwin79@gmail.com',
          data: adminInfo.toJson(),
        );

        // firestore.insert(col: '/Admin', docID: 'swjtwin79@gmail.com', data: adminInfo.toJson());

        scaffoldController.showSnackBar(
          title: '알림',
          message: '저장되었습니다.',
        );
      } else {
        scaffoldController.showSnackBar(
          title: '경고',
          message: '항목을 전부 채워주세요.',
        );
      }
    } catch (e) {
      log('AdminInfo Submit Error $e');
      return;
    }
  }
}
