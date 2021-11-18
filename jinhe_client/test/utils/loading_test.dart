import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jinhe_client/utils/loading.dart';

void main() {
  testWidgets('loading', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Loading())));

    expect(find.byType(IconButton), findsOneWidget);

    for (int i = 0; i != 1024; ++i) {
      await tester.tap(find.byType(IconButton));
      await tester.pump();
      expect(find.byType(IconButton), findsOneWidget);
    }
  });
}
