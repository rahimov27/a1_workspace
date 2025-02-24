import 'package:a1_workspace/features/home/data/models/home_records_model.dart';
import 'package:a1_workspace/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:a1_workspace/features/home/domain/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource remoteDatasource;

  HomeRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<HomeRecordsModel>> getRecords() async {
    try {
      final result = await remoteDatasource.getRecords();
      return result;
    } catch (e) {
      throw Exception("Error in repository impl getRecords: $e");
    }
  }

  @override
  Future<void> deleteRecord(String id) async {
    try {
      await remoteDatasource
          .deleteRecord(id); // Just await without returning anything
    } catch (e) {
      throw Exception("Error in delete method in repo impl $e");
    }
  }
}
