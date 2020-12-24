import 'package:meta/meta.dart';

import 'valid_primitive_value_type.dart';
import '../typedefs.dart';

class Valid<V> extends ValidPrimitiveValueType<Valid<V>, V> {
  Valid(
    V? initialValue, [
    Validator<V>? validator,
  ]) : super.initial(
          initialValue,
          validator: validator,
        );

  Valid._next(
    Valid<V> previous,
    V nextValue,
  ) : super.constructNext(previous, nextValue);

  @override
  @protected
  Valid<V> buildNext(V nextValue) => Valid._next(this, nextValue);
}
