import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'errors.dart';
import 'exceptions.dart';
import 'typedefs.dart';
import 'utils/loggers.dart';

@immutable
abstract class ValidType<T extends ValidType<T, V>, V> extends Equatable {
  V get value;

  final Validator<V>? _validator;

  final T? _initialModel;

  ValidType.initial(
    V initialValue, [
    Validator<V>? validator,
  ])  : assert(V != dynamic, "The value type <V> cannot be dynamic"),
        _validator = validator,
        _initialModel = null {
    if (!validate(initialValue)) {
      logException(ValidationException(T, initialValue));
      throw ModelInitialValidationError(T, initialValue);
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
  T next(V nextValue) {
    if (!shouldBuild(nextValue)) return this as T;
    if (!validate(nextValue)) {
      logException(ValidationException(T, nextValue));
      return this as T;
    }
    return buildNext(nextValue);
  }

  @nonVirtual
  T nextWithFunc(ValueUpdater<V> updater) => next(updater(value));

  @nonVirtual
  T nextFromOther(T other) {
    if (!hasEqualityOfHistory(other)) throw EqualityOfHistoryError(this, other);

    return buildFromOther(other);
  }

  /// [nextValue] must be valid.
  @protected
  T buildNext(V nextValue);

  @protected
  T buildFromOther(T nextModel) => nextModel;

  bool shouldBuild(V nextValue) => nextValue != value;

  bool hasEqualityOfHistory(T other) => identical(initial, other.initial);

  @override
  List<V> get props => [value];

  @nonVirtual
  Type get modelType => T;

  @nonVirtual
  Type get valueType => V;

  @override
  String toString() => '$modelType($value)';
}
