import 'valid_type.dart';

/// An [Error] that occurs during the initialization of a model.
class ModelInitializationError extends Error {
  final Type modelType;
  final String message;

  ModelInitializationError(this.modelType, this.message);

  @override
  String toString() => 'ModelInitializationError\n'
      'An error occurred during initialization:\n'
      ' Model:  $modelType\n'
      ' Reason: $message';
}

/// An [Error] that occurs when a model is being initialized with a value that does not validated.
class ModelInitialValidationError extends Error {
  final Type modelType;
  final dynamic receivedValue;

  ModelInitialValidationError(this.modelType, this.receivedValue);

  @override
  String toString() => 'ModelInitialValidationError\n'
      'Attempting to initialize a model with invalid data:\n'
      ' Model:    $modelType\n'
      ' Received: $receivedValue';
}

/// An [Error] that occurs when a model is being updated with a value that does not match the model's [ModelType.valueType].
class ModelTypeError extends Error {
  final ValidType thisModel;
  final dynamic receivedValue;

  ModelTypeError(this.thisModel, this.receivedValue);

  @override
  String toString() => 'ModelTypeError\n'
      'Expected type <${thisModel.valueType}> but received <${receivedValue.runtimeType}>.\n'
      ' This model:     $thisModel\n'
      ' Received value: $receivedValue';
}

/// An [Error] that occurs when an [EnumModel] is updated
/// with a string that does not match any of the internal enums.
class EnumMatchError extends Error {
  final dynamic receivedValue;
  final List<String> availableValues;

  EnumMatchError(this.receivedValue, this.availableValues);

  @override
  String toString() => 'EnumMatchError\n'
      '"$receivedValue" does not match one of the available enums:\n'
      ' $availableValues\n';
}

/// An [Error] that occurs when an attempt is made to update a [potentially]
/// with a selector when that [potentially] can only be updated strictly.
class ModelInnerStrictUpdateError extends Error {
  ModelInnerStrictUpdateError();

  @override
  String toString() => 'ModelInnerStrictUpdateError\n'
      ' Cannot update this ModelInner with a selector when strictUpdates are enabled.';
}

/// An [Error] that occurs when a model is being updated with another model that does not share a history with it.
///
/// See [ModelType.hasEqualityOfHistory].
class EqualityOfHistoryError extends Error {
  final ValidType thisModel;
  final ValidType receivedModel;

  EqualityOfHistoryError(this.thisModel, this.receivedModel);

  @override
  String toString() => 'ModelHistoryEqualityError\n'
      'The models have no shared history.\n'
      ' This model:     $thisModel\n'
      ' Received model: $receivedModel';
}

/// An [Error] that occurs when an attempt is made to access a model that does not exist in a [ModelInner].
class ModelAccessError extends Error {
  final Iterable<String> fieldLabels;
  final String field;

  ModelAccessError(this.fieldLabels, this.field);

  @override
  String toString() => 'ModelAccessError\n'
      '"$field" not in model.\n'
      ' Available fields are: $fieldLabels';
}
