import '../valid_value/valid_value_type.dart';
import 'valid_value_list_type.dart';

class ValidValueList<T extends ValidValueType<T, dynamic>>
    extends ValidValueListType<ValidValueList<T>, T> {
  ValidValueList(
    T validModel, [
    List initialValidValues = const [],
  ]) : super.initial(validModel, initialValidValues);

  ValidValueList.numberOf(
    T validModel,
    int numberOf,
  ) : super.initialNumberOf(validModel, numberOf);

  ValidValueList._next(ValidValueList<T> previous, List<T> nextList)
      : super.constructNext(previous, nextList);

  @override
  ValidValueList<T> buildNext(List<T> nextList) =>
      ValidValueList._next(this, nextList);
}
