import 'package:flutter/material.dart';

class SubscriptionController extends ChangeNotifier {
  final Map<String, bool> _subscriptions = {};

  bool isSubscribed(String eventName) {
    return _subscriptions[eventName] ?? false;
  }

  void toggleSubscription(String eventName) {
    _subscriptions[eventName] = !isSubscribed(eventName);
    notifyListeners();
  }
}
