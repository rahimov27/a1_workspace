class HomeRecordsModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String service;
  final String date;

  HomeRecordsModel({
    required this.firstName,
    required this.id,
    required this.service,
    required this.date,
    required this.lastName,
    required this.phone,
  });

  factory HomeRecordsModel.fromJson(Map<String, dynamic> json) {
    return HomeRecordsModel(
      firstName: json['first_name'] ?? "Неизвестно",
      id: json['id']?.toString() ?? "0",
      lastName: json['last_name'] ?? "Неизвестно",
      phone: json['phone'] ?? "Нет номера",
      service: json['service'] ?? "Не указан",
      date: json['date'] ?? "Нет даты",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "service": service,
      "date": date,
    };
  }
}
