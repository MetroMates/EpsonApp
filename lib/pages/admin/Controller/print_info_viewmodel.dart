import 'dart:developer';

import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/admin_scaffold_controller.dart';
import 'package:epson_app/pages/admin/Model/print_info.dart';
import 'package:epson_app/services/firebase/firestore_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

final class PrintInfoViewModel extends GetxController {
  late PrintInfo printInfo;
  RxList<PrintInfo> printInfos = <PrintInfo>[].obs;

  /// 프린터 별칭
  Rx<String> alias = ''.obs;

  /// 프린터 모델
  Rx<String> model = ''.obs;

  /// 프린터Name (Email형식)
  Rx<String> printEmail = ''.obs;

  /// 장당 가격
  Rx<double> perPrice = 0.0.obs;

  /// 프린터기 위치 (주소)
  Rx<String> address = ''.obs;

  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController addressDetailController = TextEditingController();

  void searchAddress(BuildContext context) async {
    KopoModel? kopoModel = await Get.to(() => RemediKopo());

    final postcode = kopoModel?.zonecode ?? '';
    postcodeController.value = TextEditingValue(
      text: postcode,
    );

    final address = kopoModel?.address ?? '';
    addressController.value = TextEditingValue(
      text: address,
    );

    final buildingName = kopoModel?.buildingName ?? '';
    addressDetailController.value = TextEditingValue(
      text: buildingName,
    );
  }

  void fetchPrintInfos() async {
    try {
      final firestore = FireStoreService.shared;

      final datas = await firestore.reads<PrintInfo>(
        col: '/Admin/swjtwin79@gmail.com/PrintInfo',
        fromJson: (decodeData) => PrintInfo.fromJson(decodeData),
      );

      printInfos.clear();
      printInfos.addAll(datas);
    } catch (e) {
      log('FETCH ERROR $e');
      return;
    }
  }

  _setPrintInfo() {
    printInfo = PrintInfo(
      printAlias: alias.value,
      printEmail: printEmail.value,
      perPrice: perPrice.value,
      address: address.value,
      storeName: 'EPSON 서비스 역삼점',
      locX: 37.49938,
      locY: 127.0338,
    );
  }

  Future<void> submitData({
    required GlobalKey<FormState> formKey,
  }) async {
    final scaffoldController = GetxManager.instance<AdminScaffoldController>();
    final firestore = FireStoreService.shared;

    if (formKey.currentState!.validate()) {
      _setPrintInfo();
      try {
        firestore.insert(
          col: '/Admin/swjtwin79@gmail.com/PrintInfo',
          data: printInfo.toJson(),
        );
      } catch (e) {
        log('FireStore Error : $e');
        return;
      }

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
  }
}
