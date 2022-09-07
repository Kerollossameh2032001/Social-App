class MessageModel {
  late String senderId;
  late String receiverId;
  late String dateTime;
  late String message;
  late String messageImage;
  late String messageVideo;
  late String messageDocument;
  late String messageDocumentName;
  late int messageDocumentSize;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.message,
    required this.messageImage,
    required this.messageVideo,
    required this.messageDocument,
    required this.messageDocumentName,
    required this.messageDocumentSize,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    message = json['message'];
    messageImage = json['messageImage'];
    messageVideo = json['messageVideo'];
    messageDocument = json['messageDocument'];
    messageDocumentName = json['messageDocumentName'];
    messageDocumentSize = json['messageDocumentSize'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'message': message,
      'messageImage': messageImage,
      'messageVideo': messageVideo,
      'messageDocument': messageDocument,
      'messageDocumentName': messageDocumentName,
      'messageDocumentSize': messageDocumentSize,
    };
  }
}
