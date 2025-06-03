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
import 'package:libreria/features/book_details/presentation/widgets/book_image.dart';
import 'package:libreria/features/book_details/presentation/widgets/detail_card.dart';
import 'package:libreria/features/book_details/presentation/widgets/resumen_card.dart';
import 'package:libreria/features/book_details/presentation/widgets/book_actions.dart';

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
      backgroundColor: const Color(0xFFFFF5E6),
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
            BookImage(imageUrl: book.imagenUrl),
            const SizedBox(height: 24),
            DetailCard(
              label: 'Categoría',
              value: book.categoria,
              iconAsset: 'assets/images/categoria.png',
            ),
            const SizedBox(height: 16),
            DetailCard(
              label: 'Cantidad disponible',
              value: book.cantidad.toString(),
              iconAsset: 'assets/images/cantidad.png',
            ),
            const SizedBox(height: 16),
            DetailCard(
              label: 'Ubicación',
              value: book.ubicacion,
              iconAsset: 'assets/images/ubicacion.png',
            ),
            const SizedBox(height: 16),
            DetailCard(
              label: 'Fecha de publicación',
              value: book.fechaPublicacion,
              iconAsset: 'assets/images/publicacion.png',
            ),
            const SizedBox(height: 16),
            ResumenCard(
              label: 'Resumen',
              title: book.titulo,
              description: book.descripcion,
              iconAsset: 'assets/images/resumen.png',
            ),
            const SizedBox(height: 32),
            BookActions(book: book),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
