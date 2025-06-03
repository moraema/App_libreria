import 'package:dio/dio.dart';
import 'package:libreria/core/network/dio_client.dart';
import 'package:libreria/features/edit_book/data/models/book_model.dart';

class UpdateBookService {
  final DioClient dioClient;

  UpdateBookService(this.dioClient);

  Future<bool> updateBook(String id, BookModel book, String token) async {
    try {
      final response = await dioClient.patch(
        '/books/$id',
        data: book.toJson(),
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        return true;
       } else {
        throw Exception('Erro al crear libro');
        }
    } on DioException {
      return false;
    }
  }
}