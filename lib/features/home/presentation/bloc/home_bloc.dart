import 'package:a1_workspace/features/home/domain/home_repository.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<GetRecordsEvent>(
      (event, emit) async {
        emit(GetRecordsLoading());
        try {
          final records = await repository.getRecords();
          if (records.isNotEmpty) {
            emit(GetRecordsSuccess(records: records)); // Передаем данные
          } else {
            emit(GetRecordsError(error: 'No records found'));
          }
        } catch (e) {
          emit(GetRecordsError(error: e.toString()));
        }
      },
    );
  }
}
