import 'package:libreria/features/login/data/datasources/remote/login_service.dart';
import 'package:libreria/features/login/data/models/login_user_model.dart';
import 'package:libreria/features/login/domain/entities/login_user.dart';
import 'package:libreria/features/login/domain/entities/session.dart';
import 'package:libreria/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginService service;

  LoginRepositoryImpl(this.service);

  @override
  Future<Session?> login(LoginUser user) async {
    final userModel = LoginUserModel(email: user.email, password: user.password);
    return await service.login(userModel);
  }
}