import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:epson_app/services/epson/scan_type.dart';

import '../../env/env_constant.dart';

final class EpsonService {
  static final Dio _dio = Dio();

  // ignore: constant_identifier_names
  static const _HOST = Env.hostName;
  // ignore: constant_identifier_names
  static const String _CLIENT_ID = Env.clientID;
  // ignore: constant_identifier_names
  static const String _SECRET = Env.clientSecretID;
  // ignore: constant_identifier_names
  static const String _DEVICE = 'swjtwin@naver.com';

  /// deviceID
  static String _subjectId = '';
  static String _accessToken = '';

  static bool get _isTokenAndDeviceIdExist =>
      (_subjectId.isEmpty || _accessToken.isEmpty) ? false : true;

  /// subjectID, accessToken 값 생성
  static Future<void> initAuth() async {
    // Authentication
    const String authUri =
        'https://$_HOST/api/1/printing/oauth2/auth/token?subject=printer';
    final String auth = base64Encode(utf8.encode('$_CLIENT_ID:$_SECRET'));

    log('AUTH : $auth');

    final Map<String, String> authHeaders = {
      'Authorization': 'Basic $auth',
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };
    final Map<String, String> queryParams = {
      'grant_type': 'password',
      'username': _DEVICE,
      'password': '',
    };

    Response authResponse;
    try {
      authResponse = await _dio.post(
        authUri,
        options: Options(headers: authHeaders),
        data: queryParams,
      );
    } catch (e) {
      log('Error during authentication: $e');
      return;
    }

    if (authResponse.statusCode != HttpStatus.ok) {
      log('Authentication failed: ${authResponse.statusCode}');
      log(authResponse.data);
      return;
    }

    final Map<String, dynamic> authBody = authResponse.data;

    log('AuthBODY : $authBody');

    _subjectId = authBody['subject_id'] ?? '';
    _accessToken = authBody['access_token'] ?? '';
  }

  /// Scan Method
  static scanQueue() async {
    if (!_isTokenAndDeviceIdExist) {
      log('Token 데이터가 없습니다.');
      return;
    }

    try {
      // 스캔 등록하기
      final String addUri =
          'https://$_HOST/api/1/scanning/scanners/$_subjectId/destinations';

      final Map<String, dynamic> dataParam = {
        'alias_name': 'ScanTitle',
        'type': ScanType.mail.name,
        'destination': 'swjtwin@naver.com'
      };

      final Response addResponse = await _dio.post(
        addUri,
        data: jsonEncode(dataParam),
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json;charset=utf-8',
          },
        ),
      );

      if (addResponse.statusCode != HttpStatus.ok) {
        log('Register scan destination failed: ${addResponse.statusCode}');
        log(addResponse.data.toString());
        exit(1);
      }

      log('2. Register scan destination: ----------------------');
      log(addUri);
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
      exit(1);
    }
  }

  static printQueue() async {
    if (!_isTokenAndDeviceIdExist) {
      log('Token 데이터가 없습니다.');
      return;
    }

    // Create print job
    final String jobUri =
        'https://$_HOST/api/1/printing/printers/$_subjectId/jobs';

    final Map<String, String> jobHeaders = {
      'Authorization': 'Bearer $_accessToken',
      'Content-Type': 'application/json;charset=utf-8',
    };

    final Map<String, String> jobData = {
      'job_name': 'SampleJob1',
      'print_mode': 'document',
    };

    Response jobResponse;
    try {
      jobResponse = await _dio.post(
        jobUri,
        options: Options(headers: jobHeaders),
        data: json.encode(jobData),
      );
    } catch (e) {
      log('Error during job creation: $e');
      exit(1);
    }

    if (jobResponse.statusCode != HttpStatus.created) {
      log('Job creation failed: ${jobResponse.statusCode}');
      log(jobResponse.data);
      exit(1);
    }

    final Map<String, dynamic> jobBody = jobResponse.data;
    final String jobId = jobBody['id'];
    final String baseUri = jobBody['upload_uri'];

    // Upload print file
    const String localFilePath = './SampleDoc.pdf';
    final File file = File(localFilePath);
    final String fileName = '1${file.uri.pathSegments.last.split('.').last}';
    final String uploadUri = '$baseUri&File=$fileName';

    final Map<String, String> uploadHeaders = {
      'Content-Length': file.lengthSync().toString(),
      'Content-Type': 'application/octet-stream',
    };

    Response uploadResponse;
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(localFilePath, filename: fileName),
      });

      uploadResponse = await _dio.post(
        uploadUri,
        data: formData,
        options: Options(headers: uploadHeaders),
      );
    } catch (e) {
      log('Error during file upload: $e');
      exit(1);
    }

    if (uploadResponse.statusCode != HttpStatus.ok) {
      log('File upload failed: ${uploadResponse.statusCode}');
      exit(1);
    }

    // Execute print
    final String printUri =
        'https://$_HOST/api/1/printing/printers/$_subjectId/jobs/$jobId/print';

    final Map<String, String> printHeaders = {
      'Authorization': 'Bearer $_accessToken',
      'Content-Type': 'application/json; charset=utf-8',
    };

    Response printResponse;
    try {
      printResponse = await _dio.post(
        printUri,
        options: Options(headers: printHeaders),
        data: json.encode({}),
      );
    } catch (e) {
      log('Error during print execution: $e');
      exit(1);
    }

    if (printResponse.statusCode != HttpStatus.ok) {
      log('Print execution failed: ${printResponse.statusCode}');
      log(printResponse.data);
      exit(1);
    }

    log('Print executed successfully');
  }
}
