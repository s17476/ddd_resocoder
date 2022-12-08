import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

import '../../../domain/notes/i_note_repository.dart';
import '../../../domain/notes/note.dart';
import '../../../domain/notes/note_failure.dart';

part 'note_watcher_bloc.freezed.dart';
part 'note_watcher_event.dart';
part 'note_watcher_state.dart';

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  final INoteRepository iNoteRepository;

  StreamSubscription? _streamSubscription;

  NoteWatcherBloc(
    this.iNoteRepository,
  ) : super(const _Initial()) {
    on<NoteWatcherEvent>((event, emit) async {
      event.map(
        watchAllStarted: (e) async {
          emit(const NoteWatcherState.loadInProgress());
          await _streamSubscription?.cancel();
          _streamSubscription =
              iNoteRepository.watchAll().listen((failureOrNotes) {
            add(NoteWatcherEvent.notesRecived(failureOrNotes));
          });
        },
        watchUncompletedStarted: (e) async {
          emit(const NoteWatcherState.loadInProgress());
          await _streamSubscription?.cancel();
          _streamSubscription =
              iNoteRepository.watchUncompleted().listen((failureOrNotes) {
            add(NoteWatcherEvent.notesRecived(failureOrNotes));
          });
        },
        notesRecived: (e) async {
          e.failureOrNotes.fold(
            (failure) => emit(NoteWatcherState.loadFailure(failure)),
            (notes) => emit(NoteWatcherState.loadSuccess(notes)),
          );
        },
      );
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
