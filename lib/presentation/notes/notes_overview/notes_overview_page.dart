import 'package:auto_route/auto_route.dart';
import 'package:ddd_resocoder/application/auth/auth_bloc.dart';
import 'package:ddd_resocoder/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/notes/note_actor/note_actor_bloc.dart';
import '../../../application/notes/note_form/note_form_bloc.dart';
import '../../../application/notes/note_watcher/note_watcher_bloc.dart';
import '../../routes/router.gr.dart';

class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(
              const NoteWatcherEvent.watchAllStarted(),
            ),
        ),
        BlocProvider(create: (context) => getIt<NoteActorBloc>()),
        BlocProvider(create: (context) => getIt<NoteFormBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                unauthenticated: (_) =>
                    context.router.replace(const SignInRoute()),
              );
            },
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                deleteFailure: (state) => ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: state.noteFailure.map(
                        unexpected: (_) => const Text('Unexpected error'),
                        insufficientPremission: (_) =>
                            const Text('No premission'),
                        unableToUpdate: (_) => const Text('Unable to update'),
                      ),
                    ),
                  ),
              );
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () =>
                  context.read<AuthBloc>().add(const AuthEvent.signedOut()),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.indeterminate_check_box),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO: navigate
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
