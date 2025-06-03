import 'package:libreria/features/register/data/datasources/remote/register_service.dart';
import 'package:libreria/features/register/data/models/user_model.dart';
import 'package:libreria/features/register/domain/entities/user.dart';
import 'package:libreria/features/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterService service;

  RegisterRepositoryImpl(this.service);

  @override
  Future<bool> registerUser(User user) async {
    final userModel = UserModel(name: user.name, email: user.email, password: user.password);
    return await service.register(userModel);
  }
}