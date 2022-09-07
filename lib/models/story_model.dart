class StoryModel{
  late String uId;
  late String storyText;
  late String storyDateTime;
  late String storyImage;
  late String storyVideo;


  StoryModel({
    required this.uId,
    required this.storyText,
    required this.storyDateTime,
    required this.storyImage,
    required this.storyVideo,
  });

  StoryModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    storyText = json['storyText'];
    storyDateTime = json['storyDateTime'];
    storyImage = json['storyImage'];
    storyVideo = json['storyVideo'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'storyText': storyText,
      'storyDateTime': storyDateTime,
      'storyImage': storyImage,
      'storyVideo': storyVideo,
    };
  }

}