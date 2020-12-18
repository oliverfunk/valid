import '../typedefs.dart';
import 'valid_primitive_list_type.dart';

class ValidList<V> extends ValidPrimitiveListType<ValidList<V>, V> {
  factory ValidList([
    List<V> initialList = const [],
    Validator<List<V>>? validator,
  ]) =>
      ValidList._(initialList, validator);

  ValidList._(List<V> initialList, Validator<List<V>>? validator)
      : super.initial(initialList, validator);

  ValidList._next(ValidList<V> previous, List<V> nextList)
      : super.constructNext(previous, nextList);

  @override
  ValidList<V> buildNext(List<V> nextList) => ValidList._next(this, nextList);
}
