import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/calendar_event.dart';

abstract class CalendarRepository {
  Future<Either<Failure, List<CalendarEvent>>> getEventsForDate(DateTime date);
  Future<Either<Failure, bool>> addEvent(CalendarEvent event);
  Future<Either<Failure, bool>> updateEvent(CalendarEvent event);
  Future<Either<Failure, bool>> deleteEvent(String eventId);
}
