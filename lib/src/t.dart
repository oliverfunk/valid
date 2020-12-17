import 'package:valid/src/valid_list/valid_list.dart';
import 'package:valid/src/valid_value/valid_enum.dart';

enum TestEnum {
  A,
  B,
  C,
}

void main(List<String> args) {
  final l = ValidList([1, 2, 3]);
  print(l.add(4));
}
