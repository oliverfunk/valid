import 'package:valid/src/typedefs.dart';

Validator<List<V>> every<V>(ListItemValidator<V> itemValidator) {
  return (list) => list.every(itemValidator);
}
