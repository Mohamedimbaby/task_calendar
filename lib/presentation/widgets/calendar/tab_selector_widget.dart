import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/calendar/calendar_cubit.dart';
import '../../cubits/calendar/calendar_state.dart';

class TabSelectorWidget extends StatelessWidget {
  const TabSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      buildWhen: (previous, current) =>
          previous.selectedTab != current.selectedTab,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: _TabItem(
                  title: 'Schedule',
                  isSelected: state.selectedTab == CalendarTab.schedule,
                  onTap: () => context
                      .read<CalendarCubit>()
                      .changeTab(CalendarTab.schedule),
                ),
              ),
              Expanded(
                child: _TabItem(
                  title: 'Task',
                  isSelected: state.selectedTab == CalendarTab.task,
                  onTap: () =>
                      context.read<CalendarCubit>().changeTab(CalendarTab.task),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
