import 'package:a1_workspace/shared/core/utils/swagger_adress.dart';
import 'package:dio/dio.dart';
import 'package:a1_workspace/features/service/data/models/client_record_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  final FlutterSecureStorage _storage =
      FlutterSecureStorage(); // Added storage for access token

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
      final token = await _storage.read(key: "access_token");
      if (token == null) {
        throw Exception("Access token is missing.");
      }

      // Make API request to create client record
      final response = await dio.post(
        "${SwaggerAdress.adress}/", // Ensure the URL is correct
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'service': service,
          'price': price,
          'status': status == "В процессе"
              ? "in_progress"
              : (status == "Завершено" ? "completed" : "pending"),
          'date': date.toIso8601String(),
        },
        options: Options(headers: {
          "Authorization": "Bearer $token"
        }), // Add Bearer token in headers
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
