import '../../domain/entities/calendar_event.dart';

class CalendarEventModel extends CalendarEvent {
  CalendarEventModel({
    required String id,
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    required EventType type,
    String? description,
  }) : super(
          id: id,
          title: title,
          startTime: startTime,
          endTime: endTime,
          type: type,
          description: description,
        );

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) {
    return CalendarEventModel(
      id: json['id'],
      title: json['title'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      type: EventType.values.firstWhere(
        (e) => e.toString() == 'EventType.${json['type']}',
        orElse: () => EventType.other,
      ),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'type': type.toString().split('.').last,
      'description': description,
    };
  }
}
