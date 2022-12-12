import 'dart:ui';

import 'package:ddd_resocoder/domain/notes/i_note_repository.dart';
import 'package:ddd_resocoder/domain/notes/value_objects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd_resocoder/domain/notes/note.dart';
import 'package:ddd_resocoder/domain/notes/note_failure.dart';
import 'package:ddd_resocoder/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

part 'note_form_event.dart';
part 'note_form_state.dart';
part 'note_form_bloc.freezed.dart';

@injectable
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  final INoteRepository iNoteRepository;
  NoteFormBloc(this.iNoteRepository) : super(NoteFormState.initial()) {
    on<NoteFormEvent>((event, emit) async {
      event.map(
        initialized: (e) async {
          if (e.note != null) {
            // editing
            emit(state.copyWith(note: e.note!, isEditing: true));
          } else {
            // new note
            emit(state);
          }
        },
        bodyChanged: (e) async {
          emit(
            state.copyWith(
              note: state.note.copyWith(body: NoteBody(e.bodyStr)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        colorChanged: (e) async {
          emit(
            state.copyWith(
              note: state.note.copyWith(color: NoteColor(e.color)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        todosChanged: (e) async {
          emit(
            state.copyWith(
              note: state.note.copyWith(
                todos: List3(
                  e.todos.map(
                    (primitive) => primitive.toDomain(),
                  ),
                ),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        saved: (e) async {
          Either<NoteFailure, Unit> failureOrSuccess =
              left(const NoteFailure.unexpected());
          emit(
            state.copyWith(
              isSaving: true,
              saveFailureOrSuccessOption: none(),
            ),
          );

          if (state.note.failureOption.isNone()) {
            failureOrSuccess = state.isEditing
                ? await iNoteRepository.update(state.note)
                : await iNoteRepository.create(state.note);
          }

          emit(
            state.copyWith(
              isSaving: false,
              showErrorMessages: true,
              saveFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
