import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libreria/features/book_details/domain/usecases/delete_book_use_case.dart';
import 'package:libreria/features/book_details/presentation/cubit/book_delete_state.dart';

class DeleteBookCubit extends Cubit<DeleteBookState> {
  final DeleteBookUseCase useCase;

  DeleteBookCubit({required this.useCase}) : super(DeleteBookInitial());

  Future<void> deleteBook(String id, String token) async {
    emit(DeleteBookLoading());
    try {
      await useCase(id, token);
      emit(DeleteBookSuccess());
    } catch (e) {
      emit(DeleteBookFailure(e.toString()));
    }
  }
}
