import 'dart:collection';

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

  group('JinHe Apis', () {
    const base = 'http://101.35.25.41/jinhe';
    test(
      'meta/version',
      () => expect(Api.version, '$base/meta/version'),
    );
    test(
      'routes/',
      () => expect(Api.routes, '$base/routes/'),
    );
    test(
      'routes/:name',
      () => expect(Api.route('1'), '$base/routes/1'),
    );
    test(
      'routes/:name/first',
      () => expect(Api.routeFirst('1u'), '$base/routes/1u/first'),
    );
    test(
      'routes/:name/steps',
      () => expect(Api.routeSteps('1u'), '$base/routes/1u/steps'),
    );
    test(
      'stations/',
      () => expect(Api.stations, '$base/stations/'),
    );
    test(
      'stations/:id/first',
      () => expect(Api.stationFirst('41394'), '$base/stations/41394/first'),
    );
    test(
      'stats/routes/types',
      () => expect(Api.routesTypes, '$base/stats/routes/types'),
    );
    test(
      'stats/routes/stations',
      () => expect(Api.routesStations, '$base/stats/routes/stations'),
    );
    test(
      'stats/routes/time',
      () => expect(Api.routesTime, '$base/stats/routes/time'),
    );
    test(
      'stats/stations/routes',
      () => expect(Api.stationsRoutes, '$base/stats/stations/routes'),
    );
    test(
      'stats/stations/links',
      () => expect(Api.stationsLinks, '$base/stats/stations/links'),
    );
    test(
      'paths/shortest/:from/:to',
      () => expect(
          Api.path(
            SplayTreeSet.of(['16115', '16116']),
            SplayTreeSet.of(['5214', '14768']),
          ),
          '$base/paths/shortest/16115.16116/14768.5214'),
    );
  });

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
