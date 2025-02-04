import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:a1_workspace/features/calendar/data/models/calendar_model.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          "Календарь",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "sf",
            color: AppColors.mainWhite,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            if (state is GetRecordsCalendarLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetRecordsCalendarSuccess) {
              return SfCalendar(
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
                      fontSize: 18, color: Colors.white, fontFamily: "sf"),
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
                dataSource: MeetingDataSource(state.records),
              );
            } else if (state is GetRecordsCalendarError) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<CalendarModel> source) {
    appointments = source
        .map((e) => Meeting(
              e.service,
              _parseDate(e.date), // Парсим дату
              _parseDate(e.date).add(const Duration(hours: 1)),
              Colors.blue,
              false,
            ))
        .toList();
  }

  static DateTime _parseDate(String dateStr) {
    try {
      return DateTime.parse(dateStr).toLocal(); // Преобразуем время в локальное
    } catch (e) {
      print('Ошибка парсинга даты: $dateStr');
      return DateTime.now(); // Используем текущее время по умолчанию
    }
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

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
}
