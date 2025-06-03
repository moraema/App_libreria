import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:libreria/core/router/domain/constants/router_constants.dart';
import 'package:libreria/core/services/local_storage_service.dart';
import 'package:libreria/features/home/presentation/cubit/get_book_cubit.dart';
import 'package:libreria/features/home/presentation/widgets/home_search_bar.dart';
import 'package:libreria/features/home/presentation/widgets/books_list.dart';

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
      backgroundColor: const Color(0xFFFFF5E6),
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
          const HomeSearchBar(),
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
          const BooksList(),
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
