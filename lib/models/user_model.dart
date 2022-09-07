import 'package:social_app1/models/story_model.dart';

class UserModel {
  late String uId;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String coverImage;
  late String bio;
  late String token;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.coverImage,
    required this.bio,
    required this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    coverImage = json['coverImage'];
    bio = json['bio'];
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'coverImage': coverImage,
      'bio': bio,
      'token': token,
    };
  }
}
