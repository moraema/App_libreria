import 'package:libreria/features/login/domain/entities/login_user.dart';

class LoginUserModel extends LoginUser {
  LoginUserModel({required String email, required String password})
      : super(email: email, password: password);

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}