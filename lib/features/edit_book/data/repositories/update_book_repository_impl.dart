import 'package:libreria/features/edit_book/data/datasource/remote/update_book_service.dart';
import 'package:libreria/features/edit_book/data/models/book_model.dart';
import 'package:libreria/features/edit_book/domain/entities/book.dart';
import 'package:libreria/features/edit_book/domain/repositories/update_book_repository.dart';

class UpdateBookRepositoryImpl implements UpdateBookRepository {
  final UpdateBookService service;

  UpdateBookRepositoryImpl(this.service);

  @override
  Future<bool> updateBook(String id, Book book, String token) async {
    final bookModel = BookModel(
      titulo: book.titulo,
      autor: book.autor,
      fechaPublicacion: book.fechaPublicacion,
      categoria: book.categoria,
      descripcion: book.descripcion,
      cantidad: book.cantidad,
      ubicacion: book.ubicacion,
      imagenUrl: book.imagenUrl,
    );

    return await service.updateBook(id, bookModel, token);
  }
}