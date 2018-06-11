class SmsSearchAppRoute {
  // Where all SMS messages are actually loaded
  static const String SmsLoader = '/smsLoader';
  // Where statistics are created
  static const String Statistics = '/stats';
  // Where the user selects search parameters, and then presses search
  static const String SearchQuery = '/searchQuery';
  // Where the searching actually takes place -- loading progress is displayed
  // and then the results are actually shown to the given user.
  static const String SearchResults = '/searchResults';
}