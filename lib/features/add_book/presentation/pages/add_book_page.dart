import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:libreria/core/router/domain/constants/router_constants.dart';
import 'package:libreria/core/services/local_storage_service.dart';
import 'package:libreria/features/add_book/domain/entities/book.dart';
import 'package:libreria/features/add_book/presentation/cubit/add_book_cubit.dart';
import 'package:libreria/features/add_book/presentation/cubit/add_book_state.dart';

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
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
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
                  const Text(
                    'Detalles del libro',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  _CustomInput(
                    label: 'Título',
                    hint: 'Título aquí',
                    icon: Icons.menu_book_outlined,
                    controller: _tituloController,
                  ),
                  const SizedBox(height: 16),
                  _CustomInput(
                    label: 'Autor',
                    hint: 'Nombre del autor',
                    icon: Icons.person_outline,
                    controller: _autorController,
                  ),
                  const SizedBox(height: 16),
                  _CustomInput(
                    label: 'Publicación',
                    hint: 'Año de publicación aquí',
                    icon: Icons.date_range_outlined,
                    controller: _publicacionController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _CustomInput(
                    label: 'Categoría',
                    hint: 'Categoría aquí',
                    icon: Icons.category_outlined,
                    controller: _categoriaController,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Descripción',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _descripcionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Descripción aquí',
                      filled: true,
                      fillColor: const Color(0xFFF6F1ED),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Inventario',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  _CustomInput(
                    label: 'Cantidad',
                    hint: 'Cantidad aquí',
                    icon: Icons.tag,
                    controller: _cantidadController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _CustomInput(
                    label: 'Ubicación',
                    hint: 'Ubicación aquí',
                    icon: Icons.location_on_outlined,
                    controller: _ubicacionController,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Imagen del libro',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  _CustomInput(
                    label: 'URL de la imagen',
                    hint: 'Pega la URL de la imagen aquí',
                    icon: Icons.link,
                    controller: _imagenUrlController,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE56E1A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      onPressed:
                          isLoading
                              ? null
                              : () {
                                final libro = Book(
                                  titulo: _tituloController.text.trim(),
                                  autor: _autorController.text.trim(),
                                  fechaPublicacion:
                                      _publicacionController.text.trim(),
                                  categoria: _categoriaController.text.trim(),
                                  descripcion:
                                      _descripcionController.text.trim(),
                                  cantidad:
                                      int.tryParse(
                                        _cantidadController.text.trim(),
                                      ) ??
                                      0,
                                  ubicacion: _ubicacionController.text.trim(),
                                  imagenUrl: _imagenUrlController.text.trim(),
                                  idUser: _userId,
                                );

                                context.read<AddBookCubit>().addBook(
                                  libro,
                                  _token,
                                );
                              },
                      child:
                          isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text(
                                'Agregar libro',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                    ),
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

class _CustomInput extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const _CustomInput({
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF6F1ED),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(icon, color: Colors.black45),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}
