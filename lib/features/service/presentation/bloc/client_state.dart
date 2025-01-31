// client_state.dart
import 'package:a1_workspace/features/service/data/models/client_record_model.dart';

abstract class ClientState {}

class ClientInitial extends ClientState {}

class ClientRecordLoading extends ClientState {}

class ClientRecordSuccess extends ClientState {
  final List<ClientRecordModel> records;

  ClientRecordSuccess({required this.records});
}

class ClientRecordError extends ClientState {
  final String error;

  ClientRecordError({required this.error});
}
