// calendar_bloc.dart
import 'package:a1_workspace/features/calendar/domain/calendar_repository.dart';
import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository repository;

  CalendarBloc({required this.repository}) : super(CalendarInitial()) {
    on<GetRecordsCalendarEvent>((event, emit) async {
      emit(GetRecordsCalendarLoading());
      try {
        final records = await repository.getCalendarRecords();
        emit(GetRecordsCalendarSuccess(records: records));
      } catch (e) {
        emit(GetRecordsCalendarError(error: e.toString()));
      }
    });
  }
}
