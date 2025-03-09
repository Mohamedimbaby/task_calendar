import 'package:equatable/equatable.dart';

enum CalendarView { month, week, day }

enum CalendarTab { schedule, task }

class CalendarState extends Equatable {
  final DateTime selectedDate;
  final DateTime displayedMonth;
  final CalendarView view;
  final CalendarTab selectedTab;
  final bool isLoading;
  final String? errorMessage;

  const CalendarState({
    required this.selectedDate,
    required this.displayedMonth,
    this.view = CalendarView.month,
    this.selectedTab = CalendarTab.schedule,
    this.isLoading = false,
    this.errorMessage,
  });

  CalendarState copyWith({
    DateTime? selectedDate,
    DateTime? displayedMonth,
    CalendarView? view,
    CalendarTab? selectedTab,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      displayedMonth: displayedMonth ?? this.displayedMonth,
      view: view ?? this.view,
      selectedTab: selectedTab ?? this.selectedTab,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        selectedDate,
        displayedMonth,
        view,
        selectedTab,
        isLoading,
        errorMessage,
      ];
}
