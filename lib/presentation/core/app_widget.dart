import 'package:ddd_resocoder/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:ddd_resocoder/injection.dart';
import 'package:ddd_resocoder/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SignInFormBloc>()),
        BlocProvider(
          create: (context) => getIt<AuthBloc>()
            ..add(
              const AuthEvent.authCheckRequested(),
            ),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'Notes',
        theme: ThemeData(
          primarySwatch: Colors.green,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
