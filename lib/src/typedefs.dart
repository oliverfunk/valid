import 'valid_type.dart';

/// A function that updates the value of a model based on its [currentValue].
typedef ValueUpdater<V> = V Function(V currentValue);

/// A function that validates the [value] passed to it.
typedef Validator<V> = bool Function(V value);

/// A function that validates an item from a list
typedef ListItemValidator<V> = bool Function(V listItem);

/// A function that validates [modelMap].
///
/// Note [modelMap] is read-only.
typedef MapValidator = bool Function(Map<String, ValidType> modelMap);
