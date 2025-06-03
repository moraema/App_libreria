import 'package:libreria/features/add_book/domain/entities/book.dart';
import 'package:libreria/features/add_book/domain/repositories/add_book_repository.dart';

class AddBookUseCase {
  final AddBookRepository repository;

  AddBookUseCase(this.repository);

  Future<bool> call(Book book, String token) async {
    return await repository.addBook(book, token);
  }
}