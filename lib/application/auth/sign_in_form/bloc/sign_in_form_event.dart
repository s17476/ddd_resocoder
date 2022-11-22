part of 'sign_in_form_bloc.dart';

@freezed
class SignInFormEvent with _$SignInFormEvent {
  const factory SignInFormEvent.emailChanged(String emailString) =
      _EmailChanged;
  const factory SignInFormEvent.passwordChanged(String passwordString) =
      _PasswordChanged;
  const factory SignInFormEvent.registerWithEmailAndPasswordPressed() =
      _RegisterWithEmailAndPasswordPressed;
  const factory SignInFormEvent.signInWithEmailAndPasswordPressed() =
      _SignInWithEmailAndPasswordPressed;
  const factory SignInFormEvent.signInWithGooglePressed() =
      _SignInWithGooglePressed;
}
