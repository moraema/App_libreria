import 'package:libreria/features/book_details/domain/entities/book.dart';

class BookModel extends Book {
  BookModel({
    required String id,
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
          id: id,
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

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      titulo: json['titulo'],
      autor: json['autor'],
      fechaPublicacion: json['fecha_publicacion'],
      categoria: json['categoria'],
      descripcion: json['descripcion'],
      cantidad: json['cantidad'],
      ubicacion: json['ubicacion'],
      imagenUrl: json['imagen_url'],
      idUser: json['id_user'],
    );
  }
}
