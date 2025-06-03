import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libreria/core/services/local_storage_service.dart';
import 'package:libreria/features/login/domain/entities/login_user.dart';
import 'package:libreria/features/login/domain/usecases/login_use_case.dart';
import 'package:libreria/features/login/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final LocalStorageService localStorageService;

  LoginCubit({required this.loginUseCase, required this.localStorageService})
      : super(LoginInitial());

  Future<void> login(LoginUser user) async {
    emit(LoginLoading());
    try {
      final session = await loginUseCase(user);
      if (session != null) {
        await localStorageService.saveSession(session.token, session.id);
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Credenciales inválidas"));
      }
    } catch (e) {
      emit(LoginFailure("Ocurrió un error: ${e.toString()}"));
    }
  }
}