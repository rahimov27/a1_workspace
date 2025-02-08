// client_event.dart
abstract class ClientEvent {}

class CreateClientRecordEvent extends ClientEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String service;
  final String price;
  final String status;
  final DateTime date;

  CreateClientRecordEvent({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.service,
    required this.price,
    required this.status,
    required this.date,
  });
}
