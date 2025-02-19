import 'package:a1_workspace/features/home/data/models/home_records_model.dart';
import 'package:a1_workspace/shared/core/utils/swagger_adress.dart';
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
      final response = await dio.get(SwaggerAdress.adress,
          options: Options(headers: {"Authorization": SwaggerAdress.apiKey}));
      if (response.statusCode == 200) {
        final List records = response.data;
        return records
            .map((record) => HomeRecordsModel.fromJson(record))
            .toList();
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
