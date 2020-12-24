import 'package:meta/meta.dart';

import 'valid_enum_type.dart';

class ValidEnum<E> extends ValidEnumType<ValidEnum<E>, E> {
  ValidEnum(
    E initialEnum, {
    required List<E> enumValues,
  }) : super.initial(
          initialEnum,
          enumValues: enumValues,
        );

  ValidEnum._next(ValidEnum<E> previous, E nextEnum)
      : super.constructNext(previous, nextEnum);

  @override
  @protected
  ValidEnum<E> buildNext(E nextEnum) => ValidEnum._next(this, nextEnum);
}
