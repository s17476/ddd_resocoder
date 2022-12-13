import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/notes/note_watcher/note_watcher_bloc.dart';

class NotesOverviewBody extends StatelessWidget {
  const NotesOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => const SizedBox(),
          loadInProgress: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          loadSuccess: (state) {
            return ListView.builder(
              itemCount: state.notes.size,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                if (note.failureOption.isSome()) {
                  return Container(
                    color: Colors.red,
                    height: 100,
                    width: double.infinity,
                  );
                } else {
                  return Container(
                    color: Colors.green,
                    height: 100,
                    width: double.infinity,
                  );
                }
              },
            );
          },
          loadFailure: (state) => Container(
            color: Colors.yellow,
            height: 200,
            width: double.infinity,
          ),
        );
      },
    );
  }
}
