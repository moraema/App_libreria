import 'package:dio/dio.dart';
import 'package:libreria/core/network/dio_client.dart';
import 'package:libreria/features/login/data/models/login_user_model.dart';
import 'package:libreria/features/login/data/models/session_model.dart';

class LoginService {
  final DioClient dioClient;

  LoginService(this.dioClient);

  Future<SessionModel?> login(LoginUserModel user) async {
    try {
      final response = await dioClient.authenticate(
        '/users/login', 
        data: user.toJson()
        );
        
      if (response.statusCode == 200) {
        return SessionModel.fromJson(response.data);
      }
      return null;
    } on DioException {
      return null;
    }
  }
}