import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jinhe_client/utils/database.dart';
import 'package:loggy/loggy.dart';

Future<void> main() async {
  setUpAll(() async {
    // This is safe because [getApplicationSupportDirectory]
    // will return a test directory in the test environment.
    await initDatabase(
      clear: true,
      forceDefaultInit: true,
    );
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('log', () {
    expect(LogLevel.values.contains(log.level_), isTrue);
    expect(LogLevel.values.contains(log.stackTraceLevel_), isTrue);
    expect(log.levels, LogLevel.values.map((e) => e.name));
  });

  test('theme', () async {
    theme
      ..primary = Colors.white
      ..secondary = Colors.white
      ..surface = Colors.white
      ..background = Colors.white;

    expect(theme.onPrimary, Colors.black);
    expect(theme.onSecondary, Colors.black);
    expect(theme.onSurface, Colors.black);
    expect(theme.onBackground, Colors.black);
  });

  test('reflexive', () {
    expect(LogAdapter(), LogAdapter());
    expect(ThemeAdapter(), ThemeAdapter());

    expect(LogAdapter().hashCode, LogAdapter().hashCode);
    expect(ThemeAdapter().hashCode, ThemeAdapter().hashCode);
  });
}
