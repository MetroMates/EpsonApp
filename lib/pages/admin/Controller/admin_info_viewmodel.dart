import 'package:epson_app/services/firebase/firestore_service.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AdminInfoViewModel extends GetxController {
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
}
