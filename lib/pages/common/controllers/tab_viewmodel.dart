import 'package:epson_app/pages/admin/Views/key/admin_develop_regist_page.dart';
import 'package:epson_app/pages/admin/Views/shop/admin_print_regist_page.dart';
import 'package:epson_app/pages/user/View/home/user_home_page.dart';
import 'package:epson_app/pages/common/views/tab_view.dart';
import 'package:epson_app/services/firebase/firestore_service.dart';
import 'package:get/get.dart';

class TabViewModel extends GetxController {
  var selectedIndex = 0.obs;
  var isAdminPage = false.obs;
  var isLoading = false.obs;

  void changeMode() {
    selectedIndex.value = 0;
    isAdminPage.value = !isAdminPage.value;
  }

  void registAdmin() {
    Get.to(() => const AdminDevelopRegistPage());
  }

  void checkAmdin(String userid) async {
    final firestore = FireStoreService.shared;
    isLoading.value = true;
    final isAdmin = await firestore.checkIfDocumentExists('Admin', userid);
    isLoading.value = false;
    if (isAdmin) {
      changeMode();
    } else {
      registAdmin();
    }
  }
}
