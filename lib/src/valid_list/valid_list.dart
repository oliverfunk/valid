import 'package:meta/meta.dart';

import 'valid_primitive_list_type.dart';
import '../typedefs.dart';

class ValidList<V> extends ValidPrimitiveListType<ValidList<V>, V> {
  ValidList(
    List<V> initialList, {
    Validator<List<V>>? validator,
  }) : super.initial(
          initialList,
          validator: validator,
        );

  ValidList._next(ValidList<V> previous, List<V> nextList)
      : super.constructNext(previous, nextList);

  @override
  @protected
  ValidList<V> buildNext(List<V> nextList) => ValidList._next(this, nextList);
}
