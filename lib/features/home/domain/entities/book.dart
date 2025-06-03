class Book {
  final String id;
  final String titulo;
  final String autor;
  final String fechaPublicacion;
  final String categoria;
  final String descripcion;
  final int cantidad;
  final String ubicacion;
  final String imagenUrl;
  final String idUser;

  Book({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.fechaPublicacion,
    required this.categoria,
    required this.descripcion,
    required this.cantidad,
    required this.ubicacion,
    required this.imagenUrl,
    required this.idUser,
  });
}
