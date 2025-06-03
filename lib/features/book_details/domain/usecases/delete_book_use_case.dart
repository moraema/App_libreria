import 'package:libreria/features/book_details/domain/repositories/book_details_repository.dart';

class DeleteBookUseCase {
  final BookDetailsRepository repository;

  DeleteBookUseCase(this.repository);

  Future<void> call(String id, String token) async {
    return await repository.deleteBook(id, token);
  }
}
