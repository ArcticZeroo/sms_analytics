import 'dart:async';

import 'package:sms/sms.dart';

class SmsManager {
  static const allSmsTypes = const [SmsQueryKind.Sent, SmsQueryKind.Inbox, SmsQueryKind.Draft];
  static SmsManager _sharedInstance;

  SmsQuery _query;
  Map<int, SmsThread> _loadedThreadsById;
  Map<int, int> _messageCountsByDayOfWeek;
  Map<int, int> _messageCountsByHourOfDay;

  SmsManager() {
    _loadedThreadsById = new Map();
    _messageCountsByDayOfWeek = new Map();
    _messageCountsByHourOfDay = new Map();

    for (int i = 1; i <= 7; i++) {
      _messageCountsByHourOfDay[i] = 0;
      _messageCountsByDayOfWeek[i] = 0;
    }
  }

  SmsThread getThreadById(int id) {
    return _loadedThreadsById[id];
  }

  List<SmsMessage> getMessagesByThreadId(int id) {
    return _loadedThreadsById[id]?.messages;
  }
  
  List<SmsMessage> getMessagesByThread(SmsThread thread) {
    return getMessagesByThreadId(thread.id);
  }

  List<SmsThread> getThreads() {
    return _loadedThreadsById.values.toList();
  }

  int getThreadCount() {
    return _loadedThreadsById.length;
  }

  Future loadAllMessages({ bool loadContacts = true, void onProgress({ int current, int total }) }) async {
    if (_query == null) {
      _query = new SmsQuery();
    }

    List<SmsMessage> messages = await _query.querySms(
      sort: false,
      kinds: SmsManager.allSmsTypes
    );

    int totalMessages = messages.length;
    for (int i = 0; i < totalMessages; i++) {
      SmsMessage message = messages[i];

      if (onProgress != null) {
        onProgress(
          current: i + 1,
          total: totalMessages
        );
      }

      if (!_loadedThreadsById.containsKey(message.threadId)) {
        _loadedThreadsById[message.threadId] = new SmsThread(message.threadId);
      }

      _loadedThreadsById[message.threadId].addMessage(message);

      _messageCountsByHourOfDay[message.dateSent.weekday]++;
      _messageCountsByDayOfWeek[message.dateSent.weekday]++;
    }

    if (loadContacts) {
      for (SmsThread thread in _loadedThreadsById.values) {
        await thread.findContact();
      }
    }
  }

  static SmsManager getInstance() {
    if (_sharedInstance == null) {
      _sharedInstance = new SmsManager();
    }

    return _sharedInstance;
  }
}