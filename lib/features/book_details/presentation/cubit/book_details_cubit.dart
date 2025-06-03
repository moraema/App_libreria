import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libreria/features/book_details/domain/usecases/book_details_use_case.dart';
import 'package:libreria/features/book_details/presentation/cubit/book_details_state.dart';



class GetBookDetailsCubit extends Cubit<GetBookDetailsState> {
  final GetBookDetailsUseCase useCase;

  GetBookDetailsCubit({required this.useCase}) : super(GetBookDetailsInitial());

  Future<void> getBookDetails(String id, String token) async {
    emit(GetBookDetailsLoading());
    try {
      final book = await useCase(id, token);
      if (book != null) {
        emit(GetBookDetailsLoaded(book));
      } else {
        emit(GetBookDetailsFailure("Libro no encontrado"));
      }
    } catch (e) {
      emit(GetBookDetailsFailure(e.toString()));
    }
  }
}