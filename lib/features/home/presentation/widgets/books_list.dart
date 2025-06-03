import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:libreria/core/router/domain/constants/router_constants.dart';
import 'package:libreria/features/home/presentation/cubit/get_book_cubit.dart';
import 'package:libreria/features/home/presentation/cubit/get_book_state.dart';
import 'package:libreria/features/home/presentation/widgets/book_inventory_item.dart';

class BooksList extends StatelessWidget {
  const BooksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
} 