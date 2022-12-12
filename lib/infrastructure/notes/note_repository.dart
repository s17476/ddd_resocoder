import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd_resocoder/infrastructure/core/firestore_helpers.dart';
import 'package:ddd_resocoder/infrastructure/notes/note_dtos.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import 'package:ddd_resocoder/domain/notes/i_note_repository.dart';
import 'package:ddd_resocoder/domain/notes/note.dart';
import 'package:ddd_resocoder/domain/notes/note_failure.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: INoteRepository)
class Noterepository implements INoteRepository {
  final FirebaseFirestore firebaseFirestore;

  const Noterepository({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<NoteFailure, Unit>> create(Note note) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<NoteFailure, Unit>> delete(Note note) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<NoteFailure, Unit>> update(Note note) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchAll() async* {
    final userDoc = await firebaseFirestore.userDocument();
    yield* userDoc.noteCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => right<NoteFailure, KtList<Note>>(
            snapshot.docs
                .map((doc) => NoteDto.fromFirestore(doc).toDomain())
                .toImmutableList(),
          ),
        )
        .onErrorReturnWith(
      (error, stackTrace) {
        if (error is PlatformException &&
            error.message!.contains('PREMISSION_DENIED')) {
          return left(const NoteFailure.insufficientPremission());
        } else {
          // log.error(error.toString());
          return left(const NoteFailure.unexpected());
        }
      },
    );
  }

  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted() async* {
    final userDoc = await firebaseFirestore.userDocument();
    yield* userDoc.noteCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        // map snapshot to entities
        .map((snapshot) =>
            snapshot.docs.map((doc) => NoteDto.fromFirestore(doc).toDomain()))
        // filter only uncompleted notes
        .map(
          (notes) => right<NoteFailure, KtList<Note>>(
            notes
                .where((note) =>
                    note.todos.getOrCrasch().any((todoItem) => !todoItem.done))
                .toImmutableList(),
          ),
        )
        .onErrorReturnWith(
      (error, stackTrace) {
        if (error is PlatformException &&
            error.message!.contains('PREMISSION_DENIED')) {
          return left(const NoteFailure.insufficientPremission());
        } else {
          // log.error(error.toString());
          return left(const NoteFailure.unexpected());
        }
      },
    );
  }
}
