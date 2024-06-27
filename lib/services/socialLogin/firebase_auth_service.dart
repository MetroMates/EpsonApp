import 'dart:math';

import 'package:epson_app/services/firebase/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:epson_app/pages/user/Model/user.dart' as app_user;

class FirebaseAuthService {
  Future<void> signup(
      {required String email,
      required String password,
      required String nickname}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      insertFireStore(email: email, nickName: nickname);
    } on FirebaseAuthException catch (e) {
      print('${e.code}생성');
      if (e.code == 'email-already-in-user') {
        _signIn(email: email, password: password, nickname: nickname);
      }
    }
  }

  Future<void> _signIn(
      {required String email,
      required String password,
      required String nickname}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('${e.code}로그인');
    }
  }

  void insertFireStore(
      {required String email, required String nickName}) async {
    final firestore = FireStoreService.shared;
    if (!await firestore.checkIfFieldValueExists('User', 'email', email)) {
      final user = app_user.User(email: email, nickName: nickName);
      firestore.insertAll(col: 'User', data: user.toJson());
    } else {
      print('이미 데이터베이스에 email이 있습니다.');
    }
  }
}
