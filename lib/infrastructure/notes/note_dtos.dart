import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_resocoder/domain/core/value_objects.dart';
import 'package:ddd_resocoder/domain/notes/todo_item.dart';
import 'package:ddd_resocoder/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

import '../../domain/notes/note.dart';

part 'note_dtos.freezed.dart';
part 'note_dtos.g.dart';

@freezed
abstract class NoteDto implements _$NoteDto {
  const NoteDto._();

  const factory NoteDto({
    // ignore: invalid_annotation_target
    @JsonKey(ignore: true) @Default('') String id,
    required String body,
    required int color,
    required List<TodoItemDto> todos,
    @ServerTimestampConverter() required FieldValue serverTimeStamp,
  }) = _NoteDto;

  factory NoteDto.fromDomain(Note note) {
    return NoteDto(
      id: note.id.getOrCrasch(),
      body: note.body.getOrCrasch(),
      color: note.color.getOrCrasch().value,
      todos: note.todos
          .getOrCrasch()
          .map((todoItem) => TodoItemDto.fromDomain(todoItem))
          .asList(),
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  Note toDomain() {
    return Note(
      id: UniqueId.fromUniqueString(id),
      body: NoteBody(body),
      color: NoteColor(Color(color)),
      todos: List3(todos.map((dto) => dto.toDomain()).toImmutableList()),
    );
  }

  factory NoteDto.fromJson(Map<String, dynamic> json) =>
      _$NoteDtoFromJson(json);

  factory NoteDto.fromFirestore(DocumentSnapshot doc) {
    return NoteDto.fromJson(doc.data() as Map<String, dynamic>)
        .copyWith(id: doc.id);
  }
}

class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
  const ServerTimestampConverter();

  @override
  FieldValue fromJson(Object json) => FieldValue.serverTimestamp();

  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}

@freezed
abstract class TodoItemDto implements _$TodoItemDto {
  const TodoItemDto._();

  const factory TodoItemDto({
    required String id,
    required String name,
    required bool done,
  }) = _TodoItemDto;

  factory TodoItemDto.fromDomain(TodoItem todoItem) {
    return TodoItemDto(
      id: todoItem.id.getOrCrasch(),
      name: todoItem.name.getOrCrasch(),
      done: todoItem.done,
    );
  }

  TodoItem toDomain() {
    return TodoItem(
      id: UniqueId.fromUniqueString(id),
      name: TodoName(name),
      done: done,
    );
  }

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);
}
