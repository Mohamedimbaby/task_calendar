import 'package:equatable/equatable.dart';
import '../../../domain/entities/calendar_event.dart';

enum EventsStatus { initial, loading, success, failure }

class EventsState extends Equatable {
  final List<CalendarEvent> events;
  final EventsStatus status;
  final String? errorMessage;

  const EventsState({
    this.events = const [],
    this.status = EventsStatus.initial,
    this.errorMessage,
  });

  EventsState copyWith({
    List<CalendarEvent>? events,
    EventsStatus? status,
    String? errorMessage,
  }) {
    return EventsState(
      events: events ?? this.events,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [events, status, errorMessage];
}
