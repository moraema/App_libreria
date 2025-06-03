import 'package:go_router/go_router.dart';
import 'package:libreria/features/book_details/domain/entities/book.dart';
import 'package:libreria/features/home/presentation/pages/home_page.dart';
import 'package:libreria/features/login/presentation/pages/login_page.dart';
import 'package:libreria/features/register/presentation/pages/register_page.dart';
import 'package:libreria/features/add_book/presentation/pages/add_book_page.dart';
import 'package:libreria/features/book_details/presentation/pages/book_details_page.dart';
import 'package:libreria/features/edit_book/presentation/pages/edit_book_page.dart';
import 'package:libreria/core/router/domain/constants/router_constants.dart';

class AppRouter {
  static final List<String> publicRoutes = [
    RouterConstants.login,
    RouterConstants.register,
  ];

  static final router = GoRouter(
    initialLocation: RouterConstants.login,
    routes: [
      GoRoute(
        path: RouterConstants.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouterConstants.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: RouterConstants.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RouterConstants.addBook,
        builder: (context, state) => const AddBookPage(),
      ),
      GoRoute(
        path: '${RouterConstants.bookDetails}/:id',
        builder: (context, state) {
          final bookId = state.pathParameters['id']!;
          return BookDetailsPage(bookId: bookId);
        },
      ),
      GoRoute(
        path: '${RouterConstants.editBook}/:id',
        builder: (context, state) {
          final book = state.extra as Book;
          return EditBookPage(book: book);
        }
      ),
    ],
  );
}
