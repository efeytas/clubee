import 'package:clubbee/global_parameters.dart';
import 'package:clubbee/models/event.dart';
import 'package:clubbee/views/home/event_card.dart';
import 'package:clubbee/views/home/home_page.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/src/widget_tester.dart';


void main() {
  test('checkForAlreadyJoined returns true if event is in appliedEvents list', () {
    late HomePageState sut;

    // Create an Event object
    final event = Event(
      id: 1,
      name: 'Test Event',
      description: 'This is a test event' ,
      dateTime: '2023-01-01',
      eventStatus: EventStatus.active,
      highlighted: true,
      chapterId: 1
      );
    
    // Create an appliedEvents list with the event object
    final appliedEvents = [event];
    
    // Create a HomePageState object
    final homePageState = HomePageState();
    
    // Call the checkForAlreadyJoined method
    final result = homePageState.checkForAlreadyJoined(event);
    
    // Assert that the result is true
    expect(result, isTrue);
  });
  
  test('checkForAlreadyJoined returns false if event is not in appliedEvents list', () {
    // Create an Event object
    final event = Event(id: 1,
      name: 'Test Event',
      description: 'This is a test event' ,
      dateTime: '2023-01-01',
      eventStatus: EventStatus.active,
      highlighted: true,
      chapterId: 1);
    
    // Create an empty appliedEvents list
    final appliedEvents = [];
    
    // Create a HomePageState object
    final homePageState = HomePageState();
    
    // Call the checkForAlreadyJoined method
    final result = homePageState.checkForAlreadyJoined(event);
    
    // Assert that the result is false
    expect(result, isFalse);
  });
}

