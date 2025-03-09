import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/calendar_event.dart';
import '../../cubits/events/events_cubit.dart';
import '../../cubits/events/events_state.dart';
import 'event_card_widget.dart';

class EventTimelineWidget extends StatelessWidget {
  final DateTime selectedDate;

  const EventTimelineWidget({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        if (state.status == EventsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == EventsStatus.failure) {
          return Center(
            child: Text('Error: ${state.errorMessage ?? "Unknown error"}'),
          );
        }

        if (state.events.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'No events for this day',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          );
        }

        // Sort events by start time
        final events = List.of(state.events)
          ..sort((a, b) => a.startTime.compareTo(b.startTime));

        // Group events by hour for timeline display
        final groupedEvents = _groupEventsByHour(events);
        final hours = groupedEvents.keys.toList()..sort();

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: hours.length,
          itemBuilder: (context, index) {
            final hour = hours[index];
            final timeFormat = DateFormat('h a');
            final formattedHour = timeFormat.format(
              DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                hour,
              ),
            );

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      formattedHour,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Divider(height: 32, color: Colors.grey.shade300),
                      ...groupedEvents[hour]!
                          .map((event) => EventCardWidget(event: event)),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Map<int, List<CalendarEvent>> _groupEventsByHour(List<CalendarEvent> events) {
    final Map<int, List<CalendarEvent>> grouped = {};

    for (final event in events) {
      final hour = event.startTime.hour;
      if (!grouped.containsKey(hour)) {
        grouped[hour] = [];
      }
      grouped[hour]!.add(event);
    }

    return grouped;
  }
}
