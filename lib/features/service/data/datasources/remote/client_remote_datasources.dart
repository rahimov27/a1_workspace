// client_remote_datasources.dart
import 'package:dio/dio.dart';
import 'package:a1_workspace/features/service/data/models/client_record_model.dart';

abstract class ClientRemoteDatasource {
  Future<List<ClientRecordModel>> createClientRecord(
      String firstName, String lastName, String phone, String service);
}

class ClientRemoteDatasourceImpl extends ClientRemoteDatasource {
  final Dio dio;

  ClientRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<ClientRecordModel>> createClientRecord(
      String firstName, String lastName, String phone, String service) async {
    try {
      final response = await dio.post(
        "http://10.4.165.22:8000/api/clients/",
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'service': service,
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
