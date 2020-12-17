import '../valid_value/valid_value_type.dart';
import 'valid_list_type.dart';

abstract class ValidValueListType<T extends ValidValueListType<T, M>,
    M extends ValidValueType<M, dynamic>> extends ValidListType<T, M> {
  final M validModel;

  ValidValueListType.initial(
    this.validModel,
    List initialValidValues,
  ) : super.initial(
          initialValidValues.map((i) => validModel.next(i)).toList(),
          (list) => list.every((i) => i.hasEqualityOfHistory(validModel)),
        );

  ValidValueListType.initialNumberOf(
    this.validModel,
    int numberOf,
  ) : super.initial(
          List<M>.filled(numberOf, validModel),
          (list) => list.every((i) => i.hasEqualityOfHistory(validModel)),
        );

  ValidValueListType.constructNext(T previous, List<M> nextList)
      : validModel = previous.validModel,
        super.constructNext(previous, nextList);

  V valueAt<V>(int index) => internalList[index].value as V;
}
