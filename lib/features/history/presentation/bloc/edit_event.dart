part of 'edit_bloc.dart';

@immutable
sealed class EditEvent {}

class EditUserEvent extends EditEvent {
  final String id;
  final String firstName;
  final String lastName;
  final String service;
  final String price;
  final String status;
  final DateTime date;

  EditUserEvent({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.service,
    required this.price,
    required this.status,
    required this.date,
  });
}
