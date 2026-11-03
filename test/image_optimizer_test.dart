import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flgame/views/utils/ImageOptimizer.dart';

void main() {
  testWidgets('ImageOptimizer calculates cacheWidth and builds asset widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            final cacheWidth = ImageOptimizer.getCacheWidth(context, 150);
            expect(cacheWidth, greaterThan(0));

            return Scaffold(
              body: ImageOptimizer.assetWidget(
                context,
                'assets/L_Game_start_position.svg.png',
                width: 150,
                height: 150,
              ),
            );
          },
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('ImageOptimizer precacheAsset executes without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            ImageOptimizer.precacheAsset(
              context,
              'assets/L_Game_start_position.svg.png',
              logicalWidth: 150,
            );
            return const Scaffold(body: SizedBox());
          },
        ),
      ),
    );

    await tester.pump();
  });
}
