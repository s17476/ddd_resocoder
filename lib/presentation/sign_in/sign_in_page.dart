import 'package:ddd_resocoder/presentation/sign_in/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: const Center(child: SignInForm()),
    );
  }
}
