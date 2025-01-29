// client_event.dart
abstract class ClientEvent {}

class CreateClientRecordEvent extends ClientEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String service;

  CreateClientRecordEvent({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.service,
  });
}
