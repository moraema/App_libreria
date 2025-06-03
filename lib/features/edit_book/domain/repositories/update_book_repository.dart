import 'package:libreria/features/edit_book/domain/entities/book.dart';

abstract class UpdateBookRepository {
  Future<bool> updateBook(String id, Book book, String token);
}