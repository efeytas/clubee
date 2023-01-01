import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:clubbee/services/api_sevices.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  MockApiServices mockApiServices;
  _ParticipatedEventsPageState participatedEventsPage;

  setUp(() {
    mockApiServices = MockApiServices();
    participatedEventsPage = _ParticipatedEventsPageState();
  });

  test('Test successful retrieval of participated events', () async {
    final List<Event> dummyEvents = [
      Event(id: '1', name: 'Event 1'),
      Event(id: '2', name: 'Event 2'),
      Event(id: '3', name: 'Event 3'),
    ];
    when(mockApiServices.getParticipatedEvents(any)).thenAnswer((_) => Future.value(dummyEvents));
    await participatedEventsPage._getData();
    expect(participatedEventsPage.participated_events, isNotEmpty);
    expect(participatedEventsPage.participated_events.length, dummyEvents.length);
  });

  test('Test error while retrieving participated events', () async {
    when(mockApiServices.getParticipatedEvents(any)).thenThrow(Exception());
    await participatedEventsPage._getData();
    expect(participatedEventsPage.participated_events, isEmpty);
    expect(participatedEventsPage._isLoading, isFalse);
  });
}
