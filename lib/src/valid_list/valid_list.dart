import '../typedefs.dart';
import 'valid_list_type.dart';

import '../errors.dart';

class ValidList<V> extends ValidListType<ValidList<V>, V> {
  factory ValidList([
    List<V> initialList = const [],
    Validator<List<V>>? validator,
  ]) {
    // check the value type
    if (![bool, int, double, String, DateTime].contains(V)) {
      throw ModelInitializationError(
        ValidList,
        'The list value type <V> must be one of: [bool, int, double, String, DateTime], received <$V>',
      );
    }
    return ValidList._(initialList, validator);
  }

  ValidList._(List<V> initialList, Validator<List<V>>? validator)
      : super.initial(initialList, validator);

  ValidList._next(ValidList<V> previous, List<V> nextList)
      : super.constructNext(previous, nextList);

  @override
  ValidList<V> buildNext(List<V> nextList) => ValidList._next(this, nextList);
}
