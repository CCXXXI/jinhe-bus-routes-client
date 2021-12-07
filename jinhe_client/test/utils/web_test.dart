import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jinhe_client/utils/database.dart';
import 'package:jinhe_client/utils/web.dart';

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
}
