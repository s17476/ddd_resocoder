import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ddd_resocoder/domain/auth/i_auth_facade.dart';
import 'package:ddd_resocoder/domain/auth/value_objects.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/auth/auth_failure.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade authFacade;

  SignInFormBloc({
    required this.authFacade,
  }) : super(SignInFormState.initial()) {
    on<_EmailChanged>((event, emit) async {
      emit(
        state.copyWith(
          emailAddress: EmailAddress(event.emailString),
          authFailureOrSuccessOption: none(),
        ),
      );
    });
    on<_PasswordChanged>((event, emit) async {
      emit(
        state.copyWith(
          password: Password(event.passwordString),
          authFailureOrSuccessOption: none(),
        ),
      );
    });
    on<_SignInWithGooglePressed>(
      (event, emit) async {
        emit(
          state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          ),
        );
        final failureOrSuccess = await authFacade.signIdWithGoogle();
        emit(
          state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(failureOrSuccess),
          ),
        );
      },
    );
    on<_RegisterWithEmailAndPasswordPressed>(
      (event, emit) async {
        await _performActionOnAuthFacadeWithEmailAndPassword(
          emit: emit,
          forwardedCall: authFacade.registerWithEmailAndPassword,
        );
      },
    );

    on<_SignInWithEmailAndPasswordPressed>(
      (event, emit) async {
        await _performActionOnAuthFacadeWithEmailAndPassword(
          emit: emit,
          forwardedCall: authFacade.signInWithEmailAndPassword,
        );
      },
    );
  }

  Future<void> _performActionOnAuthFacadeWithEmailAndPassword({
    required Emitter<SignInFormState> emit,
    required Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
    })
        forwardedCall,
  }) async {
    Either<AuthFailure, Unit>? failureOrSuccess;
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ),
      );
      failureOrSuccess = await forwardedCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }
    emit(
      state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption: optionOf(failureOrSuccess),
      ),
    );
  }
}
