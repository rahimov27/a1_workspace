import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'История',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SfCalendar(
          minDate: DateTime(2024, 1, 1, 1),
          showDatePickerButton: true,
          headerDateFormat: "MMMM yyy",
          todayTextStyle: const TextStyle(
            fontFamily: "sf",
            fontSize: 20,
          ),
          todayHighlightColor: Colors.transparent,
          headerStyle: const CalendarHeaderStyle(
            backgroundColor: Colors.transparent,
            textStyle: TextStyle(
                fontSize: 18, color: AppColors.mainWhite, fontFamily: "sf"),
          ),
          view: CalendarView.schedule,
          backgroundColor: Colors.black,
          scheduleViewSettings: const ScheduleViewSettings(
            appointmentItemHeight: 70,
            monthHeaderSettings: MonthHeaderSettings(
              monthTextStyle: TextStyle(fontFamily: "sf", fontSize: 18),
              textAlign: TextAlign.start,
              height: 60,
              backgroundColor: Colors.black,
            ),
            weekHeaderSettings: WeekHeaderSettings(
              backgroundColor: Colors.black,
            ),
            appointmentTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          dataSource: MeetingDataSource(_getDataSource()),
        ),
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 1));
    meetings.add(Meeting('Тонировка', startTime, endTime, Colors.blue, false));
    meetings.add(Meeting('Химчистка', startTime.add(const Duration(hours: 4)),
        endTime.add(const Duration(hours: 4)), Colors.green, false));
    meetings.add(Meeting('Полировка', startTime.add(const Duration(hours: 7)),
        endTime.add(const Duration(hours: 7)), Colors.purple, false));
    return meetings;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
