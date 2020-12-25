import 'package:meta/meta.dart';

import '../typedefs.dart';
import '../valid_type.dart';

abstract class ValidValueType<T extends ValidValueType<T, V>, V>
    extends ValidType<T, V> {
  final V? _current;

  ValidValueType.initial(
    V? initialValue, {
    Validator<V>? validator,
  })  : assert(V != List, 'Use the ValidListType class'),
        assert(V != Map, 'Use the ValidMapType class'),
        _current = initialValue,
        super.initial(
          initialValue,
          validator: validator,
        );

  ValidValueType.constructNext(T previous, this._current)
      : super.fromPrevious(previous);

  @override
  V? get value => _current;
}

/// A mixin that provides the relevant overrides when defining a value type class that wraps its own validation.
///
/// These overrides ensure that any instance of this value type can be used to update the value of
/// previous instance to its value. Otherwise, only instances that share a *direct* history with a previous one may do so.
///
/// This may be done because the class that uses this mixin wraps its own validation,
/// therefore all instances of it will hold an equally valid value and thus all "share a history" in an abstract sense.
mixin ValueType<T extends ValidValueType<T, V>, V> on ValidValueType<T, V> {
  @override
  @protected
  T buildFromOther(T nextModel) => identical(initial, nextModel.initial)
      ? nextModel
      : buildNext(nextModel.value!);
}
