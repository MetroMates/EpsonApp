import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

abstract class FireStoreObject {}

/// FireStore Service 싱글톤 객체
final class FireStoreService {
  static final FireStoreService shared = FireStoreService._();

  FireStoreService._();

  factory FireStoreService() => shared;

  /// db
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<T?> read<T extends FireStoreObject>({
    required String col,
    required String docID,
    required T Function(Map<String, dynamic>? decodeData) fromJson,
  }) async {
    try {
      final docRef = _db.collection(col).doc(docID);
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
      final docRef = _db.collection(col).doc(docID);
      final docData = await docRef.get();

      return docData.data();
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkIfFieldValueExists(
      String col, String fieldName, String value) async {
    try {
      QuerySnapshot query =
          await _db.collection(col).where(fieldName, isEqualTo: value).get();

      if (query.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error checking if field value exists: $e');
      return false;
    }
  }

  Future<bool> checkIfDocumentExists(
      String collection, String documentID) async {
    try {
      DocumentSnapshot documentSnapshot = await _db
          .collection(collection)
          .doc(documentID)
          .get(); // documentID로 문서 조회

      if (documentSnapshot.exists) {
        return true; // 문서가 존재하면 true 반환
      } else {
        return false; // 문서가 존재하지 않으면 false 반환
      }
    } catch (e) {
      print('Error checking if document exists: $e');
      return false;
    }
  }

  Future<List<T>> reads<T extends FireStoreObject>({
    required String col,
    required T Function(Map<String, dynamic> decodeData) fromJson,
  }) async {
    try {
      final colRef = _db.collection(col);
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

  void insertAll({
    required String col,
    required Map<String, dynamic> data,
  }) async {
    await _db.collection(col).add(data);
  }

  void insert({
    required String col,
    String? docID,
    required Map<String, dynamic> data,
  }) async {
    try {
      final DocumentReference<Map<String, dynamic>> docRef;
      if (docID == null) {
        docRef = _db.collection(col).doc();
      } else {
        docRef = _db.collection(col).doc(docID);
      }

      await docRef.set(data);
      log("DocumentSnapshot successfully Insert!");
    } catch (e) {
      log("Error Inserting document $e");
      rethrow;
    }
  }

  void update({
    required String col,
    required String docID,
    required Map<String, dynamic> data,
  }) async {
    try {
      final docRef = _db.collection(col).doc(docID);
      await docRef.update(data);
      log("DocumentSnapshot successfully updated!");
    } catch (e) {
      log("Error updating document $e");
      rethrow;
    }
  }
}
