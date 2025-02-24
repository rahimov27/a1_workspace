import 'package:a1_workspace/features/home/data/models/home_records_model.dart';

abstract class HomeRepository {
  Future<List<HomeRecordsModel>> getRecords();
  Future<void> deleteRecord(String id);
}
