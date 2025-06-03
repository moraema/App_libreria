import 'package:dio/dio.dart';
import 'package:libreria/core/network/dio_client.dart';
import 'package:libreria/features/add_book/data/models/book_model.dart';

class AddBookService {
  final DioClient dioClient;

  AddBookService(this.dioClient);

  Future<bool> addBook(BookModel book, String token) async {
    try {
      final response = await dioClient.post(
        '/books',
        data: book.toJson(),
        options: Options(headers: {'authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Erro al crear libro');
        }
    } on DioException {
      return false;
    }
  }
}
