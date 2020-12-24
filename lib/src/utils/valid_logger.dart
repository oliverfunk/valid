import 'package:logging/logging.dart';

import '../exceptions.dart';

abstract class ValidLogger {
  static void logException(ValidException exc) {
    Logger('valid').warning(exc.toString());
  }

  static R logExceptionAndReturn<R>(R toReturn, ValidException exc) {
    logException(exc);
    return toReturn;
  }
}
