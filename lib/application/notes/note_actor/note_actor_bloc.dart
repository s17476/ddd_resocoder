import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/notes/i_note_repository.dart';
import '../../../domain/notes/note.dart';
import '../../../domain/notes/note_failure.dart';

part 'note_actor_bloc.freezed.dart';
part 'note_actor_event.dart';
part 'note_actor_state.dart';

@injectable
class NoteActorBloc extends Bloc<NoteActorEvent, NoteActorState> {
  final INoteRepository iNoteRepository;

  NoteActorBloc(this.iNoteRepository) : super(const _Initial()) {
    on<_Deleted>((event, emit) async {
      emit(const NoteActorState.actionInProgress());
      final possibleFailure = await iNoteRepository.delete(event.note);
      possibleFailure.fold(
        (failure) => emit(NoteActorState.deleteFailure(failure)),
        (_) => emit(const NoteActorState.deleteSuccess()),
      );
    });
  }
}
