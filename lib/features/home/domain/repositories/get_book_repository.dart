import 'package:libreria/features/home/domain/entities/book.dart';

abstract class GetBookRepository {
  Future<List<Book>> getBooks(String token, String userId);
}