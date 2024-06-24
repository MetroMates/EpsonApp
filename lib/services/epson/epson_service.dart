import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:epson_app/services/dio_service.dart';
// import 'package:path/path.dart' as path;
import 'package:epson_app/services/epson/scan_type.dart';
import 'package:file_picker/file_picker.dart';

import '../../env/env_constant.dart';

// 1. 관리자가 프린터를 등록하고 epson connect에 가입을 하면 이메일로 clientID, secterID를 받는다.
// 2. 받은 키값들과 프린터 이메일로 subjectID, token을 받는다. (token은 60분 유효)

enum DeviceName {
  one,
  two,
  three;

  String get name {
    switch (this) {
      case DeviceName.one:
        return 'epson_tds@print.epsonconnect.com';
      case DeviceName.two:
        return 'epson_tds2@print.epsonconnect.com';
      case DeviceName.three:
        return 'epson_tds3@print.epsonconnect.com';
    }
  }
}

final class EpsonService {
  final _dio = DioService();

  // subjectID, token를 받아오기 위한 Env에서 받아오는 키값들 -> 추후 파이어베이스에서 받아온다.
  final String _host = Env.hostName;
  final String _clientId = Env.clientID;
  final String _secretId = Env.clientSecretID;

  String get host => _host;
  String get clientId => _clientId;
  String get secretId => _secretId;

  final DeviceName printNm;
  String get device => printNm.name;

  EpsonService({required this.printNm});

  // 2번을 통해 받아오는 값들 -> 앱 시작시 파이어베이스에서 받아온 값들로 api통신 후 값 할당
  String _subjectId = '';
  String _accessToken = '';

  // 2번 api 통신후 받아온 값 여부
  bool get _isTokenAndDeviceIdExist =>
      (_subjectId.isEmpty || _accessToken.isEmpty) ? false : true;

  Options get _commonHeader => Options(
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json;charset=utf-8',
        },
      );

  Map<String, String> fileTypeMapping = {
    'pdf': 'document',
    'png': 'photo',
    'jpeg': 'photo',
    'doc': 'document',
    'docx': 'document',
    'xls': 'document',
    'xlsx': 'document',
    'ppt': 'document',
    'pptx': 'document',
    'bmp': 'photo',
    'gif': 'photo',
    'tiff': 'photo'
  };

  Map<String, String> mimeTypeMapping = {
    'photo': 'image/jpeg',
    'document': 'application/octet-stream'
  };

  // 파일 확장자로부터 타입을 반환하는 함수
  (String, String) getFileType(String extension) {
    String type = fileTypeMapping[extension] ?? 'document';
    String mimeType = mimeTypeMapping[type] ?? 'application/octet-stream';

    return (type, mimeType);
  }

  /// 2번 API 통신 (Authentication API)
  Future<void> createAuth() async {
    // Header Auth
    final String auth = base64Encode(utf8.encode('$_clientId:$_secretId'));

    log('AUTH : $auth');

    // Header
    final Map<String, String> authHeaders = {
      'Authorization': 'Basic $auth',
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };

    // Parameter
    final Map<String, String> queryParams = {
      'grant_type': 'password',
      'username': device,
      'password': '',
    };

    try {
      // Post 통신
      final authResponse = await _dio.post(
        uri: 'https://$_host/api/1/printing/oauth2/auth/token?subject=printer',
        header: Options(headers: authHeaders),
        parameter: queryParams,
      );

      // 통신 성공 후 받아온 body 값
      final Map<String, dynamic> authBody = authResponse.data;

      log('AuthBODY : $authBody');

      // 값 할당
      _subjectId = authBody['subject_id'] ?? '';
      _accessToken = authBody['access_token'] ?? '';
    } catch (e) {
      log('Error during authentication: $e');
    }
  }

  /// Scan Method
  scanQueue() async {
    if (!_isTokenAndDeviceIdExist) {
      log('Token 데이터가 없습니다.');
      return;
    }

    try {
      // 스캔 등록하기

      final Map<String, dynamic> dataParam = {
        'alias_name': 'ScanTitle2',
        'type': ScanType.mail.name,
        'destination': 'swjtwin@naver.com'
      };

      final Response addResponse = await _dio.post(
        uri: 'https://$_host/api/1/scanning/scanners/$_subjectId/destinations',
        parameter: jsonEncode(dataParam),
        header: _commonHeader,
      );

      if (addResponse.statusCode != HttpStatus.ok) {
        log('Register scan destination failed: ${addResponse.statusCode}');
        log(addResponse.data.toString());
        return;
      }

      log('2. Register scan destination: ----------------------');

      log(dataParam.toString());
      log(addResponse.data.toString());
    } on DioException catch (e) {
      if (e.response != null) {
        log('Dio error: ${e.response!.statusCode}');
        log(e.response!.data.toString());
      } else {
        log('Error sending request!');
        log('${e.message}');
      }
      return;
    }
  }

  /// 프린터 인쇄 작업
  Future<void> printQueue(String filePath) async {
    if (!_isTokenAndDeviceIdExist) {
      log('Token 데이터가 없습니다.');
      return;
    }

    final file = File(filePath);
    if (!file.existsSync()) {
      log('No file found at path: $filePath');
      return;
    }

    final fileName = file.uri.pathSegments.last.split('.').first;
    final fileExtension =
        file.uri.pathSegments.last.split('.').last.toLowerCase();

    final Map<String, String> jobData = {
      'job_name': fileName,
      'print_mode': getFileType(fileExtension).$1,
    };

    // 설정 작업
    final jobResponse = await createPrintJob(jobData);
    if (jobResponse == null) return;

    final Map<String, dynamic> jobBody = jobResponse.data;
    final String jobId = jobBody['id'];
    final String baseUri = jobBody['upload_uri'];

    // 파일 업로드 작업
    final uploadResponse = await uploadPrintFile(file, baseUri);
    if (uploadResponse == null) return;

    // 인쇄 작업
    final printResponse = await executePrintJob(jobId);
    if (printResponse == null) return;

    log('Print executed successfully');
  }

  /// 프린터 정보 가져오기
  Future<Response?> getDeviceInfo() async {
    try {
      final response = await _dio.get(
        header: _commonHeader,
        endPoint: '/api/1/printing/printers/$_subjectId',
      );
      log(response.toString());
      return response;
    } catch (e) {
      log('Faild get device: $e');
      return null;
    }
  }

  Future<Response?> createPrintJob(Map<String, String> jobData) async {
    log('Create--------------------------------------------------------');
    try {
      final response = await _dio.post(
        uri: 'https://$_host/api/1/printing/printers/$_subjectId/jobs',
        parameter: json.encode(jobData),
        header: _commonHeader,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else {
        log('Job creation failed: ${response.statusCode}');
        log(response.data);
        return null;
      }
    } catch (e) {
      log('Error during job creation: $e');
      return null;
    }
  }

  Future<Response?> uploadPrintFile(File file, String baseUri) async {
    log('Upload--------------------------------------------------------');

    // final String fileName = file.path.split('/').last;
    final String fileName =
        '1.${file.uri.pathSegments.last.split('.').last.toLowerCase()}';
    final String uploadUri = '$baseUri&File=$fileName';

    log('fileName : $fileName');
    log('UploadURI : $uploadUri');
    log('fileSize : ${file.lengthSync().toString()}');

    final Map<String, String> uploadHeaders = {
      'Content-Length': file.lengthSync().toString(),
      'Content-Type':
          getFileType(file.uri.pathSegments.last.split('.').last.toLowerCase())
              .$2,
    };

    try {
      final response = await _dio.post(
        uri: uploadUri,
        parameter: file.openRead(),
        header: Options(headers: uploadHeaders),
      );

      if (response.statusCode == HttpStatus.ok) {
        return response;
      } else {
        log('File upload failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error during file upload: $e');
      return null;
    }
  }

  Future<Response?> executePrintJob(String jobId) async {
    log('Excute--------------------------------------------------------');
    try {
      final response = await _dio.post(
        uri:
            'https://$_host/api/1/printing/printers/$_subjectId/jobs/$jobId/print',
        parameter: json.encode({}),
        header: _commonHeader,
      );

      return response;
    } catch (e) {
      log('Error during print execution: $e');
      return null;
    }
  }
}
