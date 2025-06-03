import 'package:dio/dio.dart';
import 'package:libreria/core/network/dio_client.dart';
import 'package:libreria/features/register/data/models/user_model.dart';

class RegisterService {
  final DioClient dioClient;

  RegisterService(this.dioClient);

  Future<bool> register(UserModel user) async {
    try {
      final response = await dioClient.post(
        '/users/register',
        data: user.toJson(),
      );
      
      if (response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;
        return data['message'] == 'success';
      }
      return false;
    } on DioException {
      return false;
    }
  }
}
