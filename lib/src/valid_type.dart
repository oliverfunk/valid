import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:valid/src/valid_value/valid_value_type.dart';

import 'errors.dart';
import 'exceptions.dart';
import 'typedefs.dart';
import 'utils/valid_logger.dart';

@immutable
abstract class ValidType<T extends ValidType<T, V>, V> extends Equatable {
  V? get value;

  final Validator<V>? _validator;

  final T? _initialModel;

  ValidType.initial(
    V? initialValue, {
    Validator<V>? validator,
  })  : assert(V != dynamic, 'The value type <V> cannot be dynamic'),
        _validator = validator,
        _initialModel = null {
    if (initialValue != null && !validate(initialValue)) {
      ValidLogger.logException(ValidationException(T, initialValue));
      throw InitializationError(T, initialValue);
    }
  }

  ValidType.fromPrevious(T previous)
      : _validator = previous._validator,
        _initialModel = previous.initial;

  @nonVirtual
  T get initial => _initialModel ?? this as T;

  @nonVirtual
  bool isInitial() => identical(this, initial);

  @nonVirtual
  bool validate(V toValidate) => _validator == null || _validator!(toValidate);

  @nonVirtual
  T reset() => initial;

  @nonVirtual
  T next(V nextValue) {
    if (!shouldBuild(nextValue)) return this as T;
    if (!validate(nextValue)) {
      ValidLogger.logException(ValidationException(T, nextValue));
      return this as T;
    }
    return buildNext(nextValue);
  }

  @nonVirtual
  T nextWithFunc(ValueUpdater<V> updater) {
    if (value == null) throw NullValueError(T);
    return next(updater(value!));
  }

  @nonVirtual
  T nextFromOther(T other) {
    if (other.value == null) throw NullValueError(T);
    if (!shouldBuild(other.value!)) return this as T;
    if (other is! ValueType && !hasEqualityOfHistory(other)) {
      throw EqualityOfHistoryError(this, other);
    }
    return buildFromOther(other);
  }

  @nonVirtual
  T call(dynamic update) {
    if (update == null) return this as T;
    if (update is T) {
      return nextFromOther(update);
    } else if (update is ValueUpdater<V>) {
      return nextWithFunc(update);
    } else if (update is V) {
      return next(update);
    }
    throw UpdateError(T, V, update);
  }

  @nonVirtual
  bool hasEqualityOfHistory(T other) => identical(initial, other.initial);

  /// [nextValue] must be valid.
  @protected
  T buildNext(V nextValue);

  @protected
  T buildFromOther(T nextModel) => nextModel;

  bool shouldBuild(V nextValue) => nextValue != value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() => '$T($value)';
}
