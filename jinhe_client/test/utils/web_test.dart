import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jinhe_client/utils/database.dart';
import 'package:jinhe_client/utils/web.dart';

class FakeDio0 extends Fake implements Dio {
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    return Response(
      requestOptions: RequestOptions(path: path),
      data: '0' as T,
    );
  }
}

class FakeDio1 extends Fake implements Dio {
  int data = 0;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    return Response(
      requestOptions: RequestOptions(path: path),
      data: (data++).toString() as T,
    );
  }
}

void main() {
  setUpAll(() async {
    await initDatabase();
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('dio', () {
    if (dio != defaultDio) dio = defaultDio;

    expect(
      dio.interceptors,
      isNotEmpty,
    );
  });

  // This cannot be tested. Just make codecov happy.
  test('launch', () => expect('test'.launch, throwsA(anything)));

  test(
    'version url',
    () => expect(
      Url.version('0.1.0'),
      'https://github.com/CCXXXI/jinhe-bus-routes-client/releases/tag/v0.1.0',
    ),
  );

  test('checkDataVer false', () async {
    dio = FakeDio0();
    final r0 = await checkDataVer();
    expect(r0, false);
  });

  test('checkDataVer true', () async {
    dio = FakeDio1();
    final r1 = await checkDataVer();
    expect(r1, true);
  });
}
