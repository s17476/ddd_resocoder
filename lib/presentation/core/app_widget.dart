import 'package:ddd_resocoder/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:ddd_resocoder/injection.dart';
import 'package:ddd_resocoder/presentation/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SignInFormBloc>()),
      ],
      child: MaterialApp(
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
        home: const SignInPage(),
      ),
    );
  }
}
