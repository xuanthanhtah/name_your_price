import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:name_your_price/pages/home_page.dart';

void main() {
  group('Home page test', () {
    Finder checkBtn() => find.text('Check');
    Finder nextBtn() => find.text('Next');
    Finder priceInput() => find.byKey(const Key('priceInput'));

    testWidgets('Click next interate over the product list',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));

      expect(find.text(products[0].name), findsOneWidget);

      for (int i = 1; i < products.length; i++) {
        await tester.tap(checkBtn());
        await tester.enterText(priceInput(), '0');
        await tester.pump();
        await tester.tap(nextBtn());
        await tester.pump();
        expect(find.text(products[i].name), findsOneWidget);
      }

      await tester.tap(checkBtn());
      await tester.pump();
      expect(find.text(products[products.length - 1].name), findsOneWidget);
    });

    testWidgets('Check result and show next product',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));

      expect(nextBtn(), findsNothing);
      expect(find.byKey(const Key('result')), findsNothing);
      await tester.enterText(priceInput(), '1300');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(find.byKey(const Key('result')), findsOneWidget);
      expect(find.text('pass'), findsOneWidget);

      await tester.tap(nextBtn());
      await tester.pump();

      expect(nextBtn(), findsNothing);
      expect(find.byKey(const Key('result')), findsNothing);
      await tester.enterText(priceInput(), '1900');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(find.byKey(const Key('result')), findsOneWidget);
      expect(find.text('fail'), findsOneWidget);

      await tester.enterText(priceInput(), '1400');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(find.text('pass'), findsOneWidget);
    });
  });
}
