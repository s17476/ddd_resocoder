import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({
    required String failure,
  }) = InvalidEmail<T>;

  const factory ValueFailure.shortPassword({
    required String failure,
  }) = ShortPassword<T>;
}
