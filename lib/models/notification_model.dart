class NotificationModel{
  late String uId;
  late String body;
  late String dateTime;

  NotificationModel({
    required this.uId,
    required this.body,
    required this.dateTime,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    body = json['body'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'body': body,
      'dateTime': dateTime,
    };
  }
}