import 'package:flutter_bloc/flutter_bloc.dart';
import 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit()
      : super(
          CalendarState(
            selectedDate: DateTime.now(),
            displayedMonth: DateTime.now(),
          ),
        );

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void changeMonth(DateTime month) {
    emit(state.copyWith(displayedMonth: month));
  }

  void nextMonth() {
    final nextMonth = DateTime(
      state.displayedMonth.year,
      state.displayedMonth.month + 1,
      1,
    );
    emit(state.copyWith(displayedMonth: nextMonth));
  }

  void previousMonth() {
    final previousMonth = DateTime(
      state.displayedMonth.year,
      state.displayedMonth.month - 1,
      1,
    );
    emit(state.copyWith(displayedMonth: previousMonth));
  }

  void changeView(CalendarView view) {
    emit(state.copyWith(view: view));
  }

  void changeTab(CalendarTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
}
