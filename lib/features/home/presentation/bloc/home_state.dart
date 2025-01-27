import 'package:a1_workspace/features/home/data/models/home_records_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetRecordsLoading extends HomeState {}

class GetRecordsSuccess extends HomeState {
  final List<HomeRecordsModel> records;
  GetRecordsSuccess({required this.records});
}

class GetRecordsError extends HomeState {
  final String error;
  GetRecordsError({required this.error});
}

