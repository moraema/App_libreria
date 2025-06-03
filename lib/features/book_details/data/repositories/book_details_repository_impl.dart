import 'package:libreria/features/book_details/data/datasources/remote/book_delete_service.dart';
import 'package:libreria/features/book_details/data/datasources/remote/book_details_service.dart';
import 'package:libreria/features/book_details/domain/entities/book.dart';
import 'package:libreria/features/book_details/domain/repositories/book_details_repository.dart';

class GetBookDetailsRepositoryImpl implements BookDetailsRepository {
  final GetBookDetailsService service;
  final DeleteBookService deleteService;

  GetBookDetailsRepositoryImpl({
    required this.service,
    required this.deleteService,
  });

  @override
  Future<Book?> getBookDetails(String id, String token) async {
    return await service.getBookDetails(id, token);
  }

  @override
  Future<void> deleteBook(String id, String token) async {
    return await deleteService.deleteBook(id, token);
  }
}
