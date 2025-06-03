import 'package:libreria/features/register/domain/entities/user.dart';

abstract class RegisterRepository {
  Future<bool> registerUser(User user);
}
