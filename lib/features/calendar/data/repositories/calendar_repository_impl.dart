import 'package:a1_workspace/features/calendar/data/datasources/remote/calendar_remote_datasource.dart';
import 'package:a1_workspace/features/calendar/data/models/calendar_model.dart';
import 'package:a1_workspace/features/calendar/domain/calendar_repository.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarRemoteDatasource remoteDatasource;

  CalendarRepositoryImpl({required this.remoteDatasource});

 
  
  @override
  Future<List<CalendarModel>> getCalendarRecords()async {
    try {
      final result = await remoteDatasource.getCalendarRecords();
      return result;
    } catch (e) {
      throw Exception("Error in repository impl getRecords: $e");
    }
  }
  
 
}
