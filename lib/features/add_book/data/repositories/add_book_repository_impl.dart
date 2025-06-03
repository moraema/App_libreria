import 'package:libreria/features/add_book/data/datasources/remote/add_book_service.dart';
import 'package:libreria/features/add_book/data/models/book_model.dart';
import 'package:libreria/features/add_book/domain/entities/book.dart';
import 'package:libreria/features/add_book/domain/repositories/add_book_repository.dart';

class AddBookRepositoryImpl implements AddBookRepository {
  final AddBookService service;

  AddBookRepositoryImpl(this.service);

  @override
  Future<bool> addBook(Book book, String token) async {
    final bookModel = BookModel(
      titulo: book.titulo,
      autor: book.autor,
      fechaPublicacion: book.fechaPublicacion,
      categoria: book.categoria,
      descripcion: book.descripcion,
      cantidad: book.cantidad,
      ubicacion: book.ubicacion,
      imagenUrl: book.imagenUrl,
      idUser: book.idUser,
    );

    return await service.addBook(bookModel, token);
  }
}