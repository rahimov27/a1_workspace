import 'package:a1_workspace/features/calendar/data/models/calendar_model.dart';

abstract class CalendarRepository {
  Future<List<CalendarModel>> getCalendarRecords();
}
