import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libreria/features/add_book/domain/entities/book.dart';
import 'package:libreria/features/add_book/domain/usecases/add_book_use_case.dart';
import 'package:libreria/features/add_book/presentation/cubit/add_book_state.dart';

class AddBookCubit extends Cubit<AddBookState> {
  final AddBookUseCase useCase;

  AddBookCubit({required this.useCase}) : super(AddBookInitial());

  Future<void> addBook(Book book, String token) async {
    emit(AddBookLoading());
    try {
      final success = await useCase(book, token);
      if (success) {
        emit(AddBookSuccess());
      } else {
        emit(AddBookFailure("No se pudo agregar el libro"));
      }
    } catch (e) {
      emit(AddBookFailure(e.toString()));
    }
  }
}