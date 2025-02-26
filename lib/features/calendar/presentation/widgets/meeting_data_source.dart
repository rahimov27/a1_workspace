import 'dart:math';
import 'package:a1_workspace/features/calendar/data/models/calendar_model.dart';
import 'package:a1_workspace/features/calendar/data/models/meeting.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<CalendarModel> source) {
    appointments = source
        .map((e) => Meeting(
              e.service,
              _parseDate(e.date), // Парсим дату
              _parseDate(e.date).add(const Duration(minutes: 1)),
              _getRandomColor(),
              false,
            ))
        .toList();
  }

  final Random random = Random();
  Color _getRandomColor() {
    return Color.fromRGBO(
      random.nextInt(128),
      random.nextInt(128),
      random.nextInt(128),
      1.44,
    );
  }

  static DateTime _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty || dateStr == "Нет даты") {
      return DateTime.now();
    }
    try {
      DateTime parsedDate = DateTime.parse(dateStr);
      print("Исходная дата с бэка: $dateStr");
      print("После парсинга: $parsedDate (isUtc: ${parsedDate.isUtc})");

      if (parsedDate.isUtc) {
        DateTime localDate = parsedDate;
        print("После преобразования в локальное: $localDate");
        return localDate;
      }

      return parsedDate;
    } catch (e) {
      print("Ошибка парсинга даты: $e");
      return DateTime.now();
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
