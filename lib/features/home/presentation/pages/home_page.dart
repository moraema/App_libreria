import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:libreria/core/router/domain/constants/router_constants.dart';
import 'package:libreria/core/services/local_storage_service.dart';
import 'package:libreria/features/home/presentation/cubit/get_book_cubit.dart';
import 'package:libreria/features/home/presentation/cubit/get_book_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    _loadInitialToken();
  }

  Future<void> _loadInitialToken() async {
    final token = await _localStorageService.getToken();
    final userId = await _localStorageService.getUserId();

    if (token != null && userId != null && mounted) {
      context.read<GetBooksCubit>().getBooks(token, userId);
    }
  }

  Future<void> _handleLogout() async {
    await _localStorageService.clearSession();
    if (mounted) {
      context.go(RouterConstants.login);
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
        title: const Text(
          'Mi Inventario',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              context.go(RouterConstants.addBook);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2E8DF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar libros',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Color(0xFFBFA181)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Libros en Inventario',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: BlocBuilder<GetBooksCubit, GetBooksState>(
              builder: (context, state) {
                if (state is GetBooksLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetBooksLoaded) {
                  final books = state.books;

                  if (books.isEmpty) {
                    return const Center(
                      child: Text('No hay libros en el inventario'),
                    );
                  }

                  return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return GestureDetector(
                        onTap: () {
                          context.go(
                            '${RouterConstants.bookDetails}/${book.id}',
                          );
                        },
                        child: BookInventoryItem(
                          image: book.imagenUrl,
                          title: book.titulo,
                          author: book.autor,
                          quantity: book.cantidad,
                          id: book.idUser,
                        ),
                      );
                    },
                  );
                } else if (state is GetBooksFailure) {
                  return Center(child: Text('Error: ${state.error}'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFCF8F3),
        selectedItemColor: const Color(0xFF1A1A1A),
        unselectedItemColor: const Color(0xFFBFA181),
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            _handleLogout();
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Inventario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Cerrar sesión',
          ),
        ],
      ),
    );
  }
}

class BookInventoryItem extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final int quantity;
  final String id;

  const BookInventoryItem({
    Key? key,
    required this.image,
    required this.title,
    required this.author,
    required this.quantity,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              image,
              width: 56,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Icon(Icons.broken_image),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF4E342E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Cantidad: $quantity',
                  style: const TextStyle(
                    color: Color(0xFF00897B),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Autor: $author',
                  style: const TextStyle(
                    color: Color(0xFF6D4C41),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
