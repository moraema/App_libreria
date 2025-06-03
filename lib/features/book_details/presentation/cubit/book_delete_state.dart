import 'package:equatable/equatable.dart';

abstract class DeleteBookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteBookInitial extends DeleteBookState {}

class DeleteBookLoading extends DeleteBookState {}

class DeleteBookSuccess extends DeleteBookState {}

class DeleteBookFailure extends DeleteBookState {
  final String error;

  DeleteBookFailure(this.error);

  @override
  List<Object?> get props => [error];
}
