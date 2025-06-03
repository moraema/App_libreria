import 'package:dio/dio.dart';
import 'package:libreria/core/network/dio_client.dart';
import 'package:libreria/core/services/local_storage_service.dart';
import 'package:libreria/features/add_book/data/datasources/remote/add_book_service.dart';
import 'package:libreria/features/add_book/data/repositories/add_book_repository_impl.dart';
import 'package:libreria/features/add_book/domain/usecases/add_book_use_case.dart';
import 'package:libreria/features/book_details/data/datasources/remote/book_delete_service.dart';
import 'package:libreria/features/book_details/data/datasources/remote/book_details_service.dart';
import 'package:libreria/features/book_details/data/repositories/book_details_repository_impl.dart';
import 'package:libreria/features/book_details/domain/usecases/book_details_use_case.dart';
import 'package:libreria/features/book_details/domain/usecases/delete_book_use_case.dart';
import 'package:libreria/features/edit_book/data/datasource/remote/update_book_service.dart';
import 'package:libreria/features/edit_book/data/repositories/update_book_repository_impl.dart';
import 'package:libreria/features/edit_book/domain/usecase/update_book_use_case.dart';
import 'package:libreria/features/home/data/datasources/remote/get_book_service.dart';
import 'package:libreria/features/home/data/repositories/get_book_repository_impl.dart';
import 'package:libreria/features/home/domain/usecases/get_book_use_case.dart';
import 'package:libreria/features/login/data/datasources/remote/login_service.dart';
import 'package:libreria/features/login/data/repositories/login_repository_impl.dart';
import 'package:libreria/features/login/domain/usecases/login_use_case.dart';
import 'package:libreria/features/register/data/datasources/remote/register_service.dart';
import 'package:libreria/features/register/data/repositories/register_repository_impl.dart';
import 'package:libreria/features/register/domain/usecases/register_use_case.dart';

class AppModule {
  static final Dio dio = Dio();
  static final DioClient dioClient = DioClient(dio: dio);

  static RegisterUseCase registerUserUseCase() {
    final registerService = RegisterService(dioClient);
    final repository = RegisterRepositoryImpl(registerService);
    return RegisterUseCase(repository);
  }

  static LoginUseCase loginUseCase() {
    final loginService = LoginService(dioClient);
    final repository = LoginRepositoryImpl(loginService);
    return LoginUseCase(repository);
  }

  static AddBookUseCase addBookUseCase() {
    final addBookService = AddBookService(dioClient);
    final repository = AddBookRepositoryImpl(addBookService);
    return AddBookUseCase(repository);
  }

  static GetBooksUseCase getBooksUseCase() {
    final getBookService = BookService(dioClient);
    final repository = BookRepositoryImpl(getBookService);
    return GetBooksUseCase(repository);
  }

  static GetBookDetailsUseCase getBookDetailsUseCase() {
    final getBookDetailsService = GetBookDetailsService(dioClient);
    final deleteBookService = DeleteBookService(dioClient);
    final repository = GetBookDetailsRepositoryImpl(service: getBookDetailsService, deleteService: deleteBookService);
    return GetBookDetailsUseCase(repository);
  }

  static UpdateBookUseCase updateBookUseCase() {
    final updateBookService = UpdateBookService(dioClient);
    final repository = UpdateBookRepositoryImpl(updateBookService);
    return UpdateBookUseCase(repository);
  }

  static DeleteBookUseCase deleteBookUseCase() {
    final deleteBookService = DeleteBookService(dioClient);
    final repository = GetBookDetailsRepositoryImpl(
      service: GetBookDetailsService(dioClient),
      deleteService: deleteBookService,
    );
    return DeleteBookUseCase(repository);
  }

  static LocalStorageService localStorageService() {
    return LocalStorageService();
  }
}
