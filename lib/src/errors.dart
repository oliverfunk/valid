import 'valid_type.dart';

/// An [Error] that occurs when an invalid value
/// is used to initialize a valid type.
class InitializationError extends Error {
  final Type validType;
  final dynamic receivedValue;

  InitializationError(this.validType, this.receivedValue);

  @override
  String toString() =>
      'InitialValidationError: Attempting to initialize "$validType" with an invalid value.'
      '\n Value: $receivedValue';
}

/// An [Error] that occurs when a string is used to update an enum
/// that does not match any of the internal enums.
class EnumMatchError extends Error {
  final dynamic receivedValue;
  final List<String> availableEnums;

  EnumMatchError(this.receivedValue, this.availableEnums);

  @override
  String toString() =>
      'EnumMatchError: "$receivedValue" does not match one of the available enums.'
      '\n Available: $availableEnums';
}

/// An [Error] that occurs when a [ValidType] is being updated
/// with another that does not share a history with it.
///
/// See [ModelType.hasEqualityOfHistory].
class EqualityOfHistoryError extends Error {
  final ValidType thisModel;
  final ValidType otherValid;

  EqualityOfHistoryError(this.thisModel, this.otherValid);

  @override
  String toString() =>
      'EqualityOfHistoryError: The ValidTypes have no shared history.'
      '\n This:   $thisModel'
      '\n Other:  $otherValid';
}

class NullValueError extends Error {
  final Type validType;

  NullValueError(this.validType);

  @override
  String toString() =>
      'NullValueError: a value of null for this ValidType was using during an update.'
      '\n This: $validType';
}

class UpdateError extends Error {
  final Type forValidType;
  final Type valueType;
  final dynamic receivedUpdate;

  UpdateError(this.forValidType, this.valueType, this.receivedUpdate);

  @override
  String toString() =>
      'UpdateError: The update type must one of: [$forValidType, ($valueType) => $valueType, $valueType]'
      '\n Received: $receivedUpdate';
}
