import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:libreria/core/router/domain/constants/router_constants.dart';
import 'package:libreria/core/services/local_storage_service.dart';
import 'package:libreria/features/book_details/domain/entities/book.dart';
import 'package:libreria/features/book_details/presentation/cubit/book_details_cubit.dart';
import 'package:libreria/features/book_details/presentation/cubit/book_details_state.dart';
import 'package:libreria/features/book_details/presentation/cubit/book_delete_cubit.dart';
import 'package:libreria/features/book_details/presentation/cubit/book_delete_state.dart';

class BookDetailsPage extends StatefulWidget {
  final String bookId;

  const BookDetailsPage({Key? key, required this.bookId}) : super(key: key);

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  final LocalStorageService _localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    _loadBookDetails();
  }

  Future<void> _loadBookDetails() async {
    final token = await _localStorageService.getToken();
    if (token != null && mounted) {
      context.read<GetBookDetailsCubit>().getBookDetails(widget.bookId, token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.go(RouterConstants.home);
          },
        ),
        title: const Text(
          'Detalles del libro',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: BlocBuilder<GetBookDetailsCubit, GetBookDetailsState>(
        builder: (context, state) {
          if (state is GetBookDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetBookDetailsLoaded) {
            final book = state.book;
            return _BookDetailsContent(book: book);
          } else if (state is GetBookDetailsFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(
              child: Text('No se encontraron detalles del libro'),
            );
          }
        },
      ),
    );
  }
}

class _BookDetailsContent extends StatelessWidget {
  final Book book;

  const _BookDetailsContent({required this.book});

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Estás seguro de que deseas eliminar este libro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (result == true && context.mounted) {
      final token = await LocalStorageService().getToken();
      if (token != null) {
        context.read<DeleteBookCubit>().deleteBook(book.id, token);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteBookCubit, DeleteBookState>(
      listener: (context, state) {
        if (state is DeleteBookSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Libro eliminado exitosamente')),
          );
          context.go(RouterConstants.home);
        } else if (state is DeleteBookFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Container(
                height: 180,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    book.imagenUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/book_example.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _DetailCard(
              label: 'Categoría',
              value: book.categoria,
              iconAsset: 'assets/images/categoria.png',
            ),
            const SizedBox(height: 16),
            _DetailCard(
              label: 'Cantidad disponible',
              value: book.cantidad.toString(),
              iconAsset: 'assets/images/cantidad.png',
            ),
            const SizedBox(height: 16),
            _DetailCard(
              label: 'Ubicación',
              value: book.ubicacion,
              iconAsset: 'assets/images/ubicacion.png',
            ),
            const SizedBox(height: 16),
            _DetailCard(
              label: 'Fecha de publicación',
              value: book.fechaPublicacion,
              iconAsset: 'assets/images/publicacion.png',
            ),
            const SizedBox(height: 16),
            _ResumenCard(
              label: 'Resumen',
              title: book.titulo,
              description: book.descripcion,
              iconAsset: 'assets/images/resumen.png',
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    onPressed: () {
                      context.go(
                        '${RouterConstants.editBook}/${book.id}',
                        extra: book
                      );
                    },
                    child: const Text(
                      'Editar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BlocBuilder<DeleteBookCubit, DeleteBookState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE56E1A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                        ),
                        onPressed: state is DeleteBookLoading
                            ? null
                            : () => _showDeleteConfirmation(context),
                        child: state is DeleteBookLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Eliminar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final String label;
  final String value;
  final String iconAsset;

  const _DetailCard({
    required this.label,
    required this.value,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF8F3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black26, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(iconAsset, width: 48, height: 48, fit: BoxFit.contain),
        ],
      ),
    );
  }
}

class _ResumenCard extends StatelessWidget {
  final String label;
  final String title;
  final String description;
  final String iconAsset;

  const _ResumenCard({
    required this.label,
    required this.title,
    required this.description,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF8F3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black26, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(description, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(iconAsset, width: 56, height: 56, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
