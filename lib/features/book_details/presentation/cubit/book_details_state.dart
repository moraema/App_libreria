import 'package:equatable/equatable.dart';
import 'package:libreria/features/book_details/domain/entities/book.dart';


abstract class GetBookDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetBookDetailsInitial extends GetBookDetailsState {}

class GetBookDetailsLoading extends GetBookDetailsState {}

class GetBookDetailsLoaded extends GetBookDetailsState {
  final Book book;

  GetBookDetailsLoaded(this.book);

  @override
  List<Object?> get props => [book];
}

class GetBookDetailsFailure extends GetBookDetailsState {
  final String error;

  GetBookDetailsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
