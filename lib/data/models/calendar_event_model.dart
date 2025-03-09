import '../../domain/entities/calendar_event.dart';

class CalendarEventModel extends CalendarEvent {
  CalendarEventModel({
    required super.id,
    required super.title,
    required super.startTime,
    required super.endTime,
    required super.type,
    super.description,
  });

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
