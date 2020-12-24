import '../valid_value/valid_value_type.dart';
import 'valid_list_type.dart';

abstract class ValidValueListType<T extends ValidValueListType<T, V>, V>
    extends ValidListType<T, V> {
  final ValidValueType validator;

  ValidValueListType.initial(
    List<V> initialValues, {
    required this.validator,
  }) : super.initial(
          initialValues,
          validator: (list) => list.every((i) => validator.validate(i)),
        );

  ValidValueListType.initialNumberOf(
    int numberOf, {
    required this.validator,
  }) : super.initial(
          List<V>.filled(numberOf, validator.value as V),
          validator: (list) => list.every((i) => validator.validate(i)),
        );

  ValidValueListType.constructNext(T previous, List<V> nextList)
      : validator = previous.validator,
        super.constructNext(previous, nextList);
}
