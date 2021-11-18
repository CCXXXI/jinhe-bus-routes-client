import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:loggy/loggy.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

final cookieJar = CookieJar();

/// The default Dio instance used by all production code.
/// Test code may use a fake one.
final defaultDio = Dio()
  ..interceptors.addAll([
    LoggyDioInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      requestLevel: LogLevel.debug,
      responseLevel: LogLevel.debug,
    ),
    CookieManager(cookieJar),
  ]);

/// Should be reassigned in and only in test code.
var dio = defaultDio;

extension Launch on String {
  void launch() => launcher.launch(this);
}

const _repo = 'CCXXXI/jinhe-bus-routes-client';

class Api {
  static const releases = 'https://api.github.com/repos/$_repo/releases';
}

class Url {
  static const _gh = 'https://github.com';

  static const latest = '$_gh/$_repo/releases/latest';

  static String version(String v) => '$_gh/$_repo/releases/tag/v$v';
  static const issues = '$_gh/$_repo/issues';
}
