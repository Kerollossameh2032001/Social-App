class CommentModel{
  late String uId;
  late String name;
  late String image;
  late String comment;
  late String dateTime;
  late String commentImage;
  late String commentVideo;
  late String commentDocument;
  late String commentDocumentName;
  late int commentDocumentSize;

  CommentModel({
    required this.uId,
    required this.name,
    required this.image,
    required this.comment,
    required this.dateTime,
    required this.commentImage,
    required this.commentVideo,
    required this.commentDocument,
    required this.commentDocumentName,
    required this.commentDocumentSize,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    image = json['image'];
    comment = json['comment'];
    dateTime = json['dateTime'];
    commentImage = json['commentImage'];
    commentVideo = json['commentVideo'];
    commentDocument = json['commentDocument'];
    commentDocumentName = json['commentDocumentName'];
    commentDocumentSize = json['commentDocumentSize'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'image': image,
      'comment': comment,
      'dateTime': dateTime,
      'commentImage': commentImage,
      'commentVideo': commentVideo,
      'commentDocument': commentDocument,
      'commentDocumentName': commentDocumentName,
      'commentDocumentSize': commentDocumentSize,
    };
  }
}