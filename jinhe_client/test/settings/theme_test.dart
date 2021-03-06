import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jinhe_client/settings/theme.dart';
import 'package:jinhe_client/utils/database.dart';

void main() {
  setUpAll(() async {
    await initDatabase(clear: true);
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('theme', () {
    expect(appTheme.colorScheme.onBackground, Colors.white);

    theme
      ..background = Colors.white
      ..save();
    expect(appTheme.colorScheme.onBackground, Colors.black);
  });
}
