import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libreria/features/home/domain/usecases/get_book_use_case.dart';
import 'package:libreria/features/home/presentation/cubit/get_book_state.dart';

class GetBooksCubit extends Cubit<GetBooksState> {
  final GetBooksUseCase useCase;

  GetBooksCubit({required this.useCase}) : super(GetBooksInitial());

  Future<void> getBooks(String token, String userId) async {
    emit(GetBooksLoading());
    try {
      final books = await useCase(token, userId);
      emit(GetBooksLoaded(books));
    } catch (e) {
      emit(GetBooksFailure(e.toString()));
    }
  }
}