import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:humanresources/app/models/person_model.dart';

import 'package:humanresources/app/person/person/person_page.dart';

main() {
  testWidgets('PersonPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(PersonPage(Person())));
    final titleFinder = find.text('Human Resources - Add/Edit People');
    expect(titleFinder, findsOneWidget);
  });
}
