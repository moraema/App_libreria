import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:libreria/core/router/domain/constants/router_constants.dart';
import 'package:libreria/core/services/local_storage_service.dart';
import 'package:libreria/features/book_details/domain/entities/book.dart';
import 'package:libreria/features/edit_book/domain/entities/book.dart' as edit_book;
import 'package:libreria/features/edit_book/presentation/cubit/book_update_cubit.dart';
import 'package:libreria/features/edit_book/presentation/cubit/book_update_state.dart';
import 'package:libreria/features/edit_book/presentation/widgets/edit_book_form.dart';
import 'package:libreria/features/edit_book/presentation/widgets/edit_book_actions.dart';

class EditBookPage extends StatefulWidget {
  final Book book;

  const EditBookPage({Key? key, required this.book}) : super(key: key);

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController ubicacionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final _localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.book.titulo;
    authorController.text = widget.book.autor;
    yearController.text = widget.book.fechaPublicacion;
    categoryController.text = widget.book.categoria;
    descriptionController.text = widget.book.descripcion;
    cantidadController.text = widget.book.cantidad.toString();
    ubicacionController.text = widget.book.ubicacion;
    imageUrlController.text = widget.book.imagenUrl;
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
        backgroundColor: const Color(0xFFFFF9E6),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF6F1ED),
          title: const Text('Editar Libro'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditBookForm(
                titleController: titleController,
                authorController: authorController,
                yearController: yearController,
                categoryController: categoryController,
                descriptionController: descriptionController,
                cantidadController: cantidadController,
                ubicacionController: ubicacionController,
                imageUrlController: imageUrlController,
              ),
              const SizedBox(height: 32),
              EditBookActions(
                onSave: _updateBook,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
