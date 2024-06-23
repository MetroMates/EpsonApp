import 'package:epson_app/services/socialLogin/social_login.dart';
import 'package:epson_app/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future<void> signup({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-user') {
        _signIn(email: email, password: password);
      }
    }
  }

  Future<void> _signIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}
