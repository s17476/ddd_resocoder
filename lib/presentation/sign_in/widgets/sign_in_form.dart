import 'package:auto_route/auto_route.dart';
import 'package:ddd_resocoder/application/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import '../../routes/router.gr.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () => null,
          (either) => either.fold(
            (failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    failure.map(
                      cancelledByUser: (_) => 'Cancelled',
                      serverError: (_) => 'Server error',
                      emailAlreadyInUse: (_) => 'Email already in use',
                      invalidEmailAndPasswordCombination: (_) =>
                          'Invalid email and password combination',
                    ),
                  ),
                ),
              );
            },
            (_) {
              context.router.replace(const NotesOverviewRoute());
              context.read<AuthBloc>().add(
                    const AuthEvent.authCheckRequested(),
                  );
            },
          ),
        );
      },
      builder: (context, state) {
        // print(state.showErrorMessages);
        return Form(
            child: ListView(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          children: [
            const Text(
              '📝',
              style: TextStyle(
                fontSize: 58,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              autovalidateMode: state.showErrorMessages
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
              ),
              autocorrect: false,
              onChanged: (value) => context.read<SignInFormBloc>().add(
                    SignInFormEvent.emailChanged(value),
                  ),
              validator: (_) {
                if (!context
                    .read<SignInFormBloc>()
                    .state
                    .emailAddress
                    .isValid()) {
                  return 'Invalid email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              autovalidateMode: state.showErrorMessages
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
              ),
              autocorrect: false,
              obscureText: true,
              onChanged: (value) => context.read<SignInFormBloc>().add(
                    SignInFormEvent.passwordChanged(value),
                  ),
              validator: (_) {
                if (!context.read<SignInFormBloc>().state.password.isValid()) {
                  return 'Short email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.read<SignInFormBloc>().add(
                            const SignInFormEvent
                                .signInWithEmailAndPasswordPressed(),
                          );
                    },
                    child: const Text('SIGN IN'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.read<SignInFormBloc>().add(
                            const SignInFormEvent
                                .registerWithEmailAndPasswordPressed(),
                          );
                    },
                    child: const Text('REGISTER'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<SignInFormBloc>().add(
                      const SignInFormEvent.signInWithGooglePressed(),
                    );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              child: const Text(
                'SIGN IN WITH GOOGLE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (state.isSubmitting) ...[
              const SizedBox(
                height: 8,
              ),
              const LinearProgressIndicator(
                value: null,
              ),
            ]
          ],
        ));
      },
    );
  }
}
