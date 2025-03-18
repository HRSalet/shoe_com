class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNo;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'phoneNo': phoneNo};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
    );
  }
}
