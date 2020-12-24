import 'valid_type.dart';

/// An [Error] that occurs when an invalid value
/// is used to initialize a valid type.
class InitialValidationError extends Error {
  final Type validType;
  final dynamic receivedValue;

  InitialValidationError(this.validType, this.receivedValue);

  @override
  String toString() => 'InitialValidationError\n'
      'Invalid value used during initialization:\n'
      ' For:   $validType\n'
      ' Value: $receivedValue';
}

/// An [Error] that occurs when a string is used to update an enum
/// that does not match any of the internal enums.
class EnumMatchError extends Error {
  final dynamic receivedValue;
  final List<String> availableEnums;

  EnumMatchError(this.receivedValue, this.availableEnums);

  @override
  String toString() => 'EnumMatchError\n'
      '"$receivedValue" does not match one of the available enums:\n'
      ' $availableEnums\n';
}

// todo:
/// An [Error] that occurs when a model is being updated with another model that does not share a history with it.
///
/// See [ModelType.hasEqualityOfHistory].
class EqualityOfHistoryError extends Error {
  final ValidType thisModel;
  final ValidType receivedModel;

  EqualityOfHistoryError(this.thisModel, this.receivedModel);

  @override
  String toString() =>
      'EqualityOfHistoryError: The models have no shared history.\n'
      ' This model:     $thisModel\n'
      ' Received model: $receivedModel';
}

class NullValueError extends Error {}

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
