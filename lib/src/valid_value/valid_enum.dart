import 'valid_enum_type.dart';

class ValidEnum<E> extends ValidEnumType<ValidEnum<E>, E> {
  factory ValidEnum(
    List<E> enumValues,
    E initialEnum,
  ) =>
      ValidEnum._(enumValues, initialEnum);

  ValidEnum._(
    List<E> enumValues,
    E initialEnum,
  ) : super.initial(enumValues, initialEnum);

  ValidEnum._next(ValidEnum<E> previous, E nextEnum)
      : super.constructNext(previous, nextEnum);

  @override
  ValidEnum<E> buildNext(E nextEnum) => ValidEnum._next(this, nextEnum);
}
