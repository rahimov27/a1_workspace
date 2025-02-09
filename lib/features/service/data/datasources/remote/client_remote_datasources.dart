// client_remote_datasources.dart
import 'package:a1_workspace/shared/core/utils/swagger_adress.dart';
import 'package:dio/dio.dart';
import 'package:a1_workspace/features/service/data/models/client_record_model.dart';

abstract class ClientRemoteDatasource {
  Future<List<ClientRecordModel>> createClientRecord(
    String firstName,
    String lastName,
    String phone,
    String service,
    String price,
    String status,
    DateTime date,
  );
}

class ClientRemoteDatasourceImpl extends ClientRemoteDatasource {
  final Dio dio;

  ClientRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<ClientRecordModel>> createClientRecord(
      String firstName,
      String lastName,
      String phone,
      String service,
      String price,
      String status,
      DateTime date) async {
    try {
      print({
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'service': service,
        'price': price, // Убедись, что это строка!
        'status': status,
        'date': date.toIso8601String(),
      });
      final response = await dio.post(
        options: Options(headers: {"Authorization": SwaggerAdress.apiKey}),
        SwaggerAdress.adress,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'service': service,
          'price': price, // Убедитесь, что price передается как строка
          'status': status == "В процессе"
              ? "in_progress"
              : (status == "Завершено" ? "completed" : "pending"),
          'date': date.toIso8601String(), // Дата в формате ISO 8601
        },
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> record = response.data;
        return [ClientRecordModel.fromJson(record)];
      } else {
        throw Exception("Unexpected response: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error in createClientRecord: $e");
    }
  }
}
