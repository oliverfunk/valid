import 'valid_value_type.dart';
import '../errors.dart';

/// Returns [enumValue] as a [String].
///
/// This will fail if [enumValue] is an enum instance.
///
/// Only the name of the enum instance is returned, the class's name is stripped out.
String convertEnum<E>(E enumValue) => enumValue.toString().split('.')[1];

/// Converts [enumValues] to a list of Strings.
///
/// [enumValues] should come from calling the static `.values` getter on the enum class.
List<String> convertEnumList<E>(List<E> enumValues) =>
    List.unmodifiable(enumValues.map(convertEnum));

/// Returns the enum in [enumValues] corresponding to [enumString],
/// else returns `null`.
E? fromString<E>(List<E> enumValues, String enumString) {
  E? returnEnum;
  try {
    returnEnum = enumValues.firstWhere(
      (en) => enumString == convertEnum<E>(en),
    );
  } on StateError {
    ;
  }
  return returnEnum;
}

/// Returns each string in [enumStrings] converted
/// to the corresponding enum in [enumValues],
/// using the [fromString] function.
///
/// `null` is returned if a single string has no corresponding enum value.
List<E>? fromStringList<E>(
  List<E> enumValues,
  List<String> enumStrings,
) {
  final enL = enumStrings.map(
    (enStr) => fromString<E>(enumValues, enStr),
  );
  return enL.contains(null) ? null : List.unmodifiable(enL);
}

abstract class ValidEnumType<T extends ValidEnumType<T, E>, E>
    extends ValidValueType<T, E> {
  final List<E> _enums;

  ValidEnumType.initial(
    E initialEnum, {
    required List<E> enumValues,
  })   : assert(
          enumValues.isNotEmpty,
          'enumValues cannot be empty, use the static .values getter method on the enum class.',
        ),
        assert(
          E != dynamic && E != Object,
          'The enum type <E> cannot be dynamic',
        ),
        assert(
          enumValues.every((e) {
            convertEnum(e);
            return true;
          }),
          '<E> not an enum',
        ),
        _enums = enumValues,
        super.initial(
          initialEnum,
          validator: (e) => enumValues.contains(e),
        );

  ValidEnumType.constructNext(T previous, E nextEnum)
      : _enums = previous._enums,
        super.constructNext(previous, nextEnum);

  @override
  // an enum's value can't be null
  E get value => super.value!;

  T nextWithString(String nextString) {
    final en = fromString<E>(_enums, nextString);
    return en != null
        ? next(en)
        : throw EnumMatchError(
            nextString,
            enumStrings,
          );
  }

  /// The current enum instance as a String.
  String asString() => convertEnum<E>(value);

  /// The list of the possible enum values.
  List<E> get enums => List.unmodifiable(_enums);

  /// The list of all enums in the class as Strings
  /// (converted using [convertEnumList]).
  List<String> get enumStrings => convertEnumList<E>(_enums);
}
