import 'package:libreria/features/book_details/domain/entities/book.dart';

abstract class BookDetailsRepository {
  Future<Book?> getBookDetails(String id, String token);
  Future<void> deleteBook(String id, String token);
}
