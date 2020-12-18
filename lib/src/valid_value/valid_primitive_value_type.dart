import 'package:valid/src/valid_value/valid_value_type.dart';

import '../typedefs.dart';

abstract class ValidPrimitiveValueType<T extends ValidPrimitiveValueType<T, V>,
    V> extends ValidValueType<T, V> {
  ValidPrimitiveValueType.initial(
    V initialValue, [
    Validator<V>? validator,
  ])  : assert(
          [bool, int, double, String, DateTime].contains(V),
          'The value type <V> must be one of: [bool, int, double, String, DateTime], received <$V>',
        ),
        super.initial(initialValue);

  ValidPrimitiveValueType.constructNext(T previous, V nextValue)
      : super.constructNext(previous, nextValue);
}
