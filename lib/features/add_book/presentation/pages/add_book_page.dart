import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:libreria/core/router/domain/constants/router_constants.dart';
import 'package:libreria/core/services/local_storage_service.dart';
import 'package:libreria/features/add_book/domain/entities/book.dart';
import 'package:libreria/features/add_book/presentation/cubit/add_book_cubit.dart';
import 'package:libreria/features/add_book/presentation/cubit/add_book_state.dart';
import 'package:libreria/features/add_book/presentation/widgets/book_form.dart';
import 'package:libreria/features/add_book/presentation/widgets/add_book_button.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _publicacionController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _ubicacionController = TextEditingController();
  final _imagenUrlController = TextEditingController();

  final _localStorageService = LocalStorageService();

  String _userId = '';
  String _token = '';

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final id = await _localStorageService.getUserId();
    final token = await _localStorageService.getToken();

    if (mounted) {
      setState(() {
        _userId = id ?? '';
        _token = token ?? '';
      });
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _publicacionController.dispose();
    _categoriaController.dispose();
    _descripcionController.dispose();
    _cantidadController.dispose();
    _ubicacionController.dispose();
    _imagenUrlController.dispose();
    super.dispose();
  }

  void _addBook() {
    final libro = Book(
      titulo: _tituloController.text.trim(),
      autor: _autorController.text.trim(),
      fechaPublicacion: _publicacionController.text.trim(),
      categoria: _categoriaController.text.trim(),
      descripcion: _descripcionController.text.trim(),
      cantidad: int.tryParse(_cantidadController.text.trim()) ?? 0,
      ubicacion: _ubicacionController.text.trim(),
      imagenUrl: _imagenUrlController.text.trim(),
      idUser: _userId,
    );

    context.read<AddBookCubit>().addBook(libro, _token);
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
          'Agregar nuevo libro',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: BlocConsumer<AddBookCubit, AddBookState>(
        listener: (context, state) {
          if (state is AddBookSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Libro agregado exitosamente')),
            );
            context.go(RouterConstants.home);
          } else if (state is AddBookFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AddBookLoading;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  BookForm(
                    titleController: _tituloController,
                    authorController: _autorController,
                    publicationController: _publicacionController,
                    categoryController: _categoriaController,
                    descriptionController: _descripcionController,
                    quantityController: _cantidadController,
                    locationController: _ubicacionController,
                    imageUrlController: _imagenUrlController,
                  ),
                  const SizedBox(height: 32),
                  AddBookButton(
                    isLoading: isLoading,
                    onPressed: _addBook,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
