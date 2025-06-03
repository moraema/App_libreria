import 'package:equatable/equatable.dart';

abstract class UpdateBookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateBookInitial extends UpdateBookState {}

class UpdateBookLoading extends UpdateBookState {}

class UpdateBookSuccess extends UpdateBookState {}

class UpdateBookFailure extends UpdateBookState {
  final String error;

  UpdateBookFailure(this.error);

  @override
  List<Object?> get props => [error];
}
