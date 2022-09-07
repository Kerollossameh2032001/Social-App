
class LikesModel{
  late String uId;
  late String name;
  late String image;
  late bool like;
  late String color;

  LikesModel({
    required this.uId,
    required this.name,
    required this.image,
    required this.like,
    required this.color,
  });

  LikesModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    image = json['image'];
    like = json['like'];
    color = json['color'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'image': image,
      'like': like,
      'color': color,
    };
  }
}