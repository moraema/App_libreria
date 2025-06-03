import 'package:libreria/features/home/domain/entities/book.dart';
import 'package:libreria/features/home/domain/repositories/get_book_repository.dart';

class GetBooksUseCase {
  final GetBookRepository repository;

  GetBooksUseCase(this.repository);

  Future<List<Book>> call(String token, String userId) async {
    return await repository.getBooks(token, userId);
  }
}