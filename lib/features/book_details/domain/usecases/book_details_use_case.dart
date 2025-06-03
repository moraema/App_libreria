import 'package:libreria/features/book_details/domain/entities/book.dart';
import 'package:libreria/features/book_details/domain/repositories/book_details_repository.dart';

class GetBookDetailsUseCase {
  final BookDetailsRepository repository;

  GetBookDetailsUseCase(this.repository);

  Future<Book?> call(String id, String token) async {
    return await repository.getBookDetails(id, token);
  }
}