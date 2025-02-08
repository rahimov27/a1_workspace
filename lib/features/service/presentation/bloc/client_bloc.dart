// client_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/client_repository.dart';
import 'client_event.dart';
import 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientRepository repository;

  ClientBloc({required this.repository}) : super(ClientInitial()) {
    on<CreateClientRecordEvent>((event, emit) async {
      emit(ClientRecordLoading());
      try {
        final records = await repository.createClientRecord(
          event.firstName,
          event.lastName,
          event.phone,
          event.service,
          event.price,
          event.status,
          event.date,
        );
        if (records.isNotEmpty) {
          emit(ClientRecordSuccess(records: records));
        } else {
          emit(ClientRecordError(error: 'Failed to create record'));
        }
      } catch (e) {
        emit(ClientRecordError(error: e.toString()));
      }
    });
  }
}
