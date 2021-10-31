import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jinhe/settings/theme.dart';
import 'package:jinhe/utils/database.dart';

void main() {
  setUpAll(() async {
    await initDatabase(clear: true);
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('theme', () => expect(appTheme.colorScheme.onBackground, Colors.white));
}
