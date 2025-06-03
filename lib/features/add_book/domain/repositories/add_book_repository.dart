import 'package:libreria/features/add_book/domain/entities/book.dart';

abstract class AddBookRepository {
  Future<bool> addBook(Book book, String token);
}