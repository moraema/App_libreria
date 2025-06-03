import 'package:libreria/features/home/domain/entities/book.dart';

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

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json['id'] as String,
        titulo: json['titulo'] as String,
        autor: json['autor'] as String,
        fechaPublicacion: json['fecha_publicacion'] as String,
        categoria: json['categoria'] as String,
        descripcion: json['descripcion'] as String,
        cantidad: json['cantidad'] as int,
        ubicacion: json['ubicacion'] as String,
        imagenUrl: json['imagen_url'] as String,
        idUser: json['id_user'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
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