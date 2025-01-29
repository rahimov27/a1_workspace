class ClientRecordModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String service;
  final String date;

  ClientRecordModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.service,
    required this.date,
  });

  factory ClientRecordModel.fromJson(Map<String, dynamic> json) {
    return ClientRecordModel(
      id: json['id'].toString(),
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      service: json['service'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'service': service,
      'date': date,
    };
  }
}
