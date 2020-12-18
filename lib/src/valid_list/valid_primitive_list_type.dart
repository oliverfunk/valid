import '../typedefs.dart';
import 'valid_list_type.dart';

abstract class ValidPrimitiveListType<T extends ValidPrimitiveListType<T, V>, V>
    extends ValidListType<T, V> {
  ValidPrimitiveListType.initial([
    List<V> initialList = const [],
    Validator<List<V>>? listValidator,
  ])  : assert(
          [bool, int, double, String, DateTime].contains(V),
          'The list value type <V> must be one of: [bool, int, double, String, DateTime], received <$V>',
        ),
        super.initial(initialList, listValidator);

  ValidPrimitiveListType.constructNext(T previous, List<V> nextList)
      : super.constructNext(previous, nextList);
}
