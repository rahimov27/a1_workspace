import 'package:a1_workspace/features/home/data/models/home_records_model.dart';
import 'package:dio/dio.dart';

abstract class HomeRemoteDatasource {
  Future<List<HomeRecordsModel>> getRecords();
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final Dio dio;
  HomeRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<HomeRecordsModel>> getRecords() async {
    try {
      final response = await dio.get("http://127.0.0.1:8000/api/clients/");
      if (response.statusCode == 200) {
        print(response.data);
        final List records = response.data;
        return records
            .map((record) => HomeRecordsModel.fromJson(record))
            .toList();
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
