// client_event.dart
abstract class ClientEvent {}

class CreateClientRecordEvent extends ClientEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String service;
  final String price; // Новое поле для цены
  final String status; // Новое поле для статуса

  CreateClientRecordEvent({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.service,
    required this.price, // Добавлено в конструктор
    required this.status, // Добавлено в конструктор
  });
}
