import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libreria/features/register/domain/entities/user.dart';
import 'package:libreria/features/register/domain/usecases/register_use_case.dart';
import 'package:libreria/features/register/presentation/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUserUseCase;

  RegisterCubit({required this.registerUserUseCase}) : super(RegisterInitial());

  Future<void> register(User user) async {
    emit(RegisterLoading());
    try {
      final success = await registerUserUseCase(user);
      if (success) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure("Error al registrar usuario"));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}