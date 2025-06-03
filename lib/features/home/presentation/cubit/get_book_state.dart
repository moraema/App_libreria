import 'package:libreria/features/home/domain/entities/book.dart';

abstract class GetBooksState {}

class GetBooksInitial extends GetBooksState {}

class GetBooksLoading extends GetBooksState {}

class GetBooksLoaded extends GetBooksState {
  final List<Book> books;

  GetBooksLoaded(this.books);
}

class GetBooksFailure extends GetBooksState {
  final String error;

  GetBooksFailure(this.error);
}