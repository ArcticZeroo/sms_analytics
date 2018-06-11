import 'package:sms/sms.dart';
import 'package:sms_analytics/api/search_filter.dart';

class SearchResult {
  Map<SearchFilterType, SearchFilter> filters;
  List<SmsMessage> matches;

  SearchResult({ this.filters, this.matches }) {
    if (this.filters == null) {
      this.filters = new Map<SearchFilterType, SearchFilter>();
    }

    if (this.matches == null) {
      this.matches = new List<SmsMessage>();
    }
  }
}