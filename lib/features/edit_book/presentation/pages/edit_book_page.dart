import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:libreria/core/router/domain/constants/router_constants.dart';
import 'package:libreria/core/services/local_storage_service.dart';
import 'package:libreria/features/book_details/domain/entities/book.dart';
import 'package:libreria/features/edit_book/domain/entities/book.dart' as edit_book;
import 'package:libreria/features/edit_book/presentation/cubit/book_update_cubit.dart';
import 'package:libreria/features/edit_book/presentation/cubit/book_update_state.dart';

class EditBookPage extends StatefulWidget {
  final Book book;

  const EditBookPage({Key? key, required this.book}) : super(key: key);

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController yearController;
  late TextEditingController categoryController;
  late TextEditingController descriptionController;
  late TextEditingController cantidadController;
  late TextEditingController ubicacionController;
  late TextEditingController imageUrlController;
  final _localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.book.titulo);
    authorController = TextEditingController(text: widget.book.autor);
    yearController = TextEditingController(text: widget.book.fechaPublicacion);
    categoryController = TextEditingController(text: widget.book.categoria);
    descriptionController = TextEditingController(text: widget.book.descripcion);
    cantidadController = TextEditingController(text: widget.book.cantidad.toString());
    ubicacionController = TextEditingController(text: widget.book.ubicacion);
    imageUrlController = TextEditingController(text: widget.book.imagenUrl);
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    yearController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
    cantidadController.dispose();
    ubicacionController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _updateBook() async {
    final token = await _localStorageService.getToken();
    if (token == null) return;

    final updatedBook = edit_book.Book(
      titulo: titleController.text,
      autor: authorController.text,
      fechaPublicacion: yearController.text,
      categoria: categoryController.text,
      descripcion: descriptionController.text,
      cantidad: int.tryParse(cantidadController.text) ?? 0,
      ubicacion: ubicacionController.text,
      imagenUrl: imageUrlController.text,
    );

    if (!mounted) return;
    context.read<UpdateBookCubit>().updateBook(widget.book.id, updatedBook, token);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateBookCubit, UpdateBookState>(
      listener: (context, state) {
        if (state is UpdateBookSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Libro actualizado exitosamente')),
          );
          context.go(RouterConstants.home);
        } else if (state is UpdateBookFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFCF8F3),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.go(RouterConstants.home),
          ),
          title: const Text(
            'Editar libro',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: BlocBuilder<UpdateBookCubit, UpdateBookState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CustomInput(label: 'Título', icon: Icons.menu_book_outlined, controller: titleController),
                  const SizedBox(height: 16),
                  _CustomInput(label: 'Autor', icon: Icons.person_outline, controller: authorController),
                  const SizedBox(height: 16),
                  _CustomInput(label: 'Publicación', icon: Icons.date_range_outlined, controller: yearController),
                  const SizedBox(height: 16),
                  _CustomInput(label: 'Categoría', icon: Icons.category_outlined, controller: categoryController),
                  const SizedBox(height: 16),
                  const Text('Descripción', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 4,
                    controller: descriptionController,
                    decoration: _inputDecoration('Descripción aquí'),
                  ),
                  const SizedBox(height: 16),
                  _CustomInput(label: 'Cantidad', icon: Icons.tag, controller: cantidadController, keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                  _CustomInput(label: 'Ubicación', icon: Icons.location_on_outlined, controller: ubicacionController),
                  const SizedBox(height: 24),
                  const Text('URL de la imagen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  _CustomInput(label: 'URL de la imagen', icon: Icons.link, controller: imageUrlController),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE56E1A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      onPressed: state is UpdateBookLoading ? null : _updateBook,
                      child: state is UpdateBookLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Guardar cambios',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF6F1ED),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      );
}

class _CustomInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const _CustomInput({
    required this.label,
    required this.icon,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: label,
            filled: true,
            fillColor: const Color(0xFFF6F1ED),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            prefixIcon: Icon(icon, color: Colors.black45),
            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          ),
        ),
      ],
    );
  }
}
