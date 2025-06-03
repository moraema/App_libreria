import 'package:libreria/features/edit_book/domain/entities/book.dart';
import 'package:libreria/features/edit_book/domain/repositories/update_book_repository.dart';

class UpdateBookUseCase {
  final UpdateBookRepository repository;

  UpdateBookUseCase(this.repository);

  Future<bool> call(String id, Book book, String token) async {
    return await repository.updateBook(id, book, token);
  }
}