import 'package:libreria/features/edit_book/domain/entities/book.dart';

class BookModel extends Book {
  BookModel({
    required String titulo,
    required String autor,
    required String fechaPublicacion,
    required String categoria,
    required String descripcion,
    required int cantidad,
    required String ubicacion,
    required String imagenUrl,
  }) : super(
          titulo: titulo,
          autor: autor,
          fechaPublicacion: fechaPublicacion,
          categoria: categoria,
          descripcion: descripcion,
          cantidad: cantidad,
          ubicacion: ubicacion,
          imagenUrl: imagenUrl,
        );

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'autor': autor,
        'fecha_publicacion': fechaPublicacion,
        'categoria': categoria,
        'descripcion': descripcion,
        'cantidad': cantidad,
        'ubicacion': ubicacion,
        'imagen_url': imagenUrl,
      };
}