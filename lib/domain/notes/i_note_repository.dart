import 'package:dartz/dartz.dart';
import 'package:ddd_resocoder/domain/notes/note.dart';
import 'package:ddd_resocoder/domain/notes/note_failure.dart';
import 'package:kt_dart/collection.dart';

abstract class INoteRepository {
  Stream<Either<NoteFailure, KtList<Note>>> watchAll();

  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted();

  // watch uncompleted notes
  // CUD
}
