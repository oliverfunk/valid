import 'package:valid/src/typedefs.dart';

import 'valid_value_type.dart';

class ValidValue<V> extends ValidValueType<ValidValue<V>, V> {
  factory ValidValue(V initialValue, [Validator<V>? validator]) =>
      ValidValue._(initialValue, validator);

  ValidValue._(V initialValue, [Validator<V>? validator])
      : super.initialPrimitive(initialValue, validator);

  ValidValue._next(ValidValue<V> previous, V nextValue)
      : super.constructNext(previous, nextValue);

  @override
  ValidValue<V> buildNext(V nextValue) => ValidValue._next(this, nextValue);
}
