import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ddd_resocoder/domain/auth/i_auth_facade.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade iAuthFacade;

  AuthBloc({
    required this.iAuthFacade,
  }) : super(const _Initial()) {
    on<AuthEvent>((event, emit) {
      event.map(
        authCheckRequested: (e) async {
          final userOption = await iAuthFacade.getSignedInUser();
          userOption.fold(
            () => emit(const AuthState.unauthenticated()),
            (_) => emit(const AuthState.authenticated()),
          );
        },
        signedOut: (e) async {
          await iAuthFacade.signOut();
          emit(const AuthState.unauthenticated());
        },
      );
    });
  }
}
