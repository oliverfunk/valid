import 'package:logging/logging.dart';

import '../exceptions.dart';

void logException(ValidException exc) {
  Logger('ImmutableModel').warning(exc.toString());
}

R logExceptionAndReturn<R>(R toReturn, ValidException exc) {
  logException(exc);
  return toReturn;
}
