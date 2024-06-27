import 'dart:developer';

import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/admin_scaffold_controller.dart';
import 'package:epson_app/pages/admin/Model/admin_info.dart';
import 'package:epson_app/pages/admin/Views/key/admin_develop_regist_page.dart';
import 'package:epson_app/pages/common/controllers/login_viewmodel.dart';
import 'package:epson_app/pages/common/controllers/tab_viewmodel.dart';
import 'package:epson_app/pages/common/views/tab_view.dart';
import 'package:epson_app/services/encrypt_service.dart';
import 'package:epson_app/services/firebase/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminRegistViewModel extends GetxController {
  late final AdminInfo adminInfo;

  /// SecretKey
  Rx<String> secretKey = ''.obs;

  /// ClientKey
  Rx<String> clientKey = ''.obs;

  final _firebaseService = FireStoreService.shared;
  PageController pageController = PageController();
  List<Widget> pages = [];

  Rx<int> currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      submitData();
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

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
      hostName: 'api.epsonconnect.com',
    );
  }

  Future<void> submitData() async {
    final scaffoldController = GetxManager.instance<AdminScaffoldController>();
    final userTabViewModel = GetxManager.instance<TabViewModel>();
    final userLoginViewModel = GetxManager.instance<LoginViewModel>();

    try {
      _setAdminInfo();

      _firebaseService.insert(
          col: 'Admin',
          docID: userLoginViewModel.userid.value,
          data: adminInfo.toJson());

      // firestore.insert(col: '/Admin', docID: 'swjtwin79@gmail.com', data: adminInfo.toJson());

      scaffoldController.showSnackBar(
        title: '알림',
        message: '관리자 가입에 성공했습니다.',
      );

      userTabViewModel.changeMode();
      Get.offAll(() => TabView());
      //  scaffoldController.showSnackBar(
      //     title: '경고',
      //     message: '항목을 전부 채워주세요.',
      //   );
    } catch (e) {
      log('AdminInfo Submit Error $e');
      return;
    }
  }
}
