import 'package:libreria/features/register/domain/entities/user.dart';
import 'package:libreria/features/register/domain/repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository repository;

  RegisterUseCase(this.repository);

  Future<bool> call(User user) async {
    return await repository.registerUser(user);
  }
}
