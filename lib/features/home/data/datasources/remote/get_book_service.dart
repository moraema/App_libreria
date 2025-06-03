import 'package:dio/dio.dart';
import 'package:libreria/core/network/dio_client.dart';
import 'package:libreria/features/home/data/models/book_model.dart';


class BookService {
  final DioClient dioClient;

  BookService(this.dioClient);

  Future<List<BookModel>> getBooks(String token, String userId) async {
    try {
      final response = await dioClient.get(
        '/books/user/$userId',
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'] as List;
        return data.map((json) => BookModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } on DioException {
      return [];
    }
  }
}