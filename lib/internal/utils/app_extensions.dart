import 'package:intl/intl.dart';


extension StringExtension on String {
  String get upperCaseFirst {
    if (length == 0) return this;
    return replaceFirst(substring(0, 1), substring(0, 1).toUpperCase());
  }

  double get toDouble {
    if (isEmpty) {
      throw StateError('value is empty');
    }
    return double.tryParse(this);
  }

  int get toInt {
    if (isEmpty) {
      throw StateError('value is empty');
    }
    return int.tryParse(this);
  }
}

/// Extensions for comparable `Iterable`
extension DateTimeExtension on DateTime{

  String get nameOfDay {
    if(this == null){
      throw StateError("element is null");
    }
    return DateFormat('EEEE').format(this);
  }
}

/// Extensions for comparable `Iterable`
extension IterableComparableExtension<T extends Comparable> on Iterable<T> {
  Iterable<T> get _sorted => toList()..sort();

  /// Returns the element with minimum value.
  ///
  /// If `this` is empty, [StateError] will be thrown.
  T get min {
    if (isEmpty) {
      throw StateError('No element');
    }
    return _sorted.first;
  }

  /// Returns the element with maximum value.
  ///
  /// If `this` is empty, [StateError] will be thrown.
  T get max {
    if (isEmpty) {
      throw StateError('No element');
    }
    return _sorted.last;
  }

  //[3, 6, 2, 7, 9].minWhere((_) => _ > 4) => 6
  T minWhere(bool Function(T element) cond) => where(cond).min;

  //[3, 6, 2, 7, 9].maxWhere((_) => _ < 4) => 3
  T maxWhere(bool Function(T element) cond) => where(cond).max;
}

/// Math extensions for numeric `Iterable`
extension IterableMathExtension<T extends num> on Iterable<T> {

  num get sum => fold<num>(0, (prev, element) => prev + element);

  num get average => isNotEmpty ? sum / length : 0;

  //[3, 6, 2, 7, 9].sumWhere((_) => _ > 4) => 22
  num sumWhere(bool Function(T element) cond) => where(cond).sum;

  //[1, 3, 5, 7, 4, 4].averageWhere((_) => _ > 4) => 6
  num averageWhere(bool Function(T element) cond) => where(cond).average;
}

/// Set extensions for `Iterable`
extension IterableSetExtension<T> on Iterable<T> {

  List<T> get distinct => toSet().toList();

  /// Returns new list of objects filtered by `cond` predicate
  /// in which each object can occur only once
  ///
  /// The order of the elements is not guaranteed to be the same
  /// as for the iterable.
  ///
  /// For more info about filtering refer to [Iterable.where].
  List<T> distinctWhere(bool Function(T element) cond) =>
      where(cond).toSet().toList();

  /// Returns a new list which is the intersection between this list and [other].
  ///
  /// That is, the returned list contains all the elements of this [List] that
  /// are also elements of [other] according to `other.contains`.
  ///
  /// Note that `this` list and `other` will be cleared from item duplicates.
  List<T> intersection(List<T> other) =>
      toSet().intersection(other.toSet()).toList();

  /// Returns a new list which is the intersection between filtered this list
  /// by `test` predicate and [other].
  ///
  /// That is, the returned list contains all the elements of this [List] that
  /// are also elements of [other] according to `other.contains`.
  ///
  /// Note that filtering is applied to both `this` and `other` [Iterable]s.
  ///
  /// Note that `this` list and `other` will be cleared from item duplicates.
  List<T> intersectionWhere(List<T> other, bool Function(T element) test) =>
      where(test).toSet().intersection(other.where(test).toSet()).toList();

  /// Returns a new list which contains all the elements of this list and [other].
  ///
  /// That is, the returned list contains all the elements of this [list] and
  /// all the elements of [other].
  ///
  /// Note that `this` list and `other` will be cleared from item duplicates.
  List<T> union(List<T> other) => toSet().union(other.toSet()).toList();

  /// Returns a new list which contains all the elements of filtered this list
  /// by `test` and [other].
  ///
  /// That is, the returned list contains all the elements of this [list] and
  /// all the elements of [other].
  ///
  /// Note that filtering is applied to both `this` and `other` [Iterable]s.
  ///
  /// Note that `this` list and `other` will be cleared from item duplicates.
  List<T> unionWhere(List<T> other, bool Function(T element) test) =>
      where(test).toSet().union(other.where(test).toSet()).toList();

  /// Returns a new list with the elements of this that are not in [other].
  ///
  /// That is, the returned list contains all the elements of this [Set] that
  /// are not elements of [other] according to `other.contains`.
  ///
  /// Note that `this` list and `other` will be cleared from item duplicates.
  List<T> difference(List<T> other) =>
      toSet().difference(other.toSet()).toList();

  /// Returns a new list with the elements of filtered this by `test` that
  /// are not in [other].
  ///
  /// That is, the returned list contains all the elements of this [Set] that
  /// are not elements of [other] according to `other.contains`.
  ///
  /// Note that filtering is applied to both `this` and `other` [Iterable]s.
  ///
  /// Note that `this` list and `other` will be cleared from item duplicates.
  List<T> differenceWhere(List<T> other, bool Function(T element) test) =>
      where(test).toSet().difference(other.where(test).toSet()).toList();
}