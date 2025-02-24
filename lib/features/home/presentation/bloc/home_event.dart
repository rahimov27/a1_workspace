abstract class HomeEvent {}

class GetRecordsEvent extends HomeEvent {}

class DeleteRecordEvent extends HomeEvent {
  final String id;

  DeleteRecordEvent({required this.id});

  List<Object?> get props => [id];
}
