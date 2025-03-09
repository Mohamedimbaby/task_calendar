import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../cubits/calendar/calendar_cubit.dart';

class DateCellsWidget extends StatelessWidget {
  const DateCellsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Use watch to rebuild when the cubit state changes
    final calendarState = context.watch<CalendarCubit>().state;
    final daysInMonth = _getDaysInVisibleMonth(calendarState.displayedMonth);

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysInMonth.length,
        itemBuilder: (context, index) {
          final date = daysInMonth[index];
          final isSelected = _isSameDay(date, calendarState.selectedDate);
          final dayFormat = DateFormat('d');
          final dayOfWeekFormat = DateFormat('E');

          return GestureDetector(
            onTap: () => context.read<CalendarCubit>().selectDate(date),
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.black : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayOfWeekFormat.format(date).toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dayFormat.format(date),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<DateTime> _getDaysInVisibleMonth(DateTime month) {
    // Get all days in the month
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    List<DateTime> days = [];

    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(month.year, month.month, i));
    }
    return days;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
