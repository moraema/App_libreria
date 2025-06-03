import 'package:libreria/features/add_book/domain/entities/book.dart';

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
    required String idUser,
  }) : super(
          titulo: titulo,
          autor: autor,
          fechaPublicacion: fechaPublicacion,
          categoria: categoria,
          descripcion: descripcion,
          cantidad: cantidad,
          ubicacion: ubicacion,
          imagenUrl: imagenUrl,
          idUser: idUser,
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
        'id_user': idUser,
      };
}