class PostModel {
  late String uId;
  late String name;
  late String image;
  late String postImage;
  late String postVideo;
  late String postDocument;
  late String? postDocumentName;
  late int? postDocumentSize;
  late String text;
  late String dateTime;

  PostModel({
    required this.uId,
    required this.name,
    required this.image,
    required this.postImage,
    required this.postVideo,
    required this.postDocument,
    this.postDocumentName,
    this.postDocumentSize,
    required this.text,
    required this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    image = json['image'];
    postImage = json['postImage'];
    postVideo = json['postVideo'];
    postDocument = json['postDocument'];
    postDocumentName = json['postDocumentName'];
    postDocumentSize = json['postDocumentSize'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'image': image,
      'postImage': postImage,
      'postVideo': postVideo,
      'postDocument': postDocument,
      'postDocumentName': postDocumentName,
      'postDocumentSize': postDocumentSize,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
