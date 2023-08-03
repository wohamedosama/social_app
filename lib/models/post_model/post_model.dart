class PostModel {
  String? name;
  String? image;
  String? uId;
  String? dateTime;
  String? postImage;
  String? text;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.text,
    this.dateTime,
    this.postImage,
  });

  PostModel.fromJosn(json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    text = json['text'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'text': text,
    };
  }
}
