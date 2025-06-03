import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libreria/core/di/app_module.dart';
import 'package:libreria/core/router/view/app_router.dart';
import 'package:libreria/features/add_book/presentation/cubit/add_book_cubit.dart';
import 'package:libreria/features/book_details/presentation/cubit/book_delete_cubit.dart';
import 'package:libreria/features/book_details/presentation/cubit/book_details_cubit.dart';
import 'package:libreria/features/home/presentation/cubit/get_book_cubit.dart';
import 'package:libreria/features/register/presentation/cubit/register_cubit.dart';
import 'package:libreria/features/login/presentation/cubit/login_cubit.dart';
import 'package:libreria/features/edit_book/presentation/cubit/book_update_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterCubit(
            registerUserUseCase: AppModule.registerUserUseCase(),
          ),
        ),
        BlocProvider(
          create: (_) => LoginCubit(
            loginUseCase: AppModule.loginUseCase(),
            localStorageService: AppModule.localStorageService(),
          ),
        ),
        BlocProvider(
          create: (_) => AddBookCubit(
            useCase: AppModule.addBookUseCase(),
            )
          ),
        BlocProvider(
          create: (_) => GetBooksCubit(
            useCase: AppModule.getBooksUseCase(),
            )
          ),
          BlocProvider(
            create: (_) => GetBookDetailsCubit(
              useCase: AppModule.getBookDetailsUseCase(),
              )
          ),
          BlocProvider(
            create: (_) => UpdateBookCubit(
              useCase: AppModule.updateBookUseCase(),
            )
          ),
          BlocProvider(
            create: (_) => DeleteBookCubit(
              useCase: AppModule.deleteBookUseCase(),
            )
          )
      ],
      child: MaterialApp.router(
        title: 'Librería',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
