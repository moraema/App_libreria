import 'package:libreria/features/login/domain/entities/login_user.dart';
import 'package:libreria/features/login/domain/entities/session.dart';
import 'package:libreria/features/login/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Session?> call(LoginUser user) async {
    return await repository.login(user);
  }
}