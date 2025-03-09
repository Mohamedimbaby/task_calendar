import 'package:flutter/material.dart';

class WeekDaysWidget extends StatelessWidget {
  const WeekDaysWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    return Row(
      children: days.map((day) {
        return Expanded(
          child: Container(
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              day,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
