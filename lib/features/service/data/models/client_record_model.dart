class ClientRecordModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String service;
  final String? date; // Делаем поле date nullable

  ClientRecordModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.service,
    this.date, // также делаем его nullable в конструкторе
  });

  factory ClientRecordModel.fromJson(Map<String, dynamic> json) {
    return ClientRecordModel(
      id: json['id'].toString(),
      firstName:
          json['first_name'] ?? '', // Если null, подставляем пустую строку
      lastName: json['last_name'] ?? '', // Если null, подставляем пустую строку
      phone: json['phone'] ?? '', // Если null, подставляем пустую строку
      service: json['service'] ?? '', // Если null, подставляем пустую строку
      date: json['date'], // Если дата отсутствует, она может быть null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'service': service,
      'date': date, // Здесь можно оставить null, если поле не обязательно
    };
  }
}
