import 'package:epson_app/pages/admin/Controller/admin_regist_viewmodel.dart';
import 'package:epson_app/pages/admin/Controller/admin_scaffold_controller.dart';
import 'package:epson_app/pages/admin/Controller/print_info_viewmodel.dart';
import 'package:epson_app/pages/admin/Views/%08sale/admin_sale_repot_viewmodel.dart';
import 'package:epson_app/pages/common/controllers/setting_viewmodel.dart';
import 'package:epson_app/pages/common/controllers/login_viewmodel.dart';
import 'package:epson_app/pages/user/Controller/user_map_viewmodel.dart';
import 'package:epson_app/pages/common/controllers/tab_viewmodel.dart';
import 'package:get/get.dart';

final class GetxManager {
  static create() {
    // common
    Get.put(SettingViewModel());
    Get.put(LoginViewModel());
    Get.put(TabViewModel());

    // admin
    Get.put(AdminRegistViewModel());
    Get.put(AdminSaleReportViewModel());
    Get.put(AdminScaffoldController());
    Get.put(PrintInfoViewModel());

    // user
    Get.put(UserMapViewModel());
  }

  static T instance<T extends GetxController>() {
    if (Get.isRegistered<T>()) {
      return Get.find<T>();
    }

    // final T temp = CustomGetx() as T;
    // return Get.put<T>(temp);

    throw Exception(
        'GetxManager init 함수에 $T 인스턴스를 생성해주시기 바랍니다.\r\n혹은 $T 타입은 lazyPut이 아닌 put으로 생성해주시기 바랍니다.');
  }
}
