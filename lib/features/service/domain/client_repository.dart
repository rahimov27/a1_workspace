import 'package:a1_workspace/features/service/data/models/client_record_model.dart';

abstract class ClientRepository {
  Future<List<ClientRecordModel>> createClientRecord(
      String firstName,
      String lastName,
      String phone,
      String service,
      String price,
      String status,
      DateTime date);
}
