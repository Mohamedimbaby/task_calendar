import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/calendar_repository.dart';
import 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  final CalendarRepository repository;

  EventsCubit({required this.repository}) : super(const EventsState());

  Future<void> getEventsForDate(DateTime date) async {
    emit(state.copyWith(status: EventsStatus.loading));

    final result = await repository.getEventsForDate(date);

    result.fold(
      (failure) => emit(state.copyWith(
        status: EventsStatus.failure,
        errorMessage: failure.message,
      )),
      (events) => emit(state.copyWith(
        status: EventsStatus.success,
        events: events,
      )),
    );
  }

  // Add more methods for adding, updating, and deleting events
}
