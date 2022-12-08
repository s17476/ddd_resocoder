// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ddd_resocoder/application/auth/auth_bloc.dart' as _i11;
import 'package:ddd_resocoder/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart'
    as _i10;
import 'package:ddd_resocoder/application/notes/note_actor/note_actor_bloc.dart'
    as _i7;
import 'package:ddd_resocoder/application/notes/note_watcher/note_watcher_bloc.dart'
    as _i9;
import 'package:ddd_resocoder/domain/auth/i_auth_facade.dart' as _i5;
import 'package:ddd_resocoder/domain/notes/i_note_repository.dart' as _i8;
import 'package:ddd_resocoder/infrastructure/auth/firebase_auth_facade.dart'
    as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import 'infrastructure/core/firebase_injectable_module.dart' as _i12;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final firebaseinjectableModule = _$FirebaseinjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseinjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.GoogleSignIn>(
      () => firebaseinjectableModule.googleSignIn);
  gh.lazySingleton<_i5.IAuthFacade>(() => _i6.FirebaseAuthFacade(
        firebaseAuth: gh<_i3.FirebaseAuth>(),
        googleSignIn: gh<_i4.GoogleSignIn>(),
      ));
  gh.factory<_i7.NoteActorBloc>(
      () => _i7.NoteActorBloc(gh<_i8.INoteRepository>()));
  gh.factory<_i9.NoteWatcherBloc>(
      () => _i9.NoteWatcherBloc(gh<_i8.INoteRepository>()));
  gh.factory<_i10.SignInFormBloc>(
      () => _i10.SignInFormBloc(authFacade: gh<_i5.IAuthFacade>()));
  gh.factory<_i11.AuthBloc>(
      () => _i11.AuthBloc(iAuthFacade: gh<_i5.IAuthFacade>()));
  return getIt;
}

class _$FirebaseinjectableModule extends _i12.FirebaseinjectableModule {}
