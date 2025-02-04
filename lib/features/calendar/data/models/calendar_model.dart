class CalendarModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String service;
  final String date;
  final String price;
  final String status;

  CalendarModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.service,
    required this.date,
    required this.price,
    required this.status,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      id: json['id']?.toString() ?? "0",
      firstName: json['first_name'] ?? "Неизвестно",
      lastName: json['last_name'] ?? "Неизвестно",
      phone: json['phone'] ?? "Нет номера",
      service: json['service'] ?? "Не указан",
      date: json['date'] ?? "Нет даты",
      price: json['price']?.toString() ?? "0",
      status: json['status'] ?? "Неизвестно",
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
      "price": price,
      "status": status,
    };
  }
}
