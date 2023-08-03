import 'dart:core';

class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEMailVerified;
  String? image;
  String? bio;
  String? cover;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEMailVerified,
    this.image,
    this.bio,
    this.cover,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEMailVerified = json['isEMailVerified'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'isEMailVerified': isEMailVerified,
      'image': image,
      'bio': bio,
      'cover': cover,
    };
  }
}
