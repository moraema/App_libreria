import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:libreria/core/router/domain/constants/router_constants.dart';
import 'package:libreria/core/services/local_storage_service.dart';
import 'package:libreria/features/book_details/domain/entities/book.dart';
import 'package:libreria/features/book_details/presentation/cubit/book_delete_cubit.dart';
import 'package:libreria/features/book_details/presentation/cubit/book_delete_state.dart';

class BookActions extends StatelessWidget {
  final Book book;

  const BookActions({
    Key? key,
    required this.book,
  }) : super(key: key);

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
    return Row(
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
                extra: book,
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
    );
  }
} 