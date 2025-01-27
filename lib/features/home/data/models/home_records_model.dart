class HomeRecordsModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  HomeRecordsModel(
      {required this.firstName,
      required this.id,
      required this.lastName,
      required this.phone});

  factory HomeRecordsModel.fromJson(Map<String, dynamic> json) {
    return HomeRecordsModel(
      firstName: json['first_name'],
      id: json['id'].toString(),
      lastName: json['last_name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone
    };
  }
}
