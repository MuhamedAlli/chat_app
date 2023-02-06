class UserModel {
  String? username;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? bio;
  String? cover;
  bool? isVerified;
  UserModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.uid,
    required this.image,
    required this.bio,
    required this.cover,
    required this.isVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    email = json["email"];
    phone = json["phone"];
    uid = json["uid"];
    image = json["image"];
    bio = json["bio"];
    cover = json["cover"];
    isVerified = json["isVerified"];
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "email": email,
      "phone": phone,
      "uid": uid,
      "image": image,
      "bio": bio,
      "cover": cover,
      "isVerified": isVerified,
    };
  }
}

class PostModel {
  String? username;
  String? uid;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  PostModel({
    required this.username,
    required this.uid,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    uid = json["uid"];
    image = json["image"];
    dateTime = json["dateTime"];
    text = json["text"];
    postImage = json["postImage"];
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "uid": uid,
      "image": image,
      "dateTime": dateTime,
      "text": text,
      "postImage": postImage,
    };
  }
}

class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json["senderId"];
    receiverId = json["receiverId"];
    dateTime = json["dateTime"];
    text = json["text"];
  }

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "dateTime": dateTime,
      "text": text,
    };
  }
}