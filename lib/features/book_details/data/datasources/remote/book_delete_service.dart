import 'package:dio/dio.dart';
import 'package:libreria/core/network/dio_client.dart';

class DeleteBookService {
  final DioClient dioClient;

  DeleteBookService(this.dioClient);

  Future<void> deleteBook(String id, String token) async {
    try {
      final response = await dioClient.delete(
        '/books/$id',
        options: Options(headers: {
          'authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception("Error al eliminar el libro. Código: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Error de red: ${e.message}");
    }
  }
}
