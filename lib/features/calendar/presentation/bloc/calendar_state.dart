import 'package:a1_workspace/features/calendar/data/models/calendar_model.dart';

abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class GetRecordsCalendarLoading extends CalendarState {}

class GetRecordsCalendarSuccess extends CalendarState {
  final List<CalendarModel> records;
  GetRecordsCalendarSuccess({required this.records});
}

class GetRecordsCalendarError extends CalendarState {
  final String error;
  GetRecordsCalendarError({required this.error});
}
