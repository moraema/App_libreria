import 'package:libreria/features/login/domain/entities/login_user.dart';
import 'package:libreria/features/login/domain/entities/session.dart';

abstract class LoginRepository {
  Future<Session?> login(LoginUser user);
}