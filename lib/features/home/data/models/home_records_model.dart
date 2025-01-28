class HomeRecordsModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String service;
  final String date;
  HomeRecordsModel(
      {required this.firstName,
      required this.id,
      required this.service,
      required this.date,
      required this.lastName,
      required this.phone});

  factory HomeRecordsModel.fromJson(Map<String, dynamic> json) {
    return HomeRecordsModel(
        firstName: json['first_name'],
        id: json['id'].toString(),
        lastName: json['last_name'],
        phone: json['phone'],
        service: json['service'],
        date: json['date']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "service": service,
      "date": date
    };
  }
}
