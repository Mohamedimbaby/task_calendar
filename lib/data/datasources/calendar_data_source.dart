import '../models/calendar_event_model.dart';
import '../../domain/entities/calendar_event.dart';

abstract class CalendarDataSource {
  Future<List<CalendarEvent>> getEventsForDate(DateTime date);
  Future<bool> addEvent(CalendarEvent event);
  Future<bool> updateEvent(CalendarEvent event);
  Future<bool> deleteEvent(String eventId);
}

class MockCalendarDataSource implements CalendarDataSource {
  final Map<String, List<CalendarEventModel>> _mockData = {};

  MockCalendarDataSource() {
    // Initialize with sample data for today and tomorrow
    final DateTime today = DateTime.now();
    final todayKey = _dateToKey(today);

    _mockData[todayKey] = [
      CalendarEventModel(
        id: '1',
        title: 'Sprint Review Period 02 in May 2022',
        startTime: DateTime(today.year, today.month, today.day, 9, 0),
        endTime: DateTime(today.year, today.month, today.day, 10, 0),
        type: EventType.review,
        description:
            'Review the progress made during the sprint with the team and stakeholders',
      ),
      CalendarEventModel(
        id: '2',
        title: 'Meeting with Client',
        startTime: DateTime(today.year, today.month, today.day, 11, 0),
        endTime: DateTime(today.year, today.month, today.day, 12, 0),
        type: EventType.meeting,
        description: 'Discuss project requirements and timeline',
      ),
      CalendarEventModel(
        id: '3',
        title: 'Daily Standup',
        startTime: DateTime(today.year, today.month, today.day, 14, 0),
        endTime: DateTime(today.year, today.month, today.day, 14, 30),
        type: EventType.standup,
        description: 'Quick team sync-up on progress and blockers',
      ),
    ];

    // Add some events for yesterday
    final DateTime yesterday = today.subtract(const Duration(days: 1));
    final yesterdayKey = _dateToKey(yesterday);

    _mockData[yesterdayKey] = [
      CalendarEventModel(
        id: '4',
        title: 'Team Building Activity',
        startTime:
            DateTime(yesterday.year, yesterday.month, yesterday.day, 15, 0),
        endTime:
            DateTime(yesterday.year, yesterday.month, yesterday.day, 17, 0),
        type: EventType.other,
        description: 'Virtual escape room with the development team',
      ),
    ];

    // Add events for tomorrow
    final DateTime tomorrow = today.add(const Duration(days: 1));
    final tomorrowKey = _dateToKey(tomorrow);

    _mockData[tomorrowKey] = [
      CalendarEventModel(
        id: '5',
        title: 'Product Demo',
        startTime: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0),
        endTime: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 11, 0),
        type: EventType.meeting,
        description: 'Present the latest features to the product team',
      ),
      CalendarEventModel(
        id: '6',
        title: 'Code Review',
        startTime: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 13, 0),
        endTime: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 14, 0),
        type: EventType.review,
        description: 'Review PR #256: New authentication flow',
      ),
    ];
  }

  String _dateToKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  @override
  Future<List<CalendarEvent>> getEventsForDate(DateTime date) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final key = _dateToKey(date);
    return _mockData[key] ?? [];
  }

  @override
  Future<bool> addEvent(CalendarEvent event) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final model = CalendarEventModel(
      id: event.id,
      title: event.title,
      startTime: event.startTime,
      endTime: event.endTime,
      type: event.type,
      description: event.description,
    );

    final key = _dateToKey(event.startTime);
    if (!_mockData.containsKey(key)) {
      _mockData[key] = [];
    }

    _mockData[key]!.add(model);
    return true;
  }

  @override
  Future<bool> updateEvent(CalendarEvent event) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final key = _dateToKey(event.startTime);
    if (!_mockData.containsKey(key)) {
      return false;
    }

    final index = _mockData[key]!.indexWhere((e) => e.id == event.id);
    if (index == -1) {
      return false;
    }

    final model = CalendarEventModel(
      id: event.id,
      title: event.title,
      startTime: event.startTime,
      endTime: event.endTime,
      type: event.type,
      description: event.description,
    );

    _mockData[key]![index] = model;
    return true;
  }

  @override
  Future<bool> deleteEvent(String eventId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    for (final key in _mockData.keys) {
      final index = _mockData[key]!.indexWhere((e) => e.id == eventId);
      if (index != -1) {
        _mockData[key]!.removeAt(index);
        return true;
      }
    }

    return false;
  }
}
