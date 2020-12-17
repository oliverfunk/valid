import 'package:meta/meta.dart';
import 'package:valid/src/utils/loggers.dart';

import '../cow_types/copy_on_write_list.dart';
import '../exceptions.dart';
import '../typedefs.dart';
import '../valid_type.dart';

abstract class ValidListType<T extends ValidListType<T, V>, V>
    extends ValidType<T, List<V>> implements Iterable<V> {
  final List<V> _list;

  ValidListType.initial(this._list, [Validator<List<V>>? validator])
      : super.initial(_list, validator);

  ValidListType.constructNext(T previous, this._list)
      : super.fromPrevious(previous);

  @override
  List<V> get value => CopyOnWriteList(_list);

  /// If [nextList] is not element-wise equal to the current list,
  /// this will return `true`.
  @override
  bool shouldBuild(List<V> nextList) {
    if (identical(_list, nextList)) return false;
    if (_list.length != nextList.length) return true;
    for (var i = 0; i < _list.length; i++) {
      if (_list[i] != nextList[i]) return true;
    }
    return false;
  }

  // todo: is there a more efficient way rather than allocating a new list instance
  @override
  get props => [List.unmodifiable(_list)];

  @protected
  List<V> get internalList => _list;

  // some list methods

  // non-mutating

  V operator [](int index) => _list[index];

  int indexOf(V element, [int start = 0]) => _list.indexOf(element, start);

  int indexWhere(bool Function(V) test, [int start = 0]) =>
      _list.indexWhere(test, start);

  // mutating methods as immutable, optimized

  T add(V item) {
    if (!validate([item])) {
      logException(ValidationException(T, item));
      return this as T;
    }
    return buildNext(value..add(item));
  }

  T addAll(Iterable<V> iterable) {
    if (!validate(iterable.toList())) {
      logException(ValidationException(T, iterable));
      return this as T;
    }
    return buildNext(value..addAll(iterable));
  }

  T sort([int Function(V, V)? compare]) => buildNext(value..sort(compare));

  /// Removes all elements from this list.
  ///
  /// As [List.clear].
  T clear() => buildNext(<V>[]);

  T replaceAt(int index, V updater(V current)) {
    final update = updater(internalList[index]);
    if (!validate([update])) {
      logException(ValidationException(T, update));
      return this as T;
    }
    final l = value;
    l[index] = update;
    return buildNext(l);
  }

  T removeAt(int index) => buildNext(value..removeAt(index));

  T removeLast() => buildNext(value..removeLast());

  // Iterable<V> interface implementation

  @override
  int get length => _list.length;

  @override
  bool any(bool Function(V) test) => _list.any(test);

  @override
  List<R> cast<R>() => _list.cast<R>();

  @override
  bool contains(Object? element) => _list.contains(element);

  @override
  V elementAt(int index) => _list.elementAt(index);

  @override
  bool every(bool Function(V) test) => _list.every(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(V) f) => _list.expand(f);

  @override
  V get first => _list.first;

  @override
  V firstWhere(bool Function(V) test, {V Function()? orElse}) =>
      _list.firstWhere(test, orElse: orElse);

  @override
  T fold<T>(T initialValue, T Function(T, V) combine) =>
      _list.fold(initialValue, combine);

  @override
  Iterable<V> followedBy(Iterable<V> other) => _list.followedBy(other);

  @override
  void forEach(void Function(V) f) => _list.forEach(f);

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  Iterator<V> get iterator => _list.iterator;

  @override
  String join([String separator = '']) => _list.join(separator);

  @override
  V get last => _list.last;

  @override
  V lastWhere(bool Function(V) test, {V Function()? orElse}) =>
      _list.lastWhere(test, orElse: orElse);

  @override
  Iterable<T> map<T>(T Function(V) f) => _list.map(f);

  @override
  V reduce(V Function(V, V) combine) => _list.reduce(combine);

  @override
  V get single => _list.single;

  @override
  V singleWhere(bool Function(V) test, {V Function()? orElse}) =>
      _list.singleWhere(test, orElse: orElse);

  @override
  Iterable<V> skip(int count) => _list.skip(count);

  @override
  Iterable<V> skipWhile(bool Function(V) test) => _list.skipWhile(test);

  @override
  Iterable<V> take(int count) => _list.take(count);

  @override
  Iterable<V> takeWhile(bool Function(V) test) => _list.takeWhile(test);

  @override
  List<V> toList({bool growable = true}) => _list.toList(growable: growable);

  @override
  Set<V> toSet() => _list.toSet();

  @override
  Iterable<V> where(bool Function(V) test) => _list.where(test);

  @override
  Iterable<T> whereType<T>() => _list.whereType<T>();
}
