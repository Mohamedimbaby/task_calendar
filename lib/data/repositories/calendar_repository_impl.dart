import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../datasources/calendar_data_source.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarDataSource dataSource;

  CalendarRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<CalendarEvent>>> getEventsForDate(
      DateTime date) async {
    try {
      final events = await dataSource.getEventsForDate(date);
      return Right(events);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addEvent(CalendarEvent event) async {
    try {
      final result = await dataSource.addEvent(event);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateEvent(CalendarEvent event) async {
    try {
      final result = await dataSource.updateEvent(event);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteEvent(String eventId) async {
    try {
      final result = await dataSource.deleteEvent(eventId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
