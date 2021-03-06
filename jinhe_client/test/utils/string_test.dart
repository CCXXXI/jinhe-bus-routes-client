import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jinhe_client/utils/string.dart';
import 'package:quiver/pattern.dart';

const _num = r'(0|[1-9]\d*)';
final _semVer = RegExp('$_num\\.$_num\\.$_num');

void main() {
  test('PanGu', () => expect('测试test'.s.s.s, '测试 test'));

  group('package info', () {
    test(
      'appName',
      () => expect(appName, '金河查'),
    );
    test(
      'packageName',
      () => expect(packageName, 'io.github.ccxxxi.jinhe_client'),
    );
    test(
      'version',
      () => expect(matchesFull(_semVer, version), isTrue),
    );
    test(
      'buildNumber',
      () => expect(matchesFull(RegExp(_num), buildNumber), isTrue),
    );
  });

  testWidgets('license', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Placeholder()));
    await initMessages();
    expect(license.startsWith('MIT License'), isTrue);
  });
}
