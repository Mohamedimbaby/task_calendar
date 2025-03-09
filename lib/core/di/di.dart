import 'package:get_it/get_it.dart';
import 'package:task_1/data/repositories/auth_repository_impl.dart';
import 'package:task_1/domain/repositories/auth_repository.dart';
import 'package:task_1/presentation/cubits/login/login_cubit.dart';
import '../../data/datasources/calendar_data_source.dart';
import '../../data/repositories/calendar_repository_impl.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../../presentation/cubits/calendar/calendar_cubit.dart';
import '../../presentation/cubits/events/events_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );

  // Cubits
  getIt.registerFactory(
    () => LoginCubit(authRepository: getIt<AuthRepository>()),
  );

  // Calendar dependencies
  getIt.registerLazySingleton<CalendarDataSource>(
    () => MockCalendarDataSource(),
  );

  getIt.registerLazySingleton<CalendarRepository>(
    () => CalendarRepositoryImpl(getIt<CalendarDataSource>()),
  );

  getIt.registerFactory(
    () => CalendarCubit(),
  );

  getIt.registerFactory(
    () => EventsCubit(repository: getIt<CalendarRepository>()),
  );
}
