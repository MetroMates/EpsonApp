import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:epson_app/env/env_constant.dart';

final class EncryptService {
  final _key = encrypt.Key.fromUtf8(Env.encryptKey);
  final _iv = encrypt.IV.fromLength(16);

  String setEncrypt(String text) {
    final encryptData = encrypt.Encrypter(encrypt.AES(_key));

    return encryptData.encrypt(text, iv: _iv).base64;
  }

  String requestAES(String text) {
    final encryptData = encrypt.Encrypter(encrypt.AES(_key));
    return encryptData.decrypt64(text, iv: _iv);
  }
}
