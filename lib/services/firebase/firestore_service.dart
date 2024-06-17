import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireStoreObject {}

/// FireStore Service 싱글톤 객체
final class FireStoreService {
  static final FireStoreService shared = FireStoreService._();

  FireStoreService._();

  factory FireStoreService() => shared;

  /// db
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<T?> read<T extends FireStoreObject>({
    required String col,
    required String docID,
    required T Function(Map<String, dynamic>? decodeData) fromJson,
  }) async {
    try {
      final docRef = db.collection(col).doc(docID);
      final docData = await docRef.get();

      return fromJson(docData.data());
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> readObject<T extends FireStoreObject>({
    required String col,
    required String docID,
  }) async {
    try {
      final docRef = db.collection(col).doc(docID);
      final docData = await docRef.get();

      return docData.data();
    } catch (e) {
      return null;
    }
  }

  Future<List<T>> reads<T extends FireStoreObject>({
    required String col,
    required T Function(Map<String, dynamic> decodeData) fromJson,
  }) async {
    try {
      final colRef = db.collection(col);
      final datas = await colRef.get();

      List<T> rtnDatas = [];

      for (var doc in datas.docs) {
        final data = fromJson(doc.data());
        rtnDatas.add(data);
      }
      return rtnDatas;
    } catch (e) {
      return [];
    }
  }
}
