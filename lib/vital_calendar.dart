import 'package:flutter/material.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/models/day_values_model.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';

class VitalCalendar extends StatelessWidget {
  const VitalCalendar({super.key});

  @override
  Widget build(BuildContext context) {

    final DateTime today = DateTime.now();

    final CleanCalendarController calendarController = CleanCalendarController(
      initialFocusDate: today,
      initialDateSelected: today,
      minDate: today.subtract(Duration(days: (365 * 12))),
      maxDate: today.add(Duration(days: 365)),
      rangeMode: false,
      onDayTapped: (date) {
        // TODO
      },
    );

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: Colors.indigo[50],
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Center(child: Text('Mon', style: TextStyle(fontWeight: FontWeight.bold)))),
                Expanded(child: Center(child: Text('Tue', style: TextStyle(fontWeight: FontWeight.bold)))),
                Expanded(child: Center(child: Text('Wed', style: TextStyle(fontWeight: FontWeight.bold)))),
                Expanded(child: Center(child: Text('Thu', style: TextStyle(fontWeight: FontWeight.bold)))),
                Expanded(child: Center(child: Text('Fri', style: TextStyle(fontWeight: FontWeight.bold)))),
                Expanded(child: Center(child: Text('Sat', style: TextStyle(fontWeight: FontWeight.bold)))),
                Expanded(child: Center(child: Text('Sun', style: TextStyle(fontWeight: FontWeight.bold)))),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: ScrollableCleanCalendar(
            calendarController: calendarController,
            layout: Layout.DEFAULT,
            showWeekdays: false,
            monthBuilder: (context, month) {
              return buildMonth(month);
            },
            dayBuilder: (context, dates) {
              return buildDay(dates, today);
            },
          ),
        ),
      ],
    );
  }

  Column buildMonth(String month) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(thickness: 1, color: Colors.grey[350]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '${month}',
              style: TextStyle(
                color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(thickness: 1, color: Colors.grey[350]),
        ],
      );
  }

  Container buildDay(DayValues dates, DateTime today) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: dates.isSelected ? Colors.grey.shade500 : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          '${dates.day.day}',
          style: TextStyle(
            fontSize: dates.isSelected ? 18 : 16,
            color: dates.day.isSameDayOrBefore(today) ? Colors.black : DefaultSelectionStyle.defaultColor,
            fontWeight: dates.isSelected ? FontWeight.bold : FontWeight.normal
          ),
        ),
      );
  }
}
