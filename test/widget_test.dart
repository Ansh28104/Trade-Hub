import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradehub/main.dart';

void main() {
  testWidgets('TradeHub smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TradeHubApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
