import 'package:dio/dio.dart';
import 'package:libreria/core/network/dio_client.dart';
import 'package:libreria/features/book_details/data/models/book_details_model.dart';

class GetBookDetailsService {
  final DioClient dioClient;

  GetBookDetailsService(this.dioClient);

  Future<BookModel?> getBookDetails(String id, String token) async {
    try {
      final response = await dioClient.get(
        '/books/$id',
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['data'] != null && responseData['data'] is List) {
          final books = responseData['data'] as List;
          if (books.isNotEmpty) {
            return BookModel.fromJson(books[0]);
          }
        }
      }
      return null;
    } on DioException {
      return null;
    }
  }
}