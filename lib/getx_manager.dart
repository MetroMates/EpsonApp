import 'package:epson_app/pages/admin/Controller/admin_form_controller.dart';
import 'package:epson_app/pages/admin/Controller/admin_info_viewmodel.dart';
import 'package:epson_app/pages/admin/Controller/admin_scaffold_controller.dart';
import 'package:epson_app/pages/admin/Controller/admin_sigin_viewmodel.dart';
import 'package:epson_app/pages/admin/Views/print_info_list/print_info_viewmodel.dart';
import 'package:epson_app/pages/admin/Views/sale_report/admin_sale_repot_viewmodel.dart';
import 'package:epson_app/pages/common/controllers/setting_viewmodel.dart';
import 'package:epson_app/pages/user/Controller/user_login_viewmodel.dart';
import 'package:epson_app/pages/user/Controller/user_main_viewmodel.dart';
import 'package:epson_app/pages/user/Controller/user_map_viewmodel.dart';
import 'package:epson_app/pages/user/Controller/user_tab_viewmodel.dart';
import 'package:get/get.dart';

final class GetxManager {
  static create() {
    Get.put(AdminFormController());
    Get.put(AdminSaleReportViewModel());
    Get.put(AdminScaffoldController());

    Get.lazyPut(() => PrintInfoViewModel());
    Get.lazyPut(() => AdminInfoViewModel());
    Get.lazyPut(() => AdminSignViewModel());
    Get.lazyPut(() => SettingViewModel());
    Get.lazyPut(() => UserLoginViewModel());
    Get.lazyPut(() => UserMapViewModel());
    Get.lazyPut(() => UserMainViewModel());
    Get.lazyPut(() => UserTabViewModel());
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
