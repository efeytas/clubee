import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clubbee/models/event.dart';
import 'package:clubbee/models/chapter.dart';
import 'package:clubbee/views/home/event_card.dart';

void main() {
  testWidgets('_EventCardButtons test', (WidgetTester tester) async {
    // Create a test Event object
    final Event testEvent = Event(
      id: 1,
      name: 'Test Event',
      description: 'This is a test event',
      dateTime: '2023-01-01',
      chapterId: 1,
      eventStatus: active,
      highlighted: true,
    );

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: _EventCardButtons(
            event: testEvent,
            eventDate: testEvent.dateTime,
            isAlreadyJoined: false,
          ),
        ),
      ),
    );

    // Verify that the "Join Event" button is displayed
    expect(find.text('Join Event'), findsOneWidget);

    // Tap the button
    await tester.tap(find.byType(_EventCardButtons));
    await tester.pump();

    // Verify that the circular progress indicator is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
