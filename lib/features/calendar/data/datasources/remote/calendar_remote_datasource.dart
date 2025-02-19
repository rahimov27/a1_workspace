import 'package:a1_workspace/features/calendar/data/models/calendar_model.dart';
import 'package:a1_workspace/shared/core/utils/swagger_adress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class CalendarRemoteDatasource {
  Future<List<CalendarModel>> getCalendarRecords();
}

class CalendarRemoteDatasourceImpl extends CalendarRemoteDatasource {
  final Dio dio;
  CalendarRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<CalendarModel>> getCalendarRecords() async {
    try {
      final response = await dio.get(SwaggerAdress.adress,
          options: Options(headers: {"Authorization": SwaggerAdress.apiKey}));
      if (kDebugMode) {
        print(response.data);
      }
      if (response.statusCode == 200) {
        final List records = response.data;
        return records.map((record) => CalendarModel.fromJson(record)).toList();
      } else {
        throw Exception("Unexpected response: ${response.statusCode}");
      }
    } on DioException catch (dioError) {
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
