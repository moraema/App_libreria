import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libreria/features/edit_book/domain/entities/book.dart';
import 'package:libreria/features/edit_book/domain/usecase/update_book_use_case.dart';
import 'package:libreria/features/edit_book/presentation/cubit/book_update_state.dart';

class UpdateBookCubit extends Cubit<UpdateBookState> {
  final UpdateBookUseCase useCase;

  UpdateBookCubit({required this.useCase}) : super(UpdateBookInitial());

  Future<void> updateBook(String id, Book book, String token) async {
    emit(UpdateBookLoading());
    try {
      final success = await useCase(id, book, token);
      if (success) {
        emit(UpdateBookSuccess());
      } else {
        emit(UpdateBookFailure("No se pudo actualizar el libro"));
      }
    } catch (e) {
      emit(UpdateBookFailure(e.toString()));
    }
  }
}