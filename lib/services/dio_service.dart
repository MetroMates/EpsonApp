import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:epson_app/env/env_constant.dart';

final class DioService {
  static final DioService _instance = DioService._();
  // subjectID, token를 받아오기 위한 Env에서 받아오는 키값들 -> 추후 파이어베이스에서 받아온다.
  static final String _host = Env.hostName;
  static final String _clientId = Env.clientID;
  static final String _secretId = Env.clientSecretID;
  static const String _device = 'epson_tds2@print.epsonconnect.com';
  DioService._() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        if (error.type == DioExceptionType.connectionError) {
          // Log.debug('DIO Error / ${error.type}');
          log('AUTH : 인터넷 상태를 확인 바랍니다');
        } else if (error.type == DioExceptionType.receiveTimeout) {
          log('AUTH : 서버 통신이 원활하지 않습니다.');
        }

        handler.next(error);
      },
    ));
  }
  factory DioService() => _instance;

  final _dio = Dio();

  // RestAPI get방식 통신
  Future<dynamic> get({
    Object? parameter,
    required Options header,
    required String endPoint,
  }) async {
    final String uri = 'https://$_host$endPoint';

    final Response response = await _dio.get(
      uri,
      data: parameter,
      options: header,
    );

    if (response.statusCode == HttpStatus.ok) {
      return response.data;
    }
  }

  // RestAPI post방식 통신
  Future<Response> post({
    Object? parameter,
    required Options header,
    required String uri,
  }) async {
    log('POST URI: $uri');
    log('POST Headers: ${header.headers}');
    log('POST Parameters: ${parameter.toString()}');
    try {
      final Response response = await _dio.post(
        uri,
        data: parameter,
        options: header,
      );
      log('POST Response: ${response.data}');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else {
        throw HttpException(
            'Failed to post data, status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error during POST request: $e');
      rethrow;
    }
  }
}
