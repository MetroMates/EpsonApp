import 'package:epson_app/getx_manager.dart';
import 'package:epson_app/pages/admin/Controller/admin_scaffold_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

final class AdminFormController extends GetxController {
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

  /// SecretKey
  Rx<String> secretKey = ''.obs;

  /// ClientKey
  Rx<String> clientKey = ''.obs;

  /// HostName
  Rx<String> hostName = ''.obs;

  Future<void> submitData({
    required GlobalKey<FormState> formKey,
  }) async {
    final scaffoldController = GetxManager.instance<AdminScaffoldController>();

    if (formKey.currentState!.validate()) {
      // final response = await http.post(
      //   Uri.parse('https://yourserver.com/api/printers'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: jsonEncode(<String, String>{
      //     'alias': alias.value,
      //     'model': model.value,
      //     'email': email.value,
      //     'price': price.value,
      //     'address': address.value,
      //   }),
      // );

      // if (response.statusCode == 200) {
      //   Get.snackbar('Success', 'Data submitted successfully!',
      //       snackPosition: SnackPosition.BOTTOM);
      // } else {
      //   Get.snackbar('Error', 'Failed to submit data.',
      //       snackPosition: SnackPosition.BOTTOM);
      // }

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
