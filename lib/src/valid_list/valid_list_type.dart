import 'package:meta/meta.dart';

import '../valid_type.dart';
import '../typedefs.dart';
import '../cow_types/copy_on_write_list.dart';

abstract class ValidListType<T extends ValidListType<T, V>, V>
    extends ValidType<T, List<V>> implements Iterable<V> {
  final List<V> _currentList;

  /// An [initialList] must be provided. It can be an empty list.
  ValidListType.initial(
    List<V> initialList, {
    Validator<List<V>>? validator,
  })  : assert(
          V != dynamic && V != Object,
          'The list value type <V> cannot be dynamic, it must be set explicitly',
        ),
        _currentList = initialList,
        super.initial(
          initialList,
          validator: validator,
        );

  ValidListType.constructNext(T previous, this._currentList)
      : super.fromPrevious(previous);

  @override
  List<V> get value => CopyOnWriteList(_currentList);

  /// If [nextList] is element-wise equal to the current list,
  /// and if it is not, this will return `true` and `false` if it is.
  @override
  bool shouldBuild(List<V> nextList) {
    if (identical(_currentList, nextList)) return false;
    if (_currentList.length != nextList.length) return true;
    for (var i = 0; i < _currentList.length; i++) {
      if (_currentList[i] != nextList[i]) return true;
    }
    return false;
  }

  @override
  List<List<V>> get props => [List.unmodifiable(_currentList)];

  @protected
  List<V> get internalList => _currentList;

  /// Removes all elements from this list.
  ///
  /// As [List.clear].
  T clear() => next(<V>[]);

  /// Replaces the element at [index] with the result of calling [updater] on it.
  T replaceAt(int index, V Function(V current) updater) {
    final l = value;
    final update = updater(l[index]);
    l[index] = update;
    return next(l);
  }

  V operator [](int index) => _currentList[index];

  int indexOf(V element, [int start = 0]) =>
      _currentList.indexOf(element, start);

  int indexWhere(bool Function(V) test, [int start = 0]) =>
      _currentList.indexWhere(test, start);

  // Iterable<V> interface implementation

  @override
  int get length => _currentList.length;

  @override
  bool any(bool Function(V) test) => _currentList.any(test);

  @override
  List<R> cast<R>() => _currentList.cast<R>();

  @override
  bool contains(Object? element) => _currentList.contains(element);

  @override
  V elementAt(int index) => _currentList.elementAt(index);

  @override
  bool every(bool Function(V) test) => _currentList.every(test);

  @override
  Iterable<R> expand<R>(Iterable<R> Function(V) f) => _currentList.expand(f);

  @override
  V get first => _currentList.first;

  @override
  V firstWhere(bool Function(V) test, {V Function()? orElse}) =>
      _currentList.firstWhere(test, orElse: orElse);

  @override
  R fold<R>(R initialValue, R Function(R, V) combine) =>
      _currentList.fold(initialValue, combine);

  @override
  Iterable<V> followedBy(Iterable<V> other) => _currentList.followedBy(other);

  @override
  void forEach(void Function(V) f) => _currentList.forEach(f);

  @override
  bool get isEmpty => _currentList.isEmpty;

  @override
  bool get isNotEmpty => _currentList.isNotEmpty;

  @override
  Iterator<V> get iterator => _currentList.iterator;

  @override
  String join([String separator = '']) => _currentList.join(separator);

  @override
  V get last => _currentList.last;

  @override
  V lastWhere(bool Function(V) test, {V Function()? orElse}) =>
      _currentList.lastWhere(test, orElse: orElse);

  @override
  Iterable<R> map<R>(R Function(V) f) => _currentList.map(f);

  @override
  V reduce(V Function(V, V) combine) => _currentList.reduce(combine);

  @override
  V get single => _currentList.single;

  @override
  V singleWhere(bool Function(V) test, {V Function()? orElse}) =>
      _currentList.singleWhere(test, orElse: orElse);

  @override
  Iterable<V> skip(int count) => _currentList.skip(count);

  @override
  Iterable<V> skipWhile(bool Function(V) test) => _currentList.skipWhile(test);

  @override
  Iterable<V> take(int count) => _currentList.take(count);

  @override
  Iterable<V> takeWhile(bool Function(V) test) => _currentList.takeWhile(test);

  @override
  List<V> toList({bool growable = true}) =>
      _currentList.toList(growable: growable);

  @override
  Set<V> toSet() => _currentList.toSet();

  @override
  Iterable<V> where(bool Function(V) test) => _currentList.where(test);

  @override
  Iterable<R> whereType<R>() => _currentList.whereType<R>();
}
