class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String role;

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] as int,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        role: json['role'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['role'] = this.role;
    return data;
  }
}
