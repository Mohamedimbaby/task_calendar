import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/calendar_event.dart';

class EventCardWidget extends StatelessWidget {
  final CalendarEvent event;

  const EventCardWidget({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('h:mm a');
    final startTime = timeFormat.format(event.startTime);
    final endTime = timeFormat.format(event.endTime);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: _getEventColor(event.type).withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [

        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: _getEventColor(event.type),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            event.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$startTime - $endTime',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getEventColor(EventType type) {
    switch (type) {
      case EventType.meeting:
        return Colors.blue;
      case EventType.review:
        return Colors.purple;
      case EventType.standup:
        return Colors.green;
      case EventType.other:
        return Colors.orange;
    }
  }

  String _getEventTypeText(EventType type) {
    switch (type) {
      case EventType.meeting:
        return 'Meeting';
      case EventType.review:
        return 'Review';
      case EventType.standup:
        return 'Standup';
      case EventType.other:
        return 'Other';
    }
  }
}
