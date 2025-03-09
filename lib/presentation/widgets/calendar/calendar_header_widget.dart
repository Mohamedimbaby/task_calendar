import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../cubits/calendar/calendar_cubit.dart';
import '../../cubits/calendar/calendar_state.dart';
import 'month_picker_sheet.dart';

class CalendarHeaderWidget extends StatelessWidget {
  const CalendarHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarCubit = context.watch<CalendarCubit>();

    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) =>
          previous.displayedMonth != current.displayedMonth,
      builder: (context, state) {
        final monthYearFormat = DateFormat('MMMM yyyy');
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _showMonthPicker(
                      context, state.displayedMonth, calendarCubit);
                },
                child: Row(
                  children: [
                    Text(
                      monthYearFormat.format(state.displayedMonth),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => calendarCubit.previousMonth(),
                    iconSize: 30,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => calendarCubit.nextMonth(),
                    iconSize: 30,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMonthPicker(BuildContext context, DateTime currentMonth,
      CalendarCubit calendarCubit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return BlocProvider.value(
          value: calendarCubit,
          child: MonthPickerSheet(
            initialDate: currentMonth,
            onMonthSelected: (DateTime newMonth) {
              calendarCubit.changeMonth(newMonth);
              // Also update the selected date to the first day of the month
              calendarCubit.selectDate(newMonth);
            },
          ),
        );
      },
    );
  }
}
