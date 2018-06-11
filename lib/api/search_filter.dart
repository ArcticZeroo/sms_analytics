import 'package:meta/meta.dart';

enum SearchFilterType {
  Threads, Text, DateStart, DateEnd, MaxCount, SortBy, GroupBy
}

class SearchFilter<T> {
  SearchFilterType _type;
  T value;

  SearchFilterType get type => _type;

  SearchFilter({
    @required
    SearchFilterType type,
    this.value
  });
}