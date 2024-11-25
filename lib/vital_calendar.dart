import 'package:flutter/material.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/models/day_values_model.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';

import 'flow_tracking_dialog.dart';

class VitalCalendar extends StatefulWidget {
  const VitalCalendar({super.key});

  @override
  State<VitalCalendar> createState() => _VitalCalendarState();
}

class _VitalCalendarState extends State<VitalCalendar> {
  late CleanCalendarController calendarController;
  final DateTime today = DateTime.now();
  final List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  void initializeController() {
    calendarController = CleanCalendarController(
      initialFocusDate: today,
      initialDateSelected: today,
      minDate: today.subtract(const Duration(days: 3650)),
      maxDate: today.add(const Duration(days: 90)),
      rangeMode: false,
      onDayTapped: (date) {
        if (date.isSameDayOrBefore(today)) {
          setState(() {
            selectedDate = date;
          });
          showPeriodFlowDialog(
              context, selectedDate); // Invoke the dialog function with context
        }
      },
    );
  }

  void refreshCalendar() {
    setState(() {
      selectedDate = today;
      initializeController();
    });
  }

  void showPeriodFlowDialog(BuildContext context, DateTime selectedDate) async {
    final result = await showDialog<int>(
      context: context,
      builder: (context) => FlowTrackingDialog(selectedDate: selectedDate,),
    );

    if (result != null) {
      // Handle selected flow
      print('Selected Flow: $result');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: Colors.indigo[50],
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: weekdays
                      .map((day) => Expanded(
                            child: Center(
                              child: Text(
                                day,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            SliverFillRemaining(
              child: ScrollableCleanCalendar(
                calendarController: calendarController,
                layout: Layout.DEFAULT,
                showWeekdays: false,
                monthBuilder: (context, month) => buildMonth(month),
                dayBuilder: (context, dates) => buildDay(dates, selectedDate),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            shape: const CircleBorder(),
            splashColor: Colors.indigo[100],
            onPressed: () {
              calendarController.jumpToMonth(date: today);
              refreshCalendar(); // Trigger full refresh
            },
            backgroundColor: Colors.indigo[50],
            child: const Icon(Icons.today),
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

  Container buildDay(DayValues dates, DateTime selectedDate) {
    bool isFuture = dates.day.isAfter(today);
    bool isToday = dates.day.isSameDay(today);
    bool isSelected = dates.day.isSameDay(selectedDate) && !isFuture;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isToday
            ? Colors.indigo.shade50 // Light indigo for today
            : Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isSelected ? Colors.grey.shade500 : Colors.transparent,
          width: 2, // Border for selected days
        ),
      ),
      child: Text(
        '${dates.day.day}',
        style: TextStyle(
          fontSize: isToday ? 18 : 16,
          // Slightly larger font for today
          color: isFuture ? Colors.grey.shade400 : Colors.black,
          // Grey out future dates
          fontWeight:
              isSelected || isToday ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
