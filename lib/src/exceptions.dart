/// The abstract [Exception] used for model exceptions
abstract class ValidException implements Exception {
  const ValidException();
}

/// An [Exception] that occurs when a model is updated with an invalid value.
class ValidationException extends ValidException {
  final Type modelType;
  final dynamic receivedValue;

  ValidationException(this.modelType, this.receivedValue);

  @override
  String toString() => 'ValidationException:\n'
      ' For: $modelType\n'
      ' Validation failed on "$receivedValue"\n';
}
