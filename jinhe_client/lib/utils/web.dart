import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:loggy/loggy.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

final cookieJar = CookieJar();
final hiveCacheStore = HiveCacheStore(null);
final options = CacheOptions(
  store: hiveCacheStore,
  policy: CachePolicy.forceCache,
);

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
    DioCacheInterceptor(options: options),
  ]);

/// Should be reassigned in and only in test code.
var dio = defaultDio;

extension Launch on String {
  void launch() => launcher.launch(this);
}

const _repo = 'CCXXXI/jinhe-bus-routes-client';

class Api {
  static const releases = 'https://api.github.com/repos/$_repo/releases';

  static const jinhe = 'http://101.35.25.41/jinhe';
  static const version = '$jinhe/meta/version';
}

class Url {
  static const _gh = 'https://github.com';

  static const latest = '$_gh/$_repo/releases/latest';

  static String version(String v) => '$_gh/$_repo/releases/tag/v$v';
  static const issues = '$_gh/$_repo/issues';
}

Future<bool> checkDataVer() async {
  final String oldVer = (await dio.get(Api.version)).data;
  final String newVer = (await dio.get(
    Api.version,
    options:
        options.copyWith(policy: CachePolicy.refreshForceCache).toOptions(),
  ))
      .data;

  if (oldVer != newVer) {
    logInfo('New data version: $oldVer -> $newVer');
    hiveCacheStore.clean();
    return true;
  }
  return false;
}
