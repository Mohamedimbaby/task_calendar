import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/core/theme/app_colors.dart';
import '../cubits/calendar/calendar_cubit.dart';
import '../cubits/calendar/calendar_state.dart';
import '../cubits/events/events_cubit.dart';
import '../widgets/calendar/calendar_header_widget.dart';
import '../widgets/calendar/date_cells_widget.dart';
import '../widgets/calendar/event_timeline_widget.dart';
import '../widgets/calendar/tab_selector_widget.dart';
import '../widgets/navigation/custom_bottom_nav.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../pages/project_summary_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late CalendarCubit _calendarCubit;
  int _currentNavIndex = 2; // Default to Calendar tab

  @override
  void initState() {
    super.initState();
    _calendarCubit = context.read<CalendarCubit>();
    // Load events for the selected date when the page initializes
    final selectedDate = _calendarCubit.state.selectedDate;
    context.read<EventsCubit>().getEventsForDate(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      appBar: AppBar(
        title: Text(_getAppBarTitle(context)),
        backgroundColor: AppColors.white,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  // Handle notification button press
                },
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 56,
        height: 56,
        child: FloatingActionButton(
          onPressed: () {
            // Add new event
          },
          shape: CircleBorder(),
          backgroundColor: AppColors.black,
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }

  String _getAppBarTitle(BuildContext context) {
    switch (_currentNavIndex) {
      case 0:
        return AppLocalizations.of(context)!.home;
      case 1:
        return AppLocalizations.of(context)!.projectSummary;
      case 2:
        return AppLocalizations.of(context)!.calendar;
      case 3:
        return AppLocalizations.of(context)!.profile;
      default:
        return 'Calendar App';
    }
  }

  Widget _buildBody() {
    switch (_currentNavIndex) {
      case 0:
        return Center(
          child: Text(
            'Not Implemented yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        );

      case 1:
        return const ProjectSummaryPage();

      case 2:
        // Calendar UI
        return Column(
          children: [
            BlocProvider.value(
              value: _calendarCubit,
              child: CalendarHeaderWidget(),
            ),
            BlocProvider.value(
              value: _calendarCubit,
              child: const DateCellsWidget(),
            ),
            BlocProvider.value(
              value: _calendarCubit,
              child: const TabSelectorWidget(),
            ),
            Expanded(
              child: BlocListener<CalendarCubit, CalendarState>(
                bloc: _calendarCubit,
                listenWhen: (previous, current) =>
                    previous.selectedDate != current.selectedDate,
                listener: (context, state) {
                  // When the selected date changes, fetch new events
                  context
                      .read<EventsCubit>()
                      .getEventsForDate(state.selectedDate);
                },
                child: BlocBuilder<CalendarCubit, CalendarState>(
                  bloc: _calendarCubit,
                  buildWhen: (previous, current) =>
                      previous.selectedTab != current.selectedTab ||
                      previous.selectedDate != current.selectedDate,
                  builder: (context, state) {
                    if (state.selectedTab == CalendarTab.schedule) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: EventTimelineWidget(
                            selectedDate: state.selectedDate,
                          ),
                        ),
                      );
                    } else {
                      // Task tab content
                      return const Center(
                        child: Text('Task view not implemented yet'),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );

      case 3:
        return Center(
          child: Text(
            'Not Implemented yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        );

      default:
        return Center(
          child: Text(
            'Not Implemented yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        );
    }
  }
}
