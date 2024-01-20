import 'package:flutter/foundation.dart';

class NotificationProvider with ChangeNotifier {
  int _notificationCount = 0;

  int get notificationCount => _notificationCount;

  void incrementNotification() {
    _notificationCount++;
    notifyListeners();
  }
}
