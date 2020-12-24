import 'package:meta/meta.dart';

import 'valid_value_list_type.dart';
import '../valid_value/valid_value_type.dart';

class ValidValueList<V> extends ValidValueListType<ValidValueList<V>, V> {
  ValidValueList(
    List<V> initialValues, {
    required ValidValueType validator,
  }) : super.initial(
          initialValues,
          validator: validator,
        );

  ValidValueList.numberOf(
    int numberOf, {
    required ValidValueType validator,
  }) : super.initialNumberOf(
          numberOf,
          validator: validator,
        );

  ValidValueList._next(ValidValueList<V> previous, List<V> nextList)
      : super.constructNext(previous, nextList);

  @override
  @protected
  ValidValueList<V> buildNext(List<V> nextList) =>
      ValidValueList._next(this, nextList);
}
