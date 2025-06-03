import 'package:libreria/features/home/domain/entities/book.dart';
import 'package:libreria/features/home/data/datasources/remote/get_book_service.dart';
import 'package:libreria/features/home/domain/repositories/get_book_repository.dart';

class BookRepositoryImpl implements GetBookRepository {
  final BookService service;

  BookRepositoryImpl(this.service);

  @override
  Future<List<Book>> getBooks(String token, String userId) async {
    return await service.getBooks(token, userId);
  }
}
