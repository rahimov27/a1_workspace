import 'package:a1_workspace/features/calendar/data/models/calendar_model.dart';
import 'package:dio/dio.dart';

abstract class CalendarRemoteDatasource {
  Future<List<CalendarModel>> getCalendarRecords();
}

class CalendarRemoteDatasourceImpl extends CalendarRemoteDatasource {
  final Dio dio;
  CalendarRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<CalendarModel>> getCalendarRecords() async {
    try {
      final response = await dio.get("http://172.20.10.10:8000/api/clients/");
      print(response.data);
      if (response.statusCode == 200) {
        final List records = response.data;
        return records.map((record) => CalendarModel.fromJson(record)).toList();
      } else {
        throw Exception("Unexpected response: ${response.statusCode}");
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        throw Exception("Dio error: ${dioError.response?.data}");
      } else {
        throw Exception("Dio error: ${dioError.message}");
      }
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}
