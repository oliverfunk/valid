import 'package:valid/src/typedefs.dart';

import 'valid_primitive_value_type.dart';

class Valid<V> extends ValidPrimitiveValueType<Valid<V>, V> {
  factory Valid(
    V initialValue, [
    Validator<V>? validator,
  ]) =>
      Valid._(initialValue, validator);

  Valid._(
    V initialValue, [
    Validator<V>? validator,
  ]) : super.initial(initialValue, validator);

  Valid._next(
    Valid<V> previous,
    V nextValue,
  ) : super.constructNext(previous, nextValue);

  @override
  Valid<V> buildNext(V nextValue) => Valid._next(this, nextValue);
}
