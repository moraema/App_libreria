
import 'package:libreria/features/register/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required String name, required String email, required String password})
      : super(name: name, email: email, password: password);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        password: json['password'],
      );
}
