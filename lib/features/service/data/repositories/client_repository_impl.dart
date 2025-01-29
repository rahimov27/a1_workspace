import 'package:a1_workspace/features/service/data/datasources/remote/client_remote_datasources.dart';
import 'package:a1_workspace/features/service/data/models/client_record_model.dart';
import 'package:a1_workspace/features/service/domain/client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientRemoteDatasource remoteDatasource;

  ClientRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<ClientRecordModel>> createClientRecord(
      String firstName, String lastName, String phone, String service) async {
    try {
      final result = await remoteDatasource.createClientRecord(
        firstName, lastName, phone, service,
      );
      return result;
    } catch (e) {
      throw Exception("Error in ClientRepositoryImpl: $e");
    }
  }
}