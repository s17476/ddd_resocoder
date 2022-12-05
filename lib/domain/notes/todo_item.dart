import 'package:dartz/dartz.dart';
import 'package:ddd_resocoder/domain/core/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/value_objects.dart';
import 'value_objects.dart';

part 'todo_item.freezed.dart';

@freezed
abstract class TodoItem implements _$TodoItem {
  const TodoItem._();

  const factory TodoItem({
    required UniqueId id,
    required TodoName name,
    required bool done,
  }) = _TodoItem;

  factory TodoItem.empty() => TodoItem(
        id: UniqueId(),
        name: TodoName(''),
        done: false,
      );

  Option<ValueFailure<dynamic>> get failureOption {
    return name.value.fold((failure) => some(failure), (_) => none());
  }
}
