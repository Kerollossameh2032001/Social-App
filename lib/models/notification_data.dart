import 'package:flutter/material.dart';

class NotificationSenderData {
  late String to;
  late NotificationData notification;
  late Data data;

  NotificationSenderData({
    required this.to,
    required this.notification,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'to': to,
      'notification': notification.toMap(),
      'data': data.toMap(),
    };
  }
}

class Data {
  late String uId;
  late String body;
  late String dateTime;

  Data({
    required this.uId,
    required this.body,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'body': body,
      'dateTime': dateTime,
    };
  }
}

class NotificationData {
  late String title;
  late String body;

  NotificationData({
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }
}
